Subject: setfiles vs getfilecon
From: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
To: SELinux <SELinux@tycho.nsa.gov>
Cc: Colin Walters <walters@debian.org>, Russell Coker <russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-2
Date: 18 Feb 2004 11:32:14 +0100
Message-Id: <1077100334.5360.12.camel@kusturica>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

It seems there is some inconsistency in computing the label of a
symlink between setfiles and [sg]etfilecon.

root@szoketto-TCB:~# setfiles -nv /etc/security/selinux/none.contexts /
|grep libpam.so
setfiles:  relabeling /lib/libpam.so.0 from kernel_u:object_r:tcb_mod_t
to object_u:object_r:tcb_exec_t
root@szoketto-TCB:~# getfilecon /lib/libpam.so.0*
/lib/libpam.so.0        object_u:object_r:tcb_exec_t
/lib/libpam.so.0.77     object_u:object_r:tcb_exec_t
root@szoketto-TCB:~# setfiles -nv /etc/security/selinux/none.contexts /
|grep libpam.so
setfiles:  relabeling /lib/libpam.so.0 from kernel_u:object_r:tcb_mod_t
to object_u:object_r:tcb_exec_t
root@szoketto-TCB:~# ls -l /lib/libpam.so.0*
lrwxrwxrwx    1 root     root           14 Feb 17 09:54 /lib/libpam.so.0
-> libpam.so.0.77
-rw-r--r--    1 root     root        31352 Feb 17 09:49
/lib/libpam.so.0.77
oot@szoketto-TCB:~# dpkg -S setfiles getfilecon
policycoreutils: /usr/share/man/man8/setfiles.8.gz
policycoreutils: /usr/sbin/setfiles
selinux-utils: /usr/bin/getfilecon
root@szoketto-TCB:~# dpkg -l policycoreutils selinux-utils
Desired=Unknown/Install/Remove/Purge/Hold
|
Status=Not/Installed/Config-files/Unpacked/Failed-config/Half-installed
|/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err:
uppercase=bad)
||/ Name                         Version                     
Description
+++-============================-============================-========================================================================
ii  policycoreutils              1.4-3                        SELinux
core policy utilities
ii  selinux-utils                1.4-0.1                      SELinux
utility programs

The packages came from
deb-src http://www.coker.com.au/newselinux/ ./

-- 
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
