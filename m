Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA29684
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 17:34:31 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA08609
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 22:32:31 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA08599
	for <selinux@tycho.nsa.gov>; Thu, 7 Nov 2002 22:32:30 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: azeredo@qmc.ufsc.br, selinux@tycho.nsa.gov
Subject: Re: selinux in RH8
Date: Thu, 7 Nov 2002 23:33:18 +0100
References: <1036708144.3dcae930a8fe4@qmc.ufsc.br>
In-Reply-To: <1036708144.3dcae930a8fe4@qmc.ufsc.br>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_IB988ZLIT4LH3B2RQPF0"
Message-Id: <200211072333.18908.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_IB988ZLIT4LH3B2RQPF0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Thu, 7 Nov 2002 23:29, azeredo@qmc.ufsc.br wrote:
> reboot and got only one error.
>
> avc: denied {write} for pid=396 exe=/bin/bash path=/etc/passwd dev=03:05
> ino=231078 scontext=system_u:system_r:initrc_t
> tcontext=system_u:object_r:etc_t tclass=file

Strange.  There's no good reason for a shell script to try and write to 
/etc/passwd.  I suggest that you look into this.  If you boot the machine in 
enforcing mode then the script in question will probably tell you what it was 
trying to do.

> make relabel
>
> and got the following
>
> avc:  denied  { read } for  pid=686 exe=/usr/local/selinux/bin/checkpolicy
> path=/usr/src/selinux/policy/Makefile dev=03:05 ino=882701
> scontext=root:sysadm_r:checkpolicy_t tcontext=system_u:object_r:src_t

If you have the policy source in /etc/selinux, /etc/security/selinux/source, 
/usr/share/selinux, or /usr/lib/selinux then it'll get labelled with 
policy_src_t and this won't be a problem.

> avc:  denied  { read } for  pid=687 exe=/usr/local/selinux/bin/setfiles
> path=/usr/src/selinux/policy/file_contexts/file_contexts dev=03:05
> ino=883914 scontext=root:sysadm_r:setfiles_t
> tcontext=system_u:object_r:src_t tclass=file

This should be the same as above.

> avc:  denied  { write } for  pid=687 exe=/usr/local/selinux/bin/setfiles
> path=/dev/tty1 dev=03:05 ino=39346 scontext=root:sysadm_r:setfiles_t
> tcontext=system_u:object_r:tty_device_t tclass=chr_file

The tty you used to login should not be labelled as tty_device_t, it should be 
sysadm_tty_device_t, that usually indicates a problem with your login 
program, however it assigned you the correct security context so it's 
probably working OK.  Look for any error messages in auth.log or on the 
console when you login as root.

> /usr/local/selinux/bin/setfiles:  conflicting specifications for
> /sbin/mkfs.ext3 and /sbin/mkfs.ext2, using system_u:object_r:fsadm_exec_t.

I've attached a modified fsadm.fc file to solve this and a few other issues I 
discovered while looking at it.  Steve, please commit this to CVS.

> Starting httpd:
> avc:  denied  { name_bind } for  pid=802 exe=/usr/sbin/httpd port=80
> scontext=root:sysadm_r:sysadm_t tcontext=system_u:object_r:http_port_t
> tclass=tcp_socket

Did you use run_init to start httpd?  It looks to me like you didn't.

httpd is supposed to run in domain httpd_t not domain sysadm_t.  If you type 
"httpd" at the command line you get sysadm_t, if you type the following you 
should get the right domain:
run_init /etc/init.d/apache start

>       I believe I am almost there. What is missing?
>        I read about OSDgroup and the SElinux distribution available as a
> beta version. Why there is no comment  in the list about?

There is, but maybe the message hadn't yet reached you when you asked the 
question.  It takes quite a while for a message sent to this list to get 
delivered, 5+ hour delays are not uncommon.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_IB988ZLIT4LH3B2RQPF0
Content-Type: text/plain;
  charset="iso-8859-1";
  name="fsadm.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fsadm.fc"

# fs admin utilities
/sbin/fsck.*			system_u:object_r:fsadm_exec_t
/sbin/mkfs.*			system_u:object_r:fsadm_exec_t
/sbin/e2fsck			system_u:object_r:fsadm_exec_t
/sbin/reiserfs(ck|tune)		system_u:object_r:fsadm_exec_t
/sbin/mkreiserfs		system_u:object_r:fsadm_exec_t
/sbin/e2label			system_u:object_r:fsadm_exec_t
/sbin/mkfs			system_u:object_r:fsadm_exec_t
/sbin/mke2fs			system_u:object_r:fsadm_exec_t
/sbin/mkswap			system_u:object_r:fsadm_exec_t
/sbin/scsi_info			system_u:object_r:fsadm_exec_t
/sbin/sfdisk			system_u:object_r:fsadm_exec_t
/sbin/cfdisk			system_u:object_r:fsadm_exec_t
/sbin/fdisk			system_u:object_r:fsadm_exec_t
/sbin/tune2fs			system_u:object_r:fsadm_exec_t
/sbin/dumpe2fs			system_u:object_r:fsadm_exec_t
/sbin/swapon			system_u:object_r:fsadm_exec_t
/sbin/hdparm			system_u:object_r:fsadm_exec_t
/sbin/raidstart			system_u:object_r:fsadm_exec_t
/sbin/mkraid			system_u:object_r:fsadm_exec_t
/sbin/blockdev			system_u:object_r:fsadm_exec_t
/sbin/losetup			system_u:object_r:fsadm_exec_t
/usr/sbin/updfstab		system_u:object_r:fsadm_exec_t
/usr/sbin/smart(d|ctl)		system_u:object_r:fsadm_exec_t

--------------Boundary-00=_IB988ZLIT4LH3B2RQPF0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
