From: azeredo@qmc.ufsc.br
Message-ID: <1037722529.3dda63a114991@qmc.ufsc.br>
Date: Tue, 19 Nov 2002 14:15:29 -0200
To: SELinux@tycho.nsa.gov
Subject: Still problems with RedHat8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


    Hi guys,


   I went out in a trip for some days and when I got back I tested your sugestions.
   First I run selinux in enforcing mode and couldn't find out which script was trying to write to /etc/passwd. But after booting I tryed a make relabel a got the error message:



avc:  denied  { read } for  pid=666 exe=/usr/local/selinux/bin/checkpolicy path=/usr/src/selinux/policy/Makefile dev=03:05 ino=882701 scontext=root:sysadm_r:checkpolicy_t tcontext=system_u:object_r:src_t tclass=file
/usr/local/selinux/bin/setfiles file_contexts/file_contexts `mount | awk '/(ext[23]|reiserfs)/{print $3}'`
/usr/local/selinux/bin/setfiles:  Running on a SELinux kernel, using new system
calls

avc:  denied  { read } for  pid=667 exe=/usr/local/selinux/bin/setfiles path=/usr/src/selinux/policy/file_contexts/file_contexts dev=03:05 ino=883914 scontext=root:sysadm_r:setfiles_t
tcontext=system_u:object_r:src_t tclass=file
file_contexts/file_contexts: Permission denied
make: *** [relabel] Error 1

   
   Finally when I run dmesg I got a lot of error messages:
   Aren't them too much?
   I actually know how correct some errors by granting additional permissions to some domains but I have doubts about doing this or adding new domains and etc...   I've already run newrule.pl on dmesg a got many alterations hints. What is the right approach?


avc:  denied  { write } for  pid=109 exe=/bin/rm path=/halt dev=03:05 ino=571 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:file_t tclass=file

avc:  denied  { read } for  pid=129 exe=/sbin/pam_console_apply path=/dev/video dev=03:05 ino=65803 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:v4l_device_t tclass=dir

avc:  denied  { setattr } for  pid=129 exe=/sbin/pam_console_apply path=/dev/video0 dev=03:05 ino=40383 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:v4l_device_t tclass=chr_file

avc:  denied  { setattr } for  pid=129 exe=/sbin/pam_console_apply path=/dev/video1 dev=03:05 ino=40384 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:v4l_device_t tclass=chr_file

avc:  denied  { setattr } for  pid=129 exe=/sbin/pam_console_apply path=/dev/video1394 dev=03:05 ino=40385 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:v4l_device_t tclass=chr_file

avc:  denied  { setattr } for  pid=129 exe=/sbin/pam_console_apply path=/dev/video2 dev=03:05 ino=40386 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:v4l_device_t tclass=chr_file

avc:  denied  { setattr } for  pid=129 exe=/sbin/pam_console_apply path=/dev/video3 dev=03:05 ino=40387 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:v4l_device_t tclass=chr_file

avc:  denied  { read } for  pid=129 exe=/sbin/pam_console_apply path=/dev/radio dev=03:05 ino=34957 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:v4l_device_t tclass=lnk_file

avc:  denied  { setattr } for  pid=129 exe=/sbin/pam_console_apply path=/dev/radio0 dev=03:05 ino=34958 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:v4l_device_t tclass=chr_file

avc:  denied  { write } for  pid=382 exe=/bin/bash path=/etc/passwd dev=03:05 ino=231078 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:etc_t tclass=file

avc:  denied  { write } for  pid=500 exe=/bin/bash path=/etc/passwd dev=03:05 ino=231078 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:etc_t tclass=file

avc:  denied  { write } for  pid=577 exe=/bin/rm path=/tmp/.font-unix/fs7100 dev=03:05 ino=180181 scontext=system_u:system_r:initrc_t tcontext=system_u:object_r:xfs_tmp_t tclass=sock_file

avc:  denied  { read } for  pid=666 exe=/usr/local/selinux/bin/checkpolicy path=/usr/src/selinux/policy/Makefile dev=03:05 ino=882701 scontext=root:sysadm_r:checkpolicy_t tcontext=system_u:object_r:src_t tclass=file

