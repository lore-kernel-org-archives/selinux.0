Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8BCoUuo019607
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2008 08:50:30 -0400
Received: from vidle.i.cz (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8BCnj7Q020868
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2008 12:49:46 GMT
Date: Thu, 11 Sep 2008 14:50:25 +0200
From: =?iso-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: Justin Mattock <justinmattock@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Hong <kindloaf@gmail.com>,
        tresys <refpolicy@oss.tresys.com>
Subject: Re: [refpolicy] ssh issue with latest policy
Message-ID: <20080911125025.GA5448@bobek.pm.i.cz>
References: <dd18b0c30809101232la13c43mee3d9ab0bfe2f509@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dd18b0c30809101232la13c43mee3d9ab0bfe2f509@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 10, 2008 at 12:32:31PM -0700, Justin Mattock wrote:
> Hong,
> I cant seem to locate the post you sent a few days ago
> about logging into ssh. anyways I finally got around to logging into
> my machines with both the latest kernel and refpolicy;
> there was difficulty due to having /etc/host and /etc/sysctl.conf
> variables in these files preventing me from logging in.
> So with that in mind check and make sure those files
> are cleared of anything that might cause an error.
> As for the policy itself they were both in permissive mode
> via boot param, so having /etc/selinux/config in enforcing
> didnt cause an ubstruction for me.
> hope this helps.

May be. And Hong not replied yet if he did relabel the file system. :)

I have tried to restart sshd with nonsense context to show the problem
even with PERMISSIVE mode of SE Linux!

sid:~# sestatus
SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   permissive
Mode from config file:          enforcing
Policy version:                 23
Policy from config file:        default

sid:~# runcon sysadm_u:sysadm_r:sysadm_t:s0 /etc/init.d/ssh restart

sid:~# ps -H -Z -C sshd
LABEL                             PID TTY          TIME CMD
sysadm_u:sysadm_r:sysadm_t:s0    1944 ?        00:00:00 sshd
system_u:system_r:sshd_t:s0-s0:c0.c1023 1808 ? 00:00:00 sshd
system_u:system_r:sshd_t:s0-s0:c0.c1023 1810 ? 00:00:00   sshd

That is the new parent process sshd running with sysadm_u:sysadm_r:sysadm_t:s0.

zito@bobek:~$ ssh sid
Read from remote host sid: Connection reset by peer
Connection to sid closed.

sid:~# tail -2 /var/log/syslog
Sep 11 14:32:18 sid kernel: [  649.880210] sshd[1954]: segfault at 2 ip b7ad5cea sp bfc2b04c error 4 in libc-2.7.so[b7a60000+155000]
Sep 11 14:32:18 sid kernel: [  649.883080] type=1701 audit(1221136338.451:27): auid=4294967295 uid=1000 gid=1000 ses=4294967295 subj=sysadm_u:sysadm_r:sysadm_t:s0 pid=1954 comm="sshd" sig=11


This is mature for bug report on openssh.
Conclusion: Running SE Linux in permissive mode can't prevent you from
all SE Linux problems every time! (in most cases yes of course :)

-- 
Zito

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
