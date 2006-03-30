Subject: Re: Fix file descriptor leak
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: James Morris <jmorris@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <442C277C.6010906@redhat.com>
References: <442AEF1E.9020503@redhat.com>
	 <1143738031.24555.222.camel@moss-spartans.epoch.ncsc.mil>
	 <442C277C.6010906@redhat.com>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 14:50:53 -0500
Message-Id: <1143748253.24555.265.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-03-30 at 13:46 -0500, Daniel J Walsh wrote:
> Stephen Smalley wrote:
> > On Wed, 2006-03-29 at 15:33 -0500, Daniel J Walsh wrote:
> > diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage_store.c libsemanage-1.6.2/src/semanage_store.c
> > --- nsalibsemanage/src/semanage_store.c	2006-03-10 09:48:01.000000000 -0500
> > +++ libsemanage-1.6.2/src/semanage_store.c	2006-03-29 14:20:16.000000000 -0500
> > @@ -1159,6 +1159,8 @@
> >  		ERR(sh, "Could not open direct %s at %s.", lock_name, lock_file);
> >  		return -1;
> >  	}
> > +	fcntl(fd, FD_CLOEXEC, 0);
> > +
> >  	if (sh->timeout == 0) {
> >  		/* return immediately */
> >  		origtime.tv_sec = 0;
> >
> > Shouldn't that be:
> > 	fcntl(fd, F_SETFD, FD_CLOEXEC)?
> >
> >   
> yes

Ok, merged the following internally.  Waiting for sourceforge to come
back.

Index: libsemanage/src/semanage_store.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/semanage_store.c,v
retrieving revision 1.44
diff -u -p -r1.44 semanage_store.c
--- libsemanage/src/semanage_store.c	8 Mar 2006 16:42:21 -0000	1.44
+++ libsemanage/src/semanage_store.c	30 Mar 2006 19:26:50 -0000
@@ -1159,6 +1159,12 @@ static int semanage_get_lock(semanage_ha
 		ERR(sh, "Could not open direct %s at %s.", lock_name, lock_file);
 		return -1;
 	}
+	if (fcntl(fd, F_SETFD, FD_CLOEXEC) < 0) {
+		ERR(sh, "Could not set close-on-exec for %s at %s.", lock_name, lock_file);
+		close(fd);
+		return -1;
+	}
+
 	if (sh->timeout == 0) {
 		/* return immediately */
 		origtime.tv_sec = 0;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
