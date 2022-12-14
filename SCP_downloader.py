# coding: utf-8
import paramiko
from scp import SCPClient
import sys


def main(args):
    if len(args) == 7:
        port = args[1]
        key = args[2]
        user = args[3]
        host = args[4]
        remote_path = args[5]
        local_path = args[6]
    else:
        print('Syntax error USAGE:')
        print('SCP_downloader.py <remote port> <key path> <remote user> <remote host> <remote path> <local '
              'path>')
        quit(1)

    with paramiko.SSHClient() as ssh:
        # set key
        rsa_key = paramiko.RSAKey.from_private_key_file(key)

        # SSH start
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(host, port, user, pkey=rsa_key, timeout=10)

        # scp start
        with SCPClient(ssh.get_transport()) as scp:
            scp.get(
                remote_path,
                local_path,
                recursive=True
            )


if __name__ == '__main__':
    main(sys.argv)
