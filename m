Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0SIun53026285
	for <selinux@tycho.nsa.gov>; Fri, 28 Jan 2005 13:56:49 -0500 (EST)
Subject: Re: [PATCH 1/2] Rewrite setfiles to use matchpathcon
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: Daniel J Walsh <dwalsh@redhat.com>, Russell Coker <russell@coker.com.au>
In-Reply-To: <1106936140.32737.88.camel@moss-spartans.epoch.ncsc.mil>
References: <1106935580.32737.78.camel@moss-spartans.epoch.ncsc.mil>
	 <1106936140.32737.88.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-pG9dgGD+EFXBJ6dMyCIm"
Message-Id: <1106938227.32737.104.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 28 Jan 2005 13:50:27 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-pG9dgGD+EFXBJ6dMyCIm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-01-28 at 13:15, Stephen Smalley wrote:
> This patch for libselinux generalizes the matchpathcon(3) internals,
> exports further interfaces related to it, and moves additional code from
> setfiles into libselinux so that setfiles can directly use
> matchpathcon.  Merged into sourceforge CVS as of libselinux 1.21.5.
> 
>  include/selinux/selinux.h |   53 ++++++++-
>  src/Makefile              |    2 
>  src/matchpathcon.c        |  255 +++++++++++++++++++++++++++++++++++++++++++---
>  src/selinux_internal.h    |    1 
>  4 files changed, 293 insertions(+), 18 deletions(-)

Bug fix patch relative to the original patch attached - failed to handle
error return from matchpathcon_common().  Also committed to sourceforge
CVS.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-pG9dgGD+EFXBJ6dMyCIm
Content-Disposition: attachment; filename=libselinux-fix.patch
Content-Type: text/x-patch; name=libselinux-fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/src/matchpathcon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/matchpathcon.c,v
retrieving revision 1.16
retrieving revision 1.17
diff -u -p -r1.16 -r1.17
--- libselinux/src/matchpathcon.c	28 Jan 2005 17:49:17 -0000	1.16
+++ libselinux/src/matchpathcon.c	28 Jan 2005 18:44:52 -0000	1.17
@@ -655,6 +655,9 @@ int matchpathcon(const char *name, 
 {
 	int i = matchpathcon_common(name, mode);
 
+	if (i < 0)
+		return -1;
+
 	if (strcmp(spec_arr[i].context, "<<none>>") == 0) {
 		errno = ENOENT;
 		return -1;
@@ -673,6 +676,9 @@ int matchpathcon_index(const char *name,
 {
 	int i = matchpathcon_common(name, mode);
 
+	if (i < 0)
+		return -1;
+
 	*con = strdup(spec_arr[i].context);
 	if (!(*con))
 		return -1;

--=-pG9dgGD+EFXBJ6dMyCIm--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
