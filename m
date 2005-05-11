Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4BFUHgA018497
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2005 11:30:17 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4BFRZiX000013
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2005 15:27:36 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies [144.51.25.7])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4BFS9RH028591
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2005 11:28:09 -0400 (EDT)
Subject: [RFC]{Patch 0/5] Polyinstantation
From: Chad Sellers <cdselle@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 11 May 2005 11:28:55 -0400
Message-Id: <1115825335.28084.27.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch us a userspace patch to provide polyinstantiation support in
SELinux.  I am including a patch to libselinux to provide this, as well
as patches to login, su, gdm, and policy to make this work.  These
patches will follow in separate emails.  Comments are appreciated
(usually, at least).

OVERVIEW
This code provides polyinstantiation support for directories in SELinux
systems.  It creates multiple instances of a directory as dictated by
policy.  These instances are actually subdirectories, named using a MD5
hash of the context of the member directory, that are used in place of
the parent directory.  To interface with policy, the code utilizes
the /selinux/member interface to read how directories should be
polyinstantiated according to policy.

In order to specify how directories should be instantiated in type
enforcement policy, a type_member rule is used.  MLS polyinstantiation
policy is implicit (i.e. the directory should be polyinstantiated to the
level of the user).  This code queries the /selinux/member interface to
see what member of a polyinstantiated directory should be used for a
given subject context.

To replace the original directory with the appropriate member directory,
per-process namespaces and bind mounts are used.  More specifically, an
entrypoint program (say login) calls this library to see if any
polyinstantiation is necessary.  If so, it calls clone() instead of fork
with the CLONE_NEWNS flag to get a new namespace.  Then, the library can
bind mount member directories over the originals.  Additionally, the
library remounts the original directory elsewhere (e.g. /tmp is
remounted to /.tmp-poly-orig) for security-aware (and allowed) programs
to utilize it.

USING THE LIBRARY
The library exports 2 functions, security_setupns(), the main function,
and security_set_setupns_printf(), a support function to change where
printf's go. security_setupns() sets up a namespace for the user being
processed.  It takes one argument - commit, which is an integer that can
be 0 or 1.  If commit=0, the function does not actually set up the
namespace, but just checks to see if any modifications to the namespace
are necessary.  If commit=1, those modifications are actually made.  The
function returns the number of changes (i.e. directories needing
polyinstantiation).  security_set_setupns_printf is used to replace the
printf function (which defaults to logging to stderr) the same way that
set_matchpathcon_printf() does.

CONFIG FILE
There is one config file, which is stored in /etc/selinux/polydirs.  The
first line contains the default context to use for directories that
originals are remounted to (e.g. /.tmp-poly-orig), which only matters
before the bind mount happens.  The rest of the file is a newline-
delimited list of candidate directories to be polyinstantiated.  Each of
these directories will be checked to see if polyinstantiation is
necessary according to the policy.  Additionally, the library supports
the special directory $HOME to indicate the home directory of the user
who's environment we're setting up.

POLICY
Policy is fairly straightforward.  Just write a type_member rule.  The
syntax is:
type_member <source type> <target type>:<target class> <member type>
<source type> is the type of the user logging in, <target type> is the
type of the directory being polyinstantiated, <target class> is dir
(since this patch only works for directories), and <member type> is what
you want the member directory context to be.  So, the rule
type_member user_t tmp_t:dir user_tmp_t
says use member directory user_tmp_t for a directory labeled tmp_t for
user_t.  Of course, for this query to take place at all, you have to
have a directory in the config file that is labeled tmp_t.
Note that you also need appropriate policy (TE allow rules and mls
priveleges) to allow programs such as login, su, and gdm to perform the
appropriate functions.  I've included a patch to policy to provide this.

BUILDING AND INSTALLING
The code is in the form of patches to the current cvs libselinux
(1.23.10-1), and the current rpms found in rawhide.  I've enclosed both
patches to source and patches to the spec files.  So, the easiest way to
install them, is to
1) Patch and rebuild your libselinux.
Build and install the SRPM -or-
tar xzf libselinux-x.y.z.tgz
cd libselinux-x.y.z
patch -p1 < libselinux-x.y.z-poly.patch
make install relabel

2) Apply the provided patch to your policy, build, and load it.
cd /etc/selinux/(strict|targeted|mls)/src/policy
patch -p1 < policy.diff
make load
Note:  This includes domains/misc/test.te, which has example type member
rules.  You may want to customize these to rules appropriate to your
install.

3) Install polydirs configuration file and edit for desired
configuration (which should match up with the type member rules above).
cp polydirs /etc/selinux/polydirs

4) Verify basic operation via setupns test utility (part of libselinux
patch).
su -
ls -al /tmp /home/<username>
setupns <username> <usercontext>
	e.g. setupns jdoe user_u:user_r:user_t
ls -al /tmp /home/<username>
cat /proc/mounts
exit
setupns -X <username> <usercontext>
ls -al /tmp /home/<username>

5) Build and install the modified util-linux, coreutils, and gdm
Build and install the SRPMs -or-
Try applying patches to source from somewhere else.  I have only tested
these patches with rawhide srpms, but they should be fairly easy to
apply to other source assuming that source already has the appropriate
SELinux patches.

6) Try logging into different roles at the console, via gdm, and using
su to switch between different users/roles, looking at your /tmp and
$HOME before and after, as well as /proc/mounts.


-- 
Chad Sellers
cdselle@tycho.nsa.gov


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
