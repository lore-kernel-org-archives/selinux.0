Subject: SSH not relabeling "user_u" pts's properly
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <bs-f-vazquez@bs.rd.nttdata.co.jp>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1081932262.18446.58.camel@volcano.rd.nttdata.co.jp>
Mime-Version: 1.0
Date: Wed, 14 Apr 2004 17:44:22 +0900
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Last week I decided to update my SELinux machine to the latest stable
kernel version (2.6.5). Since I am using Debian and the policy package
is outdated I made my own package using the latest upstream version. To
relabel the user files properly the new version of "genhomedircon" is
also needed, thus "policycoreutils" has to be downloaded from the
SELinux's home page (the Debian version is too old and the file_contexts
file is not generated properly).

After doing this I found out that I was no longer able to login via SSH
as a normal user in the user_t domain. The reason was that pts would not
transit to the expected "user_u:object_r:user_devpts_t" type. Instead,
it ended up with the "system_u:object_r:sshd_devpts_t" type. Under this
conditions, of course, the connection is closed right after successfully
being authenticated. Surprisingly, logins as the root user were still
working and the pts adequately relabeled as
"root:object_r:staff_devpts_t".

Since I needed to login as an unprivileged user I temporarily granted
"allow user_t sshd_devpts_t:chr_file { read write ioctl };" and started
to investigate what was going wrong. First of all I recompiled and
installed the latest version of checkpolicy, load_policy, setfiles and
pam_selinux.so, but this didn't solve anything.

After checking the policy thoroughly I could not find any bug and this
is why I would like to know if someone else is experiencing the same
problem.

Finally I would like to offer my help (if needed) to keep the Debian
packages updated.

Thanks in advance.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
