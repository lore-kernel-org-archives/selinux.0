Subject: Re: I have added group support to libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4892ED4B.8000104@redhat.com>
References: <4892ED4B.8000104@redhat.com>
Content-Type: text/plain
Date: Tue, 05 Aug 2008 09:32:38 -0400
Message-Id: <1217943158.2994.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-08-01 at 07:02 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> If you create an seusers file using the sudo syntax %groupname,
> getseuserbyname will check the user's groups for a match.
> 
> Match sequence will be:
> 
> username exists
> FIRST group match
> default
> 
> I will be sending a separate patch to allow semanage to add %groupname

Thanks.  I applied the following patch on top of your patch.  The
changes are:
- only look at the pwent if getpwnam_r returned 0 (success),
- don't skip the rest of the getseuserbyname() lookup if
get_default_gid() fails.

In the first case, pwent might reference garbage, and in the second, I
didn't want a failure there to completely prevent any logins.

Index: libselinux/src/seusers.c
===================================================================
--- libselinux/src/seusers.c	(revision 2944)
+++ libselinux/src/seusers.c	(working copy)
@@ -102,7 +102,7 @@
 	if (rbuf == NULL) return -1;
 
 	int retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);
-	if (retval == 0 || pwent != NULL) {
+	if (retval == 0 && pwent) {
 		gid = pwent->pw_gid;
 	}
 	free(rbuf);
@@ -163,7 +163,6 @@
 	char *defaultlevel = NULL;
 
 	gid_t gid = get_default_gid(name);
-	if ( gid == (gid_t) -1 ) goto nomatch;
 
 	cfg = fopen(selinux_usersconf_path(), "r");
 	if (!cfg)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
