From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Paul Loo" <PaulL@comglobal.com>, <SELinux@tycho.nsa.gov>
Subject: Re: How to get rid of avc denied messages
Date: Tue, 3 Jun 2003 10:08:23 +1000
References: <DB4BA538D0DA21479C610B2466EEF64616273E@sjmail.global.com>
In-Reply-To: <DB4BA538D0DA21479C610B2466EEF64616273E@sjmail.global.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306031008.23712.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 3 Jun 2003 03:15, Paul Loo wrote:
> un  2 17:07:22 gfcp kernel: avc:  denied  { read write } for  pid=1723
> exe=/usr/sbin/sshd path=/dev/ptmx dev=03:01 ino=14202
> scontext=system_u:system_r:sshd_t tcontext=system_u:object_r:file_t
> tclass=chr_file

Apparently /dev is on the root file system which is /dev/hda1.  This file 
system apparently has not been properly labeled, /dev/ptmx should have the 
context system_u:object_r:ptmx_t.

Run "make relabel" from your policy directory.

> Jun  2 17:07:22 gfcp kernel: avc:  denied  { write } for  pid=1725
> exe=/usr/sbin/sshd path=/var/run/utmp dev=03:01 ino=28697
> scontext=system_u:system_r:sshd_t
> tcontext=system_u:object_r:init_var_run_t tclass=file

/var/run/utmp should have context system_u:object_r:initrc_var_run_t.  It 
appears that at boot time your machine had no /var/run/utmp file and the init 
process recreated it (which resulted in it having the wrong context).  For 
Familiar I solved this by relabeling the file during the boot process.

Perhaps we don't need to have an init_var_run_t and we could have it use 
initrc_var_run_t.

> Jun  2 17:07:22 gfcp kernel: avc:  denied  { read write } for  pid=1726
> exe=/bin/bash path=/dev/tty dev=03:01 ino=27191
> scontext=system_u:system_r:user_t tcontext=system_u:object_r:file_t
> tclass=chr_file

Again /dev isn't labeled properly.

> Jun  2 17:07:29 gfcp kernel: avc:  denied  { write } for  pid=1751
> exe=/bin/su path=/var/run/utmp dev=03:01 ino=28697
> scontext=tcip:user_r:user_su_t tcontext=system_u:object_r:init_var_run_t
> tclass=file

Again it should be initrc_var_run_t.

> Jun  2 17:07:29 gfcp kernel: avc:  denied  { write } for  pid=1751
> exe=/bin/su path=/dev/log dev=03:01 ino=28395
> scontext=tcip:user_r:user_su_t tcontext=system_u:object_r:file_t
> tclass=sock_file

Looks like the /dev directory is not labeled and therefore the /dev/log socket 
didn't get assigned the correct label when it was created.  Relabel the root 
file-system and reboot and things should be a lot better.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
