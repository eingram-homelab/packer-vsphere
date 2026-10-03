# Cleans all audit logs.
echo '> Cleaning all audit logs ...'
if [ -f /var/log/audit/audit.log ]; then
  sudo truncate -s 0 /var/log/audit/audit.log
fi
if [ -f /var/log/wtmp ]; then
  sudo truncate -s 0 /var/log/wtmp
fi
if [ -f /var/log/lastlog ]; then
  sudo truncate -s 0 /var/log/lastlog
fi

# Cleans persistent udev rules
echo '> Cleaning persistent udev rules'
if [ -f /etc/udev/rules.d/70-persistent-net.rules ]; then
  sudo rm /etc/udev/rules.d/70-persistent-net.rules
fi

# Cleans /tmp directories
echo '> Cleaning /tmp directories'
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

# Cleans SSH keys
echo '> Cleaning SSH keys'
sudo rm -f /etc/ssh/ssh_host_*

# Sets hostname to localhost
echo '> Setting hostname to localhost'
sudo truncate -s 0 /etc/hostname
sudo hostnamectl set-hostname localhost

# Cleans the machine-id.
echo '> Cleaning the machine-id'
sudo truncate -s 0 /etc/machine-id
sudo rm /var/lib/dbus/machine-id
sudo ln -s /etc/machine-id /var/lib/dbus/machine-id

# Cleans shell history.
echo '> Cleaning shell history'
history -cw
sudo echo > ~/.bash_history
sudo rm -fr /root/.bash_history