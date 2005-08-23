Subject: Re: libselinux category patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1124815922.7874.124.camel@moss-spartans.epoch.ncsc.mil>
References: <430A33E5.1030100@redhat.com>
	 <1124815922.7874.124.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 13:21:52 -0400
Message-Id: <1124817712.7874.138.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-08-23 at 12:52 -0400, Stephen Smalley wrote:
> This appears to reflect both a problem in the patch and a problem in ls.
> As far as the patch goes, when there is no libsetrans, the wrapper
> functions (e.g. getfilecon) are always setting *context to rcontext even
> if the raw function returned an error.  I think we need to qualify the
> else clauses in the wrapper functions with if (ret > 0) as well so that
> we do not set *context to garbage when an error is encountered by the
> raw function.  I can make that change.

This patch relative to the translation patch fixes the wrapper functions
to not set the context pointers when the raw functions return an error.
This fixes the problem with ls -Z displaying garbage when it encounters
a file or directory with no extended attribute value.

I did notice one other issue with the translation patch that is not
resolved by this one (in fact, this one propagates the same behavior to
the !context_translations case).  If getxattr returns a length of zero
(shouldn't ever happen for the selinux attribute, but the interface
allows for it), then the old getfilecon function would have set the
context pointer to an empty buffer (containing only NULs) and returned
zero as well.  The wrapper functions don't presently set the context
pointer at all in this case.  Possibly we just shouldn't allow it to
happen, i.e. return an error from the raw functions if we ever get a
zero length from getxattr?

Index: libselinux/src/compute_create.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/compute_create.c,v
retrieving revision 1.12
diff -u -p -r1.12 compute_create.c
--- libselinux/src/compute_create.c	23 Aug 2005 16:46:40 -0000	1.12
+++ libselinux/src/compute_create.c	23 Aug 2005 16:52:12 -0000
@@ -87,7 +87,7 @@ int security_compute_create(security_con
 			}
 			freecon(rnewcon);
 		}
-	} else
+	} else if (!ret)
 		*newcon = rnewcon;
 
 	return ret;
Index: libselinux/src/compute_member.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/compute_member.c,v
retrieving revision 1.2
diff -u -p -r1.2 compute_member.c
--- libselinux/src/compute_member.c	23 Aug 2005 16:46:40 -0000	1.2
+++ libselinux/src/compute_member.c	23 Aug 2005 16:52:25 -0000
@@ -86,7 +86,7 @@ int security_compute_member(security_con
 			}
 			freecon(rnewcon);
 		}
-	} else
+	} else if (!ret)
 		*newcon = rnewcon;
 
 	return ret;
Index: libselinux/src/compute_relabel.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/compute_relabel.c,v
retrieving revision 1.11
diff -u -p -r1.11 compute_relabel.c
--- libselinux/src/compute_relabel.c	23 Aug 2005 16:46:40 -0000	1.11
+++ libselinux/src/compute_relabel.c	23 Aug 2005 16:52:35 -0000
@@ -86,7 +86,7 @@ int security_compute_relabel(security_co
 			}
 			freecon(rnewcon);
 		}
-	} else
+	} else if (!ret)
 		*newcon = rnewcon;
 
 	return ret;
Index: libselinux/src/fgetfilecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/fgetfilecon.c,v
retrieving revision 1.7
diff -u -p -r1.7 fgetfilecon.c
--- libselinux/src/fgetfilecon.c	23 Aug 2005 16:46:40 -0000	1.7
+++ libselinux/src/fgetfilecon.c	23 Aug 2005 16:55:06 -0000
@@ -57,7 +57,7 @@ int fgetfilecon(int fd, security_context
 			ret = -1;
 		}
 		freecon(rcontext);
-	} else
+	} else if (ret > 0)
 		*context = rcontext;
 
 	return ret;
Index: libselinux/src/getcon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/getcon.c,v
retrieving revision 1.8
diff -u -p -r1.8 getcon.c
--- libselinux/src/getcon.c	23 Aug 2005 16:46:40 -0000	1.8
+++ libselinux/src/getcon.c	23 Aug 2005 16:54:09 -0000
@@ -57,7 +57,7 @@ int getcon(security_context_t *context)
 			ret = -1;
 		}
 		freecon(rcontext);
