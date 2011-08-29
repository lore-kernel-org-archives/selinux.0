Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7TBSwp8006415
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2011 07:28:58 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7TBSulM007625
	for <selinux@tycho.nsa.gov>; Mon, 29 Aug 2011 11:28:57 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Eric Paris <eparis@parisplace.org>
Subject: Re: Toolchain is broken?
Date: Mon, 29 Aug 2011 21:28:50 +1000
Cc: HarryCiao <harrytaurus2002@hotmail.com>, selinux@tycho.nsa.gov
References: <SNT139-W395A2E93EE6F195040BA93AB120@phx.gbl> <SNT139-W28B6707A5C8557A0CA887EAB120@phx.gbl> <CACLa4pvs1unWyLg5q1dnQ0fH21Ljq7e4MyO7+s9vRO06nEv5RA@mail.gmail.com>
In-Reply-To: <CACLa4pvs1unWyLg5q1dnQ0fH21Ljq7e4MyO7+s9vRO06nEv5RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zf3WOKLnlHLO5Nq"
Message-Id: <201108292128.51104.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_zf3WOKLnlHLO5Nq
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Sat, 27 Aug 2011, Eric Paris <eparis@parisplace.org> wrote:
> Must have come from this patch.
> 
> commit d784fd71b56cb8f57d5b9fcd784094e004bf7c6a
> Author: Russell Coker <russell@coker.com.au>
> Date:   Wed Jan 5 19:30:25 2011 +1100
> 
>     libsemanage: patch for MCS/MLS in user files
> 

What do you think of the attached patch?

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--Boundary-00=_zf3WOKLnlHLO5Nq
Content-Type: text/x-patch;
  charset="UTF-8";
  name="diff2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff2"

diff -ru libsemanage-2.0.46.old/src/genhomedircon.c libsemanage-2.0.46/src/genhomedircon.c
--- libsemanage-2.0.46.old/src/genhomedircon.c	2011-08-29 19:51:05.000000000 +1000
+++ libsemanage-2.0.46/src/genhomedircon.c	2011-08-29 20:18:23.000000000 +1000
@@ -629,9 +629,12 @@
 	home = strdup(h);
 	if (!home)
 		goto cleanup;
-	level = strdup(l);
-	if (!level)
-		goto cleanup;
+	if(l)
+	{
+		level = strdup(l);
+		if (!level)
+			goto cleanup;
+	}
 
 	temp->name = name;
 	temp->sename = sename;
@@ -675,15 +678,18 @@
 {
 	char *fallback_user = strdup(user);
 	char *fallback_user_prefix = strdup(prefix);
-	char *fallback_user_level = strdup(level);
+	char *fallback_user_level;
 
-	if (fallback_user == NULL || fallback_user_prefix == NULL || fallback_user_level == NULL) {
+	if (fallback_user == NULL || fallback_user_prefix == NULL) {
 		free(fallback_user);
 		free(fallback_user_prefix);
 		free(fallback_user_level);
 		return STATUS_ERR;
 	}
 
+	if(level)
+		fallback_user_level = strdup(level);
+
 	free(s->fallback_user);
 	free(s->fallback_user_prefix);
 	free(s->fallback_user_level);
@@ -727,7 +733,7 @@
 			if (semanage_user_query(s->h_semanage, key, &the_user) < 0)
 			{
 				prefix = name;
-				level = "s0";
+				level = FALLBACK_USER_LEVEL;
 			}
 			else
 			{
@@ -818,7 +824,7 @@
 			level = semanage_user_get_mlslevel(*u);
 		} else {
 			prefix = name;
-			level = "s0";
+			level = FALLBACK_USER_LEVEL;
 		}
 
 		retval = getpwnam_r(name, &pwstorage, rbuf, rbuflen, &pwent);

--Boundary-00=_zf3WOKLnlHLO5Nq--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
