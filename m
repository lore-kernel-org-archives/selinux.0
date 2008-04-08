Subject: Re: upstart/SELinux problem loading the wrong policy with kernel
	version change
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Chad Sellers <csellers@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1207659261.21223.261.camel@moss-spartans.epoch.ncsc.mil>
References: <47FACB0F.5050208@redhat.com>
	 <1207659261.21223.261.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 08 Apr 2008 09:29:46 -0400
Message-Id: <1207661386.21223.272.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-04-08 at 08:54 -0400, Stephen Smalley wrote:
> On Mon, 2008-04-07 at 21:31 -0400, Daniel J Walsh wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > If you have a kernel that supports policy.21 and a tool chain that
> > supports policy.22 newer versions of policy and semanage changes will
> > update policy.22.  However if there is a policy.21 around upstart will
> > load this on a reboot.  (I guess init would have done the same.)
> 
> No, init wouldn't have done the same, because init (in Fedora and RHEL)
> is dynamically linked and thus picks up the latest libsepol each time.
> 
> > If the policy.21 does not exist libselinux will grab the highest policy
> > version and try to load it.
> 
> No, libselinux presently always starts from the latest version supported
> by libsepol and works its way downwards.  But it will not look for any
> newer version than the one supported by libsepol, which is why you are
> having a problem.  And that is because it historically needed libsepol
> support to do any of the following:
> - patch in the current boolean values,
> - patch in local user definitions,
> - downgrade the policy to a version supported by the kernel.
> 
> The first two are obsolete but not the last.
> 
> > This is causing unlabeled_t files to be showing up.  Basically if I
> > install a new policy with a new type, and then assign the context to a
> > file, the next reboot will cause the file to be labeled unlabeled_t.
> > 
> > I suggest that we either remove policy versioning all together, or
> > change libselinux to default to loading the highest policy version.
> > Either way the current loading of policy is broken.
> 
> Per Chad, they don't have this problem in Ubuntu because they just have
> a shell script in the initrd that chroot's to the real root and runs
> load_policy from there, thereby picking up the latest libsepol from the
> real root filesystem.  So Fedora only has a problem because it patches
> nash directly and thus brings in a libsepol dependency into the initrd.
> 
> We have to consider the implications of any change in the current
> behavior on existing systems too.  Suppose that libselinux was changed
> to start with the max(kernelversion,libsepolversion) and then probe
> downward from there.  That would find the newer policy files when they
> are supported by the kernel.  However, it would then be unable to patch
> in boolean or user values into those policies since libsepol wouldn't
> understand them.  Which could potentially break RHEL 4 systems.
> Although one should never have more than one policy file there, right?

The other issue of course is making sure that we load the policy we last
generated from libsemanage, which is only a weak binding right now.
That might be better served by having libsemanage create a "policy"
symlink to the latest policy file and having libselinux look for that
first.  But that also requires a way for libselinux to query that policy
to learn its version number (to decide if downgrade is required), so
that requires a new libsepol interface, I think.

In the mean time, possibly the un-tested patch below would help?

If we are not setting local definitions or preserving booleans, then the
maximum policy version for load can be the max of the kernel-supported
version and the libsepol-supported version since we do not need to
manipulate the policy image prior to load.

Index: trunk/libselinux/src/load_policy.c
===================================================================
--- trunk/libselinux/src/load_policy.c	(revision 2858)
+++ trunk/libselinux/src/load_policy.c	(working copy)
@@ -43,6 +43,9 @@
 
 int load_setlocaldefs hidden = 1;
 
+#undef max
+#define max(a, b) (((a) > (b)) ? (a) : (b))
+
 int selinux_mkload_policy(int preservebools)
 {	
 	int kernvers = security_policyvers();
@@ -127,11 +130,6 @@
 
 #endif
 
-	if (usesepol) {
-		maxvers = vers_max();
-		minvers = vers_min();
-	}
-
 	/*
 	 * Check whether we need to support local boolean and user definitions.
 	 */
@@ -157,6 +155,13 @@
 	if (preservebools && uname(&uts) == 0 && strverscmp(uts.release, "2.6.22") >= 0)
 		preservebools = 0;
 
+	if (usesepol) {
+		maxvers = vers_max();
+		minvers = vers_min();
+		if (!setlocaldefs && !preservebools)
+			maxvers = max(kernvers, maxvers);
+	}
+
 	vers = maxvers;
       search:
 	snprintf(path, sizeof(path), "%s.%d",

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
