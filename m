Message-ID: <B51F0C636E578A4E832D3958690CD73EBB102D@es04snlnt>
From: "Davies, James E" <jedavie@sandia.gov>
To: "'Selinux@tycho.nsa.gov'" <Selinux@tycho.nsa.gov>
Subject: new selinux install
Date: Thu, 9 May 2002 07:38:08 -0600
MIME-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've just installed the selinux 2.4.(18) kernel on redhat 7.2 from the nsa
site and have the following problems. All I've done so far is to add 2
users. I have not modified any context or .te files yet.

ps -e --context returns the following:

 PID    SID CONTEXT                                  COMMAND
   1      1 system_u:system_r:kernel_t               init [3]
   2      1 system_u:system_r:kernel_t               [keventd]
   3      1 system_u:system_r:kernel_t               [ksoftirqd_CPU0]
   4      1 system_u:system_r:kernel_t               [kswapd]
   5      1 system_u:system_r:kernel_t               [bdflush]
   6      1 system_u:system_r:kernel_t               [kupdated]
   9      1 system_u:system_r:kernel_t               [khubd]
  10      1 system_u:system_r:kernel_t               [kjournald]
 135      1 system_u:system_r:kernel_t               [kjournald]
 136      1 system_u:system_r:kernel_t               [kjournald]
 137      1 system_u:system_r:kernel_t               [kjournald]
 138      1 system_u:system_r:kernel_t               [kjournald]
 533      1 system_u:system_r:kernel_t               syslogd -m 0
 538      1 system_u:system_r:kernel_t               klogd -2
 558      1 system_u:system_r:kernel_t               portmap
 586      1 system_u:system_r:kernel_t               rpc.statd
 737      1 system_u:system_r:kernel_t               /usr/sbin/sshd
 770      1 system_u:system_r:kernel_t               xinetd -stayalive
-reuse -
 810      1 system_u:system_r:kernel_t               sendmail: accepting
connec
 829      1 system_u:system_r:kernel_t               gpm -t ps/2 -m
/dev/mouse
 847      1 system_u:system_r:kernel_t               crond
 899      1 system_u:system_r:kernel_t               xfs -droppriv -daemon
 935      1 system_u:system_r:kernel_t               /usr/sbin/atd
 943      1 system_u:system_r:kernel_t               /sbin/mingetty tty2
 944      1 system_u:system_r:kernel_t               /sbin/mingetty tty3
 945      1 system_u:system_r:kernel_t               /sbin/mingetty tty4
 946      1 system_u:system_r:kernel_t               /sbin/mingetty tty5
 947      1 system_u:system_r:kernel_t               /sbin/mingetty tty6
1047      1 system_u:system_r:kernel_t               /sbin/mingetty tty1
1048      1 system_u:system_r:kernel_t               in.telnetd: 172.16.1.18
1049      1 system_u:system_r:kernel_t               login -- jedavie
1050    138 jedavie:sysadm_r:sysadm_t                -bash
1087    138 jedavie:sysadm_r:sysadm_t                ps -e --context

Most of the processes are labeled as type kernel_t with a sid of 1. I
suppose this means they're not transitioning to their proper domain.
AVC_toggle to enforcing mode hangs the system console session, forcing a
reboot.

/var/log/messages show the following:(partial file immediately after reboot)

May  9 04:47:03 bilbo kernel: security:  6 users, 5 roles, 406 types
May  9 04:47:03 bilbo kernel: security:  29 classes, 43869 rules
May  9 04:47:03 bilbo kernel: task_precondition:  assigning context
system_u:sys
tem_r:kernel_t to pid 0 exe=none
May  9 04:47:03 bilbo kernel: task_precondition:  assigning context
system_u:sys
tem_r:kernel_t to pid 1 exe=none
May  9 04:47:03 bilbo kernel: Freeing unused kernel memory: 248k freed
May  9 04:47:03 bilbo kernel:
May  9 04:47:03 bilbo kernel: avc:  denied  { read write } for  pid=1
path=/dev/
console dev=48:06 ino=8241 scontext=system_u:system_r:kernel_t
tcontext=system_u
:object_r:file_t tclass=chr_file
May  9 04:47:04 bilbo kernel:
May  9 04:47:04 bilbo kernel: avc:  denied  { execute } for  pid=1
path=/sbin/in
it dev=48:06 ino=71490 scontext=system_u:system_r:kernel_t
tcontext=system_u:obj
ect_r:file_t tclass=file
May  9 04:47:04 bilbo kernel:
May  9 04:47:04 bilbo kernel: avc:  denied  { execute_no_trans } for  pid=1
path
=/sbin/init dev=48:06 ino=71490 scontext=system_u:system_r:kernel_t
tcontext=sys
tem_u:object_r:file_t tclass=file
May  9 04:47:04 bilbo kernel:

t path=/dev/initctl dev=48:06 ino=23412 scontext=system_u:system_r:kernel_t
tcon
text=system_u:object_r:file_t tclass=fifo_file


init path=/dev/initctl dev=48:06 ino=23412
scontext=system_u:system_r:kernel_t t
context=system_u:object_r:file_t tclass=fifo_file

Any ideas or help as to how to track down this problem  would be greatly
appreciated.
Thanks,
Jim


Jim Davies                        
Sandia National Laboratories
jedavie@sandia.gov 
Voice (505)845-8374
Pager (505)540-6179
FAX (505)844-4568





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
