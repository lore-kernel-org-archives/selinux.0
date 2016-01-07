Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u07KakR3008055
 for <selinux@tycho.nsa.gov>; Thu, 7 Jan 2016 15:36:46 -0500
Received: by mail-wm0-f45.google.com with SMTP id f206so112029636wmf.0
 for <selinux@tycho.nsa.gov>; Thu, 07 Jan 2016 12:36:22 -0800 (PST)
Received: from [192.168.0.10] (89-156-121-7.rev.numericable.fr. [89.156.121.7])
 by smtp.googlemail.com with ESMTPSA id
 gl10sm102493041wjb.30.2016.01.07.12.36.19 for <selinux@tycho.nsa.gov>
 (version=TLSv1/SSLv3 cipher=OTHER);
 Thu, 07 Jan 2016 12:36:19 -0800 (PST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Labeling nsfs filesystem
To: selinux@tycho.nsa.gov
Message-ID: <568ECC43.40500@m4x.org>
Date: Thu, 7 Jan 2016 21:36:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

Since Linux 3.19 targets of /proc/PID/ns/* symlinks have lived in a fs
separated from /proc, named nsfs [1].  These targets are used to enter
the namespace of another process by using setns() syscall [2].  On old
kernels, they were labeled with procfs default type (for example
"getfilecon /proc/self/ns/uts" returned system_u:object_r:proc_t:s0).
When using a recent kernel with a policy without nsfs support, the
inodes are not labeled, as reported for example in Fedora bug #1234757
[3].  As I encounter this issue on my systems, I asked yesterday on the
refpolicy ML how nsfs inodes should be labeled [4].

After digging a little bit about the possibilities, here is a summary of
the options I have considered so far.

Option 1: define a new type to label nsfs inodes, nsfs_t.  This works as
expected (c.f. [5] for more details).

Option 2: "fs_use_task nsfs gen_context(system_u:object_r:fs_t,s0);".
Even though this works well for /proc/self/ns/*, this behaves in a weird
way with other processes in the initial namespaces. Here is a shell
session with such a configuration (on a system running in permissive mode):

  # runcon system_u:system_r:init_t sleep 1000000&
  [1] 26633
  # ls -lZ /proc/26633/ns/uts
  lrwxrwxrwx. 1 root root system_u:system_r:init_t 0 Jan  7 19:49
  /proc/26633/ns/uts -> uts:[4026531838]
  # getfilecon /proc/26633/ns/uts
  /proc/26633/ns/uts sysadm_u:sysadm_r:sysadm_t
  # runcon user_u:user_r:user_t getfilecon /proc/26633/ns/uts
  /proc/26633/ns/uts user_u:user_r:user_t

In short, nsfs inodes get created with the context of the running task.
This is because the inodes do not exist before getfilecon() opens them
(c.f. ns_get_path() function in fs/nsfs.c [6] and
inode_doinit_with_dentry() in security/selinux/hooks.c, which does
"isec->sid = current_sid()" in SECURITY_FS_USE_TASK case [7]).  This
issue does not appear with Docker and the network namespace used by
systemd services for PrivateNetwork feature because a file descriptor to
the network namespace is kept open, so the inode is created by the task
"owning" the namespace and its label is stable.


Option 3: do not add anything in the policy and add
"security_task_to_inode(task, inode);" right after the inode
initialization in ns_get_path() (line 90 of [6]), which is what /proc
uses to make /proc/PID inodes have the context of their tasks.  Then
"getfilecon /proc/PID/ns/uts" returns the context of task PID (and not
the context that is used by getfilecon command), but as this inode is
per-namespace and not per-task, there can be situations like this:

  # id -Z ; getfilecon /proc/self/ns/uts
  sysadm_u:sysadm_r:sysadm_t
  /proc/self/ns/uts sysadm_u:sysadm_r:sysadm_t

  # runcon 'user_u:user_r:user_t' bash -c 'exec 3</proc/self/ns/uts &&
  sleep 100000' & P=$!
  [1] 803

  # ls -lZ "/proc/$P/fd/3"
  lr-x------. 1 root root user_u:user_r:user_t 64 Jan  6 23:17
  /proc/803/fd/3 -> uts:[4026531838]

  # getfilecon "/proc/$P/fd/3" "/proc/$P/ns/uts"
  /proc/803/fd/3   user_u:user_r:user_t
  /proc/803/ns/uts user_u:user_r:user_t

  # getfilecon /proc/self/ns/uts
  /proc/self/ns/uts user_u:user_r:user_t

  # fg
  ^C
  # getfilecon /proc/self/ns/uts
  /proc/self/ns/uts sysadm_u:sysadm_r:sysadm_t

So in fact each /proc/self/ns/* symlink target is labeled accordingly to
the first process which opened it.  I do not know whether this behaviour
fits with the "real world usage" of namespaces (e.g. with containers) or
can be considered as a side effect which can be ignored.


Option 4 (not tested): add a sid field to struct ns_common and make
every namespace labeled from the process which creates it, maybe with a
type transition mechanism. This would be quite heavy to handle.


How should nsfs be handled in the kernel and in SELinux policy?

Cheers,
Nicolas

[1] Since commit
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=e149ed2b805fefdccf7ccdfc19eca22fdd4514ac
[2] http://man7.org/linux/man-pages/man2/setns.2.html
[3] https://bugzilla.redhat.com/show_bug.cgi?id=1234757
[4] http://oss.tresys.com/pipermail/refpolicy/2016-January/007836.html
[5] http://oss.tresys.com/pipermail/refpolicy/2016-January/007839.html
[6]
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/fs/nsfs.c?h=v4.4-rc8#n47
[7]
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/security/selinux/hooks.c?h=v4.4-rc8#n1417
