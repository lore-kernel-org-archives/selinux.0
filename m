Subject: Re: getfilecon return code
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "John D. Ramsdell" <ramsdell@mitre.org>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        Joshua Brindle <method@manicmethod.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1184005840.12430.139.camel@moss-spartans.epoch.ncsc.mil>
References: <ogtmyy5lacd.fsf@oolong.mitre.org>
	 <1184005840.12430.139.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 09 Jul 2007 14:42:35 -0400
Message-Id: <1184006555.12430.142.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-07-09 at 14:30 -0400, Stephen Smalley wrote:
> On Mon, 2007-07-09 at 14:07 -0400, John D. Ramsdell wrote:
> > I hadn't carefully read the manual page for getfilecon until now, but
> > I notice it states that a positive number is returned indicating the
> > number of bytes malloc'd for the context, and -1 is returned
> > indicating failure and that errno is set.  I would have guessed from
> > the description that zero is never an allowed return value.  In fact,
> > I wrote code that freecon'd a context whenever the return value was
> > not -1.
> 
> freecon(NULL) is perfectly legal and harmless, like free(NULL), so that
> part is ok.
> 
> It is possible to set extended attributes with no values, e.g. 
> 	$ setfattr -n user.foo /path/to/foo
> 	$ getfattr -n user.foo /path/to/foo
> and directly calling getxattr() on that file will return 0.
> 
> So technically this is a possible case, even if it is unusual and was
> introduced in this case by the proc sysctl rewrite in the kernel leaving
> us with "private" /proc/sys inodes.
> 
> I'd be inclined to change security_inode_getsecurity() in the kernel to
> return -EOPNOTSUPP in the IS_PRIVATE(inode) case.  But that won't help
> with current kernels, of course.
> 
> libselinux could remap a zero return from getxattr to a -1 return with
> errno EOPNOTSUPP in the meantime if we want to present this behavior to
> applications now.

Like so:

Index: trunk/libselinux/src/fgetfilecon.c
===================================================================
--- trunk/libselinux/src/fgetfilecon.c	(revision 2492)
+++ trunk/libselinux/src/fgetfilecon.c	(working copy)
@@ -37,6 +37,11 @@
 		ret = fgetxattr(fd, XATTR_NAME_SELINUX, buf, size - 1);
 	}
       out:
+	if (ret == 0) {
+		/* Re-map empty attribute values to errors. */
+		errno = EOPNOTSUPP;
+		ret = -1;
+	}
 	if (ret < 0)
 		free(buf);
 	else
Index: trunk/libselinux/src/lgetfilecon.c
===================================================================
--- trunk/libselinux/src/lgetfilecon.c	(revision 2492)
+++ trunk/libselinux/src/lgetfilecon.c	(working copy)
@@ -37,6 +37,11 @@
 		ret = lgetxattr(path, XATTR_NAME_SELINUX, buf, size - 1);
 	}
       out:
+	if (ret == 0) {
+		/* Re-map empty attribute values to errors. */
+		errno = EOPNOTSUPP;
+		ret = -1;
+	}
 	if (ret < 0)
 		free(buf);
 	else
Index: trunk/libselinux/src/getfilecon.c
===================================================================
--- trunk/libselinux/src/getfilecon.c	(revision 2492)
+++ trunk/libselinux/src/getfilecon.c	(working copy)
@@ -37,6 +37,11 @@
 		ret = getxattr(path, XATTR_NAME_SELINUX, buf, size - 1);
 	}
       out:
+	if (ret == 0) {
+		/* Re-map empty attribute values to errors. */
+		errno = EOPNOTSUPP;
+		ret = -1;
+	}
 	if (ret < 0)
 		free(buf);
 	else

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
