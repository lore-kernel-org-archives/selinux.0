Content-Type: text/plain;
  charset="us-ascii"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: Russell Coker <russell@coker.com.au>
Subject: Your policy
Date: Thu, 10 Jul 2003 09:01:58 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <200307100901.59003.carstengrohmann@gmx.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Russel,

for my Linuxtag workshop tomorrow, I use the policy snapshot from 
your homepage.
I think you have a little mistake in your ifdef condition for 
inetd.te.
The follow lines should fix the problem:
ifdef(`inetd.te', `
ifdef(`run_ssh_inetd', `
allow inetd_t ssh_port_t:tcp_socket name_bind;
domain_auto_trans_read(inetd_t, sshd_exec_t, sshd_t)
allow sshd_t inetd_t:tcp_socket { ioctl setopt getopt getattr read 
write };
', `
allow sshd_t initrc_devpts_t:chr_file rw_file_perms;
allow sshd_t ssh_port_t:tcp_socket name_bind;
domain_auto_trans(initrc_t, sshd_exec_t, sshd_t)
'), `
allow sshd_t initrc_devpts_t:chr_file rw_file_perms;
allow sshd_t ssh_port_t:tcp_socket name_bind;
domain_auto_trans(initrc_t, sshd_exec_t, sshd_t)
')

Carsten


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
