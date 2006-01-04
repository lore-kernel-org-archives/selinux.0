Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k048c9Xf000072
	for <selinux@tycho.nsa.gov>; Wed, 4 Jan 2006 03:38:13 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k048bwRe019309
	for <selinux@tycho.nsa.gov>; Wed, 4 Jan 2006 08:38:06 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: libsetrans performance patch
Date: Wed, 4 Jan 2006 19:37:20 +1100
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200601040555.08511.russell@coker.com.au> <43BAD760.3060802@redhat.com>
In-Reply-To: <43BAD760.3060802@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Vl4uD12P4nnYfic"
Message-Id: <200601041937.41623.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_Vl4uD12P4nnYfic
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 04 January 2006 06:58, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Russell Coker wrote:
> > I have optimised the libsetrans library a bit.  Changed locking of a FILE
> > *, removed some needless strdup/strlen operations, and fixed a bug
> > whereby strtrim could potentially copy random data from the heap (ended
> > up removing strtrim).
>
> I have added most of your previous patch to libsetrans-0.1.14-1  Please
> check to make sure I got everything.  There was one problem in your
> patch that caused untranslate to fail  a:b:c->a:b:c:s0

It seems to have got everything.

setrans.c: In function 'translate_context':
setrans.c:381: warning: control may reach end of non-void function 'translate' 
being inlined

I've attached a patch which fixes the above bug, removed a needless check for 
the return value of strdupa(), and includes the fix for the problem you 
mention above (pity I didn't test rpm's use of libsetrans before sending the 
previous patch).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Vl4uD12P4nnYfic
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="trans.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="trans.diff"

diff -rup libsetrans-0.1.13.orig/src/setrans.c libsetrans-0.1.13/src/setrans.c
--- libsetrans-0.1.13.orig/src/setrans.c	2006-01-03 01:12:20.000000000 +1100
+++ libsetrans-0.1.13/src/setrans.c	2006-01-04 19:33:30.000000000 +1100
@@ -62,7 +62,6 @@ static int process_label(char *buffer, l
 		name_end--;
 	}
 	while (isspace(*tok)) tok++;
-	if(!*tok) return 0;
 
 	next=(labels_t *) calloc(1, sizeof(labels_t));
 	if (!next) { 
@@ -142,7 +141,6 @@ static char *translate_categories(const 
 	char *ptr;
 	int error=0;
 	char *categories=strdupa(cat);
-	if (!categories) return NULL;
 	char *tok=strtok_r(categories,",",&ptr);
 
 	while (tok) {
@@ -251,6 +249,8 @@ static const char *translate(const char 
 		free((char *) l1);
 		free((char *) l2);
 		if (error==0) return ptr;
+		free(ptr);
+		return NULL;
 	} 
 	else
 		return translate_label(labels);

--Boundary-00=_Vl4uD12P4nnYfic--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
