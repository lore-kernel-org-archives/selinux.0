Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA05749
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 09:49:47 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA10331
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 13:48:09 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id NAA10291 for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 13:48:07 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id E172D92466
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 23:49:41 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 93C5D411
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 15:49:33 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: ptrace permissions
Date: Tue, 13 Aug 2002 15:49:33 +0200
MIME-Version: 1.0
Message-Id: <20020813134933.93C5D411@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

root@test:/usr/src/test/woody# ps axf --context
  PID    SID CONTEXT                                  COMMAND
31819    432 root:user_r:user_t                       -bash
31944    432 root:user_r:user_t                        \_ ps axf --context
27769    432 root:user_r:user_t                       -bash
23336    432 root:user_r:user_t                       -bash
25574    511 root:user_r:chtest_super_t                \_ ./entry
31943    512 root:user_r:chtest_t                     /sbin/syslogd
29358    512 root:user_r:chtest_t                     /usr/sbin/sshd
31789    512 root:user_r:chtest_t                      \_ /usr/sbin/sshd
31790    512 root:user_r:chtest_t                          \_ -bash
root@test:/usr/src/test/woody# id
uid=0(root) gid=0(root) groups=0(root) context=root:user_r:user_t sid=432
root@test:/usr/src/test/woody# strace -p 31943
select(1, [], NULL, NULL, NULL <unfinished ...>
root@test:/usr/src/test/woody# strace -p 29358
select(7, [4], NULL, NULL, NULL <unfinished ...>
root@test:/usr/src/test/woody# strace -p 31790
attach: ptrace(PTRACE_ATTACH, ...): Operation not permitted
root@test:/usr/src/test/woody# strace -p 31789
attach: ptrace(PTRACE_ATTACH, ...): Operation not permitted
root@test:/usr/src/test/woody# id
uid=0(root) gid=0(root) groups=0(root) context=root:user_r:user_t sid=432
root@test:/usr/src/test/woody#

I am trying to strace programs in my chroot environment.  I can trace a 
syslogd, a sshd, but the child sshd and a bash login shell it spawned are 
untracable.  Here's the AVC message:

avc:  denied  { sys_ptrace } for  pid=31984 comm=strace capability=19 
scontext=root:user_r:user_t tcontext=root:user_r:user_t tclass=capability

I'm using the latest SE Linux from the latest LSM kernel patch.

The bash process is UID!=0, but the sshd is UID==0.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
