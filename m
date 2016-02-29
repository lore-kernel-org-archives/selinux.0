Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1TKtJuN025501
 for <selinux@tycho.nsa.gov>; Mon, 29 Feb 2016 15:55:19 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 10A2D20BA8
 for <selinux@tycho.nsa.gov>; Mon, 29 Feb 2016 15:53:55 -0500 (EST)
Message-Id: <1456779234.1533784.535446282.49825E35@webmail.messagingengine.com>
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain
Subject: handling locally-modified policy and upgrades with ostree
Date: Mon, 29 Feb 2016 15:53:54 -0500
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

Currently there's a conflict between the way OSTree handles
config files (modified version in /etc wins, see https://ostree.readthedocs.org/en/latest/manual/deployment/ )
and SELinux, because the policy lives in /etc.

The core problem is that right now, as soon as one modifies
the policy, that binary version is propagated forwards until
the admin reruns `semodule -B` (and really you want to
run it for the *new* chroot)

A few of us from Red Hat talked about this at Devconf.cz,
and I filed:

https://bugzilla.gnome.org/show_bug.cgi?id=761620

The first question from the bug is:

 - Can we detect "is the policy changed"?  Probably cmp /{usr/,}etc/selinux/targeted/policy/policy.29 - but is there an API for that?

I was briefly looking at this again today, started by reading the semodule
code.

The first question is most important to me - right now by nature
of having the immutable copy in /etc, OSTree itself can help
me know whether policy is modified.  But, I have to know the
policy path and version.

I started reading the code in selinux/libselinux/src/load_policy.c
around finding out "what is the current policy version", and
while selinux_binary_policy_path() will tell me the prefix,
the code around detecting the version number is rather
nontrivial[1].

The libsemanage code has some layers here that seem to
ultimately boil down to picking the largest version known to libsemanage,
but here I need logic more like what load_policy is doing (I want
to know the current binary version, not generate a new one).

Maybe we could add a public API for this?  Alternatively, have
`semodule -B --only-if-modified` or something that would immediately
exit if there's nothing to do?

The above text covers the first question, the second one from the bug is:

 - Can we efficiently detect the case where on upgrade, the base policy version didn't change, so we don't need to recompile, and just propagate forward our modified policy from /etc?

This one is actually a different "policy version", I should have written
"policy RPM package version" or so.  This one is probably relatively
simple to do in rpm-ostree, just compare the EVRs of the policy package,
but is there some sort of package-system independent version (like
a checksum of the .pp files) that I could use?

[1] What is up with the dlopen?  It'd be nice to have a comment in this code;
the git commit message just says "initial import from svn trunk revision 2950"
and I'm too lazy right now to install Subversion in the hopes
that contains a useful log message.