avc:  denied  { read } for  pid=667 exe=/usr/local/selinux/bin/setfiles path=/usr/src/selinux/policy/file_contexts/file_contexts dev=03:05 ino=883914 scontext=root:sysadm_r:setfiles_t tcontext=system_u:object_r:src_t tclass=file

avc:  denied  { read } for  pid=674 exe=/usr/local/selinux/bin/checkpolicy path=/usr/src/selinux/policy/Makefile dev=03:05 ino=882701 scontext=root:sysadm_r:checkpolicy_t tcontext=system_u:object_r:src_t tclass=file

avc:  denied  { read } for  pid=675 exe=/usr/local/selinux/bin/setfiles path=/usr/src/selinux/policy/file_contexts/file_contexts dev=03:05 ino=883914 scontext=root:sysadm_r:setfiles_t tcontext=system_u:object_r:src_t tclass=file

avc:  denied  { mknod } for  pid=692 comm=X capability=27 scontext=root:sysadm_r:sysadm_xserver_t tcontext=root:sysadm_r:sysadm_xserver_t tclass=capability

avc:  denied  { write } for  pid=695 exe=/sbin/insmod path=/sys/kernel/tainted dev=00:02 ino=4144 scontext=root:sysadm_r:sysadm_xserver_t tcontext=system_u:object_r:sysctl_kernel_t tclass=file

avc:  denied  { sys_module } for  pid=695 comm=modprobe capability=16 scontext=root:sysadm_r:sysadm_xserver_t tcontext=root:sysadm_r:sysadm_xserver_t tclass=capability

avc:  denied  { write } for  pid=696 exe=/sbin/insmod path=/sys/kernel/tainted dev=00:02 ino=4144 scontext=root:sysadm_r:sysadm_xserver_t tcontext=system_u:object_r:sysctl_kernel_t tclass=file

avc:  denied  { sys_module } for  pid=696 comm=modprobe capability=16 scontext=root:sysadm_r:sysadm_xserver_t tcontext=root:sysadm_r:sysadm_xserver_t tclass=capability

avc:  denied  { read write } for  pid=692 exe=/usr/X11R6/bin/XFree86 path=/dev/input/mice dev=03:05 ino=799982 scontext=root:sysadm_r:sysadm_xserver_t tcontext=system_u:object_r:device_t tclass=chr_file

avc:  denied  { search } for  pid=692 exe=/usr/X11R6/bin/XFree86 path=/root/.gnome2 dev=03:05 ino=426603 scontext=root:sysadm_r:sysadm_xserver_t tcontext=system_u:object_r:sysadm_home_t tclass=dir

avc:  denied  { execute } for  pid=742 exe=/sbin/insmod path=/bin/bash dev=03:05 ino=865019 scontext=system_u:system_r:insmod_t tcontext=system_u:object_r:shell_exec_t tclass=file
Assertion failed! buffer != NULL,via82cxxx_audio.c,via_dsp_write,line=2308

avc:  denied  { read } for  pid=745 exe=/usr/X11R6/bin/xscreensaver path=/etc/shadow dev=03:05 ino=230216 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:shadow_t tclass=file

avc:  denied  { read } for  pid=745 exe=/usr/X11R6/bin/xscreensaver path=/etc/shadow dev=03:05 ino=230216 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:shadow_t tclass=file

avc:  denied  { read } for  pid=751 exe=/usr/bin/magicdev path=/dev/hdd dev=03:05 ino=33539 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:fixed_disk_device_t tclass=blk_file

avc:  denied  { execute } for  pid=755 exe=/usr/bin/gnome-session path=/usr/share/rhn/rhn_applet/applet.py dev=03:05 ino=833120 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:usr_t tclass=file

avc:  denied  { read write } for  pid=767 exe=/usr/bin/gnome-terminal path=/dev/ptyp0 dev=03:05 ino=34775 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:device_t tclass=chr_file

avc:  denied  { read write } for  pid=767 exe=/usr/bin/gnome-terminal path=/dev/ptyp1 dev=03:05 ino=34776 scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:device_t tclass=chr_file


                          Thank you.
                             
                               Mathematics Department
                               UFSC
                               Campus Universitário
                               Prof. Aldrovando Azeredo

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