-	} else
+	} else if (!ret)
 		*context = rcontext;
 
 	return ret;
Index: libselinux/src/getexeccon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/getexeccon.c,v
retrieving revision 1.6
diff -u -p -r1.6 getexeccon.c
--- libselinux/src/getexeccon.c	23 Aug 2005 16:46:40 -0000	1.6
+++ libselinux/src/getexeccon.c	23 Aug 2005 16:54:22 -0000
@@ -61,7 +61,7 @@ int getexeccon(security_context_t *conte
 			ret = -1;
 		}
 		freecon(rcontext);
-	} else
+	} else if (!ret)
 		*context = rcontext;
 
 	return ret;
Index: libselinux/src/getfilecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/getfilecon.c,v
retrieving revision 1.8
diff -u -p -r1.8 getfilecon.c
--- libselinux/src/getfilecon.c	23 Aug 2005 16:46:40 -0000	1.8
+++ libselinux/src/getfilecon.c	23 Aug 2005 16:54:53 -0000
@@ -58,7 +58,7 @@ int getfilecon(const char *path, securit
 			ret = -1;
 		}
 		freecon(rcontext);
-	} else
+	} else if (ret > 0)
 		*context = rcontext;
 
 	return ret;
Index: libselinux/src/getfscreatecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/getfscreatecon.c,v
retrieving revision 1.6
diff -u -p -r1.6 getfscreatecon.c
--- libselinux/src/getfscreatecon.c	23 Aug 2005 16:46:41 -0000	1.6
+++ libselinux/src/getfscreatecon.c	23 Aug 2005 16:55:19 -0000
@@ -61,7 +61,7 @@ int getfscreatecon(security_context_t *c
 			ret = -1;
 		}
 		freecon(rcontext);
-	} else
+	} else if (!ret)
 		*context = rcontext;
 
 	return ret;
Index: libselinux/src/getpeercon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/getpeercon.c,v
retrieving revision 1.3
diff -u -p -r1.3 getpeercon.c
--- libselinux/src/getpeercon.c	23 Aug 2005 16:46:41 -0000	1.3
+++ libselinux/src/getpeercon.c	23 Aug 2005 16:55:29 -0000
@@ -56,7 +56,7 @@ int getpeercon(int fd, security_context_
 			ret = -1;
 		}
 		freecon(rcontext);
-	} else
+	} else if (!ret)
 		*context = rcontext;
 
 	return ret;
Index: libselinux/src/getpidcon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/getpidcon.c,v
retrieving revision 1.5
diff -u -p -r1.5 getpidcon.c
--- libselinux/src/getpidcon.c	23 Aug 2005 16:46:41 -0000	1.5
+++ libselinux/src/getpidcon.c	23 Aug 2005 16:55:41 -0000
@@ -60,7 +60,7 @@ int getpidcon(pid_t pid, security_contex
 			ret = -1;
 		}
 		freecon(rcontext);
-	} else
+	} else if (!ret)
 		*context = rcontext;
 
 	return ret;
Index: libselinux/src/getprevcon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/getprevcon.c,v
retrieving revision 1.6
diff -u -p -r1.6 getprevcon.c
--- libselinux/src/getprevcon.c	23 Aug 2005 16:46:41 -0000	1.6
+++ libselinux/src/getprevcon.c	23 Aug 2005 16:55:56 -0000
@@ -57,7 +57,7 @@ int getprevcon(security_context_t *conte
 			ret = -1;
 		}
 		freecon(rcontext);
-	} else
+	} else if (!ret)
 		*context = rcontext;
 
 	return ret;
Index: libselinux/src/lgetfilecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/lgetfilecon.c,v
retrieving revision 1.7
diff -u -p -r1.7 lgetfilecon.c
--- libselinux/src/lgetfilecon.c	23 Aug 2005 16:46:41 -0000	1.7
+++ libselinux/src/lgetfilecon.c	23 Aug 2005 16:50:53 -0000
@@ -57,7 +57,7 @@ int lgetfilecon(const char *path, securi
 			ret = -1;
 		}
 		freecon(rcontext);
-	} else
+	} else if (ret > 0)
 		*context = rcontext;
 
 	return ret;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
