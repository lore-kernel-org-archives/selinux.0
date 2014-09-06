Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s86GdxG7003936
 for <selinux@tycho.nsa.gov>; Sat, 6 Sep 2014 12:40:02 -0400
Received: from [192.168.0.11] (193.147.102.84.rev.sfr.net [84.102.147.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 0714F140C5703
 for <selinux@tycho.nsa.gov>; Sat,  6 Sep 2014 18:39:47 +0200 (CEST)
Message-ID: <540B38CA.5060200@m4x.org>
Date: Sat, 06 Sep 2014 18:39:38 +0200
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: selinux <selinux@tycho.nsa.gov>
Subject: SELinux Userspace Release 2014-08-26-rc2 feedback on Arch
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

I've successfully built and installed components of the SELinux
Userspace Release 2014-08-26-rc2 on my Arch Linux system.  I had some
minor issues because:

* "flex" was not up to date on my system.  This was easy to fix.
* Some Makefiles use "python" instead of "$(PYTHON)" with Python2 code.
  Doing some "sed" commands in the PKGBUILD script worked around this.
* I used LIBEXECDIR="${pkgdir}/usr/lib" but libsemanage still wanted to
  use /usr/libexec/selinux/hll/pp.  Setting compiler-directory variable
  in /etc/selinux/semanage.conf solved this issue.

Now I would like to migrate my policy to the new store.  The helper
script fails with this message:

  # /usr/lib/selinux/semanage_migrate_store
  Migrating from /etc/selinux/refpolicy-patched/modules/active to
  /var/lib/selinux/refpolicy-patched/active
  Attempting to rebuild policy from /var/lib/selinux
  sysnetwork: Warning: 'else' blocks in optional statements are
  unsupported in CIL. Dropping from output.
  Failed to resolve roletype statement at 14 of
  /var/lib/selinux/refpolicy-patched/tmp/modules/100/accountsd/cil
  Failed to resolve ast
  Traceback (most recent call last):
    File "/usr/lib/selinux/semanage_migrate_store", line 313, in
  <module>
      rebuild_policy()
    File "/usr/lib/selinux/semanage_migrate_store", line 212, in
  rebuild_policy
    rc = semanage.semanage_commit(handle)
  OSError: [Errno 0] Error

Moreover doing "semodule -i whatever_module.pp" gives the same error
messages.  After some investigation I've found that line 14 of the
reported file is:

  (roletype system_r accountsd_t)

... and that system_r is defined as a role in refpolicy in
modules/kernel/kernel.te, which is included in base.pp.  This role
definition is eaten by the pp compiler (as expected, according to a
thread in this ML two days ago).  As system_r is not defined in any
module, semanage fails.

A quick-and-dirty fix consists in building a new module with only "role
system_r;".  Then I've been able to successfully build the policy in its
new store, but this looks dirty.  Is there a better way to solve this
issue or does system_r definition needs to be moved in a real module?

By the way, "OSError: [Errno 0] Error" is quite strange...

Best,

Nicolas
