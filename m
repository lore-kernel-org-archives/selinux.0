Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n24BLTUR002057
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 06:21:29 -0500
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n24BLRBp027612
	for <selinux@tycho.nsa.gov>; Wed, 4 Mar 2009 11:21:28 GMT
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id E45AE18097
	for <selinux@tycho.nsa.gov>; Wed,  4 Mar 2009 22:21:24 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 9CDCC21028
	for <selinux@tycho.nsa.gov>; Wed,  4 Mar 2009 22:21:22 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Re: gnome and dbus
Date: Wed, 4 Mar 2009 22:21:17 +1100
References: <200903042204.34105.russell@coker.com.au>
In-Reply-To: <200903042204.34105.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903042221.21717.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 4 Mar 2009, Russell Coker <russell@coker.com.au> wrote:
> type=AVC msg=audit(1236164018.240:156): avc:  denied  { execute_no_trans }
> for pid=6554 comm="dbus-daemon"
> path="/usr/lib/gnome-vfs-2.0/gnome-vfs-daemon" dev=hda2 ino=393873
> scontext=unconfined_u:unconfined_r:system_dbusd_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:lib_t:s0 tclass=file
>
> So what would this gnome-vfs-daemon program be and why would a dbus-daemon
> process be running it?

Also for reference I get the same from the user_r role.

type=AVC msg=audit(1236165516.836:2178): avc:  denied  { execute_no_trans } 
for  pid=8208 comm="dbus-daemon" 
path="/usr/lib/gnome-vfs-2.0/gnome-vfs-daemon" dev=hda2 ino=393873 
scontext=user_u:user_r:user_dbusd_t:s0 tcontext=system_u:object_r:lib_t:s0 
tclass=file
type=SYSCALL msg=audit(1236165516.836:2178): arch=40000003 syscall=11 
success=no exit=-13 a0=b9047898 a1=b9045fe0 a2=b9048ef8 a3=b9048c58 items=0 
ppid=8207 pid=8208 auid=4294967295 uid=1001 gid=1001 euid=1001 suid=1001 
fsuid=1001 egid=1001 sgid=1001 fsgid=1001 tty=(none) ses=4294967295 
comm="dbus-daemon" exe="/usr/bin/dbus-daemon" 
subj=user_u:user_r:user_dbusd_t:s0 key=(null)

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
