# coding: utf-8
import datetime
import os
import subprocess
import sys
import time
from subprocess import Popen, PIPE
from ReadProperties import ReadProperties


def main(args):
    if len(args) == 4:
        dl_target: str = args[1]
        configfile: str = args[2]
        dl_mode: str = args[3]
    else:
        print('Syntax error USAGE:')
        print('Minecraft_world_data_downloader.py <DL_TARGET> <CONFIGFILE> <DLMODE>')
        quit(1)

    print('Start^^')

    # 日付の取得
    t_delta = datetime.timedelta(hours=9)
    JST = datetime.timezone(t_delta, 'JST')
    now = datetime.datetime.now(JST)
    # YYYYMMDD形式に書式化
    current_date = now.strftime('%Y%m%d')
    current_time = now.strftime('%H%M%S')

    if dl_target == '地獄鯖':
        # セクションを指定して読み込む
        props = ReadProperties(configfile, 'Jigoku')
    elif dl_target == '焼肉王':
        # セクションを指定して読み込む
        props = ReadProperties(configfile, 'Yakiniku')
    else:
        print('Invalid argument dl_target:', dl_target)
        print('Example:地獄鯖')
        exit(1)

    # ここまでで設定値読み込みOK
    print("")
    print("# Config read OK")
    print("")

    remote_path: str = R'/home/minecraft_usr/Minecraft{0}'.format(
        props.minecraft_version)
    local_path: str = 'F:\Minecraft\{0}\Minecraft{1}_{2}T{3}'.format(
        dl_target, props.minecraft_version, current_date, current_time)

    os.mkdir(local_path)

    world = 'python SCP_downloader.py {0} {1} {2} {3} {4}/world {5}'.format(
        props.ssh_port, props.key_path, props.user_name, props.host_name, remote_path, local_path)
    world_nether = 'python SCP_downloader.py {0} {1} {2} {3} {4}/world_nether {5}'.format(
        props.ssh_port, props.key_path, props.user_name, props.host_name, remote_path, local_path)
    world_the_end = 'python SCP_downloader.py {0} {1} {2} {3} {4}/world_the_end {5}'.format(
        props.ssh_port, props.key_path, props.user_name, props.host_name, remote_path, local_path)

    print(world)

    # dl_modeのs場合 直列実行
    if dl_mode == 's':
        print('Start DL: world')
        output_srt = subprocess.run(world).stdout
        print(output_srt)
        print('End DL: world')

        print('Start DL: world_nether')
        output_srt = subprocess.run(world_nether).stdout
        print(output_srt)
        print('End DL: world_nether')

        print('Start DL: world_the_end')
        output_srt = subprocess.run(world_the_end).stdout
        print(output_srt)
        print('End DL: world_the_end')

    # dl_modeのp場合 並列実行
    elif dl_mode == 'p':
        running_procs = [
            Popen(['python'], input=world,
                  stderr=PIPE, stdout=PIPE, shell=False),
            Popen(['python'], input=world_nether,
                  stderr=PIPE, stdout=PIPE, shell=False),
            Popen(['python'], input=world_the_end,
                  stderr=PIPE, stdout=PIPE, shell=False),
        ]
        while running_procs:
            for proc in running_procs:
                retcode = proc.poll()
                if retcode is not None:  # Process finished.
                    running_procs.remove(proc)
                    break
            else:  # No process is done, wait a bit and check again.
                time.sleep(.1)
                continue
        print(proc.stdout.read())
        # Here, `proc` has finished with return code `retcode`
        if retcode != 0:
            """Error handling."""
            print('error')

    # dl_modeがsでもpでもない場合にエラー処理
    else:
        print('Invalid argument dl_mode:', dl_mode, file=sys.stderr)
        print('Example:\'s\'(serial) or \'p\'(Parallel) ', file=sys.stderr)
        quit(1)

    print('End^^')


if __name__ == '__main__':
    main(sys.argv)
