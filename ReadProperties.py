# coding: utf-8
import configparser


class ReadProperties:
    def __init__(self, configfile, section):
        config_ini = configparser.ConfigParser()
        config_ini.read(configfile, encoding='utf-8')
        self.config = config_ini[section]

    @property
    def ssh_port(self):
        return self.config.get('SSH_PORT')

    @property
    def key_path(self):
        return self.config.get('KEY_PATH')

    @property
    def user_name(self):
        return self.config.get('USER_NAME')

    @property
    def host_name(self):
        return self.config.get('HOST_NAME')

    @property
    def minecraft_version(self):
        return self.config.get('MINECRAFT_VERSION')
