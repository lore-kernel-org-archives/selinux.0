Subject: ssh and fs relabel (new release)
From: Timothy Wood <timothy@hallcomp.com>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Date: 28 Aug 2002 09:25:00 -0400
Message-Id: <1030541100.2059.18.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I just preformed a clean install of RH7.2 and the latest lsm from the
NSA site and there seem to be a few problems.

When enforcing mode is enabled there are several things that do not work
which should.  The first of these is sshd.  sshd works fine in
permissive mode, but when in enforcing mode the following avc messages
are logged and no connection can be completed.  From the client side
authentication passes and then the connection is closed.

avc:  denied  { relabelto } for  pid=1298 exe=/usr/sbin/sshd path=/0
dev=00:06 ino=2 scontext=system_u:system_r:sshd_t
tcontext=timothy:object_r:sysadm_devpts_t tclass=chr_file

sshd[1298]: fatal: chsid(/dev/pts/0, 490) failed: Permission denied

sshd[1298]: syslogin_perform_logout: logout() returned an error

Also while in enforcing mode attempting a make relabel from the
selinux/policy directory fails with the following avc messages.

avc:  denied  { read } for  pid=1476
exe=/usr/local/selinux/bin/checkpolicy path=/src/selinux/policy/Makefile
dev=03:0b ino=1737013 scontext=root:sysadm_r:checkpolicy_t
tcontext=system_u:object_r:src_t tclass=file

avc:  denied  { read } for  pid=1477 exe=/usr/local/selinux/bin/setfiles
path=/src/selinux/policy/file_contexts/file_contexts dev=03:0b
ino=1524031 scontext=root:sysadm_r:setfiles_t
tcontext=system_u:object_r:src_t tclass=file



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
