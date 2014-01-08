Message-ID: <52CDB8AC.4090504@tresys.com>
Date: Wed, 8 Jan 2014 15:44:28 -0500
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [RFC] CIL and Source Policy Integration
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

As has been posted to this list before in the past, we have made a lot
of progress with CIL [1]. Although we are still making changes, we are
now capable of building SELinux binary policies from CIL versions of
refpolicy and SEAndroid policy. A related project that we are working
on, and the purpose of this RFC, is to modify SELinux userspace to
include the CIL and the Source Policy work completed a few years ago.
We have completed a preliminary integration, so we are sending out this
RFC to start discussions and ask questions. To start it off, what is in
the way of getting these branches merged into master, and how can we
help mitigate that? Are the any changes that you question? Can we find
a work around?

Instead of sending the patchset to this list (54 commits, 4000
insertions, 2000 deletions), all the changes are pushed to the selinux
git repository to the following three branches, each one building on the
other. The branches and their purpose is described below:

src-revert:
   Reverts changes made to master that conflict with the src-policy
   branch (e.g. how paths are handled, enabled/disable modules). Rather
   than dealing with a large amount of conflicts, it was easier to just
   remove the commits which add conflicting features, rebase the old
   source policy work on top of that, and add back any features that in
   manner consistent with source policy. This also reverts the preserve
   tunables patchset, but as I look at it while typing this, I realize
   that was unnecessary. Aside from numerous conflicts and the need to
   add CIL support, the only real issue is that the preserve tunables
   feature uses the -P flag, which source policy uses for priority. So I
   guess we'll have to pick a different letter.

src-policy:
   This is a rebase of the old src-policy branch onto the src-revert
   branch. The goal of this patchset is to improve the API for module
   handling, as well as support source policies, module priorities,
   better enabling/disabling of modules, and moving the policy store
   from /etc/selinux/<store>/modules to /var/lib/selinux/<store>/.

integration:
   This branch builds CIL into libsepol, and updates libsepol,
   libsemanage, semodule, and semanage to work with and understand only
   CIL files.  Switching to CIL has a few side effects, such as removing
   base modules, versions, upgrades, adding configuration options to
   semanage.conf, etc. This also removes support for binary .pp modules.

With these three branches, it is possible to build and manage SELinux
policy using CIL files and the familiar semodule/semanage tools.

To make this easier for the community to play around with, we have
created a VMWare virtual machine [2] that has all the necessary setup to
start using SELinux userspace tools with CIL, including the installation
of the CIL refpolicy created by Jim (for a quick test, run semodule
-lfull). If you would rather build this yourself, the steps are at the
bottom of this email.

Thanks, and we look forward to receive your feedback.

- Steve

[1] http://userspace.selinuxproject.org/trac/wiki/CilDesign
[2] http://oss.tresys.com/files/cil/CILTest_Fedora_19_x86_64.tar.bz2



Steps to Install SELinux Userspace with CIL Integration and Full CIL
RefPolicy

# Start with a Fedora 19-x86_64 Minimal Installation

# install userspace selinux dependencies
$ yum install pcre-devel ustr-devel bzip2-devel audit-libs-devel flex
flex-static python-devel setools-devel libcgroup-devel libcap-ng-devel
glib2-devel dbus-devel dbus-glib-devel swig libsepol-static python-IPy

# put the system into permissive mode
$ sed -ri 's/(^SELINUX=).*/\1permissive/' /etc/selinux/config
$ setenforce 0

# clone the repos and checkout branches
$ git clone -b integration http://oss.tresys.com/git/selinux.git
$ git clone https://bitbucket.org/jwcarter/secilc.git
$ git clone -b old_syntax https://bitbucket.org/jwcarter/cilpolicy.git

# create a symlink to secilc so cil can be built into libsepol
$ ln -s ~/secilc/ selinux/libsepol/cil

# install selinux userspace with cil integration
$ make -C selinux LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap

# create the new module store
$ mkdir -p /var/lib/selinux/cil-test/active/modules

# copy the targeted configuration to cil-test (not valid for the policy, but
# needed for bootable system)
$ mkdir -p /etc/selinux/cil-test/policy
$ cp -r /etc/selinux/targeted/{contexts,seusers,setrans.conf}
/etc/selinux/cil-test/

# set the store to cil-test
$ sed -ri 's/(^SELINUXTYPE=).*/\1cil-test/' /etc/selinux/config

# install all the CIL policies
$ cd cilpolicy
$ xargs -a LISTING semodule -i
