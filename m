Received: from [144.51.25.131] (moss-pluto [144.51.25.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7FH1Loh009612
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2012 13:01:21 -0400
Message-ID: <1345049962.23766.41.camel@moss-pluto.epoch.ncsc.mil>
Subject: SE Android: Recent changes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Date: Wed, 15 Aug 2012 12:59:22 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

A recent change in AOSP master requires that HAVE_SELINUX=true be set
outside of the build system, either as an environment variable or as a
command-line argument to make.  Thus, going forward, to build SE Android
on the master branch, you will need to follow this approach.  We have
updated the wiki instructions accordingly.

Some other recent changes include:

* We have added a grouper project for the Nexus 7 with some policy files
and the necessary modifications to use a kernel built from our tree
rather than the prebuilt kernel.  The kernel must be built from the
seandroid-tegra3-grouper-3.1-jb-fr2 branch of the kernel/tegra tree;
note that this is not presently the default branch checked out by the
local_manifest.xml file (which presently defaults to the kernel branch
for the Xoom).  We added a table on the wiki showing the right kernel,
branch, and configuration to use for each device.

* We have made further changes to the tuna project for seandroid
(master) and seandroid-4.1.1 to restore support for relabeling the
factory partition (previously broken when we updated to 4.1/JB) and to
address further policy denials that we have seen in testing of the
Galaxy Nexus with master and 4.1.1.

* We have made further updates to sepolicy and to libselinux.

* We have updated our seandroid-4.1.1 branch to android-4.1.1_r4.

* We moved mac_permissions.xml from mac-policy to sepolicy since it now
contains the seinfo tags used to select entries in seapp_contexts.

* To help with creating mac_permissions.xml configurations, we have
developed a host tool called 'setool'.  In its current form setool helps
with building certain mac_permissions.xml stanzas.  Future work will
include the ability to validate supplied apps against an existing
policy.  To use, first build the tool with 'make setool'. Then, just run
'setool' to see a usage message.  At present, setool still lives in the
old mac-policy project, but it will likely be moved in the future to its
own project.

* AOSP has merged our remaining system/core changes (policy reloading,
property MAC checks) and refreshed their copies of sepolicy and
libselinux.  This involved some refactoring of the code, such that most
of the policy loading logic has moved into libselinux for master and
4.1.1.  The only remaining open changes presently submitted to AOSP are
several frameworks/base changes, primarily for the certificate-based
seinfo support and some restorecon calls.  Beyond those submitted
changes, we still have changes in our trees for the install-time MAC
checking and for the kernel/* and device/* changes.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
