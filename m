Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LIwnWt029269
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 14:58:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9LIwaIS021468
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 18:58:36 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9LIwaDc021462
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 18:58:36 GMT
Subject: Re: chcon
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <3F957D6A.7060807@redhat.com>
References: <200310212327.05821.russell@coker.com.au>
	 <1066743378.27065.81.camel@moss-spartans.epoch.ncsc.mil>
	 <3F957D6A.7060807@redhat.com>
Content-Type: multipart/mixed; boundary="=-xqXyUSmAUZ4TTOv1iP0o"
Message-Id: <1066762719.27065.203.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 21 Oct 2003 14:58:39 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-xqXyUSmAUZ4TTOv1iP0o
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2003-10-21 at 14:39, Daniel J Walsh wrote:
> I have put out a new patch that does not do this anymore.  It has a
> simpler error mechanism.

I've applied the attached patch to setfiles so that it will proceed even
if selinuxfs is not mounted (e.g. on a non-SELinux kernel that has the
necessary xattr handlers), albeit without the ability to check the
contexts in the file contexts configuration for correctness.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-xqXyUSmAUZ4TTOv1iP0o
Content-Disposition: attachment; filename=setfiles.patch
Content-Type: text/x-patch; name=setfiles.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -X /home/sds/dontdiff -ru selinux-usr/policycoreutils/setfiles/setfiles.c selinux-usr-cvs/policycoreutils/setfiles/setfiles.c
--- selinux-usr/policycoreutils/setfiles/setfiles.c	2003-10-20 11:26:17.000000000 -0400
+++ selinux-usr-cvs/policycoreutils/setfiles/setfiles.c	2003-10-21 11:22:44.000000000 -0400
@@ -872,7 +872,7 @@
 				spec[nspec].context = context;
 
 				if (strcmp(context, "<<none>>")) {
-					if (security_check_context(context) < 0) {
+					if (security_check_context(context) < 0 && errno != ENOENT) {
 						fprintf(stderr,
 							"%s:  invalid context %s on line number %d\n",
 							argv[0], context,


--=-xqXyUSmAUZ4TTOv1iP0o--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
