Subject: Re: policycoreutils patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1217943844.2994.65.camel@moss-spartans.epoch.ncsc.mil>
References: <4892F6E0.10008@redhat.com>
	 <1217943844.2994.65.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 05 Aug 2008 09:57:07 -0400
Message-Id: <1217944627.2994.68.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-08-05 at 09:44 -0400, Stephen Smalley wrote:
> On Fri, 2008-08-01 at 07:43 -0400, Daniel J Walsh wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > Adds support for boolean files, name/value pairs as input and output.
> > Allows you to set a large amount of booleans at once.
> > 
> > Add support from groupname in semanage login.  This will allow you to
> > associate groups of Linux Users with an SELinux user.  Uses same syntax
> > as sudo.  Requires patch to libselinux.
> > 
> > Cleanup of semanage variables.  Change use of 1/0 to True/False.
> > 
> > Remove bad use of raise(out)
> 
> Looks ok other than adding gui to the Makefile since we don't have that
> one.  But upon trying "semanage login -a -s root %wheel", I get:
> libsemanage.get_users: user %wheel not in password file
> 
> So it seems that we also need libsemanage to understand the %groupname
> syntax?  That is coming from genhomedircon.c.
> 
> If actually supporting per-role file labeling, then we'd need
> libsemanage to expand the group and add the individual users for
> generating home directory entries.

As a minimal fix, we can do this to avoid the noise from genhomedircon.
But for the per-role file labeling, we'll ultimately need the group to
be expanded I think.

Index: libsemanage/src/genhomedircon.c
===================================================================
--- libsemanage/src/genhomedircon.c	(revision 2943)
+++ libsemanage/src/genhomedircon.c	(working copy)
@@ -762,6 +762,10 @@
 		if (strcmp(name, TEMPLATE_SEUSER) == 0)
 			continue;
 
+		/* %groupname syntax */
+		if (name[0] == '%')
+			continue;
+
 		/* find the user structure given the name */
 		u = bsearch(seuname, user_list, nusers, sizeof(semanage_user_t *),
 			    (int (*)(const void *, const void *))

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
