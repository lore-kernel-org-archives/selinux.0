Message-ID: <36282A1733C57546BE392885C06185924D8EEF@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>
Subject: [PATCH] checkpolicy - nodecon ordering
Date: Fri, 29 Oct 2004 10:07:50 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C4BDC0.ACC68B80"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C4BDC0.ACC68B80
Content-Type: text/plain;
	charset="iso-8859-1"

Hi,

I have created a patch which orders nodecon rules from most specific to
least specific.  We think this functionality can be useful for ease of
administration and to protect against accidental misconfiguration.

I couldn't find any mention of this topic being brought up before, so I am
interested in opinions on this subject.

policy_parse.y |   59
++++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 46 insertions(+), 13 deletions(-)

____________________________
Chad Hanson
Senior Secure Systems Engineer

Trusted Computer Solutions
121 W Goose Alley
Urbana, IL  61801

www.TrustedCS.com

V: 217.384.0028  ext.12
F: 217.384.0288
E: chanson@TrustedCS.com



------_=_NextPart_000_01C4BDC0.ACC68B80
Content-Type: application/octet-stream;
	name="nodecon_order.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="nodecon_order.patch"

--- policy_parse.y	2004-09-20 15:57:52.000000000 -0500=0A=
+++ policy_parse.y.new	2004-10-28 16:10:21.471854576 -0500=0A=
@@ -4501,15 +4501,32 @@=0A=
 		free(newc);=0A=
 		return -1;=0A=
 	}=0A=
-	/* Place this at the end of the list, to retain=0A=
-	   the matching order specified in the configuration. */=0A=
-	head =3D policydbp->ocontexts[OCON_NODE];=0A=
-	for (l =3D NULL, c =3D head; c; l =3D c, c =3D c->next);=0A=
 =0A=
-	if (l)=0A=
-		l->next =3D newc;=0A=
-	else=0A=
-		policydbp->ocontexts[OCON_NODE] =3D newc;=0A=
+ 	/* Create order of most specific to least retaining=0A=
+ 	   the order specified in the configuration. */=0A=
+  	head =3D policydbp->ocontexts[OCON_NODE];=0A=
+ 	for (l =3D NULL, c =3D head; c; l =3D c, c =3D c->next)=0A=
+ 	{=0A=
+ 		if (newc->u.node.mask > c->u.node.mask)=0A=
+ 			break;=0A=
+ 	}=0A=
+=0A=
+  	if (l)=0A=
+ 	{=0A=
+ 		if (l->next)=0A=
+ 		{=0A=
+ 			newc->next =3D c;=0A=
+ 			l->next =3D newc;=0A=
+ 		}=0A=
+ 		else=0A=
+ 			l->next =3D newc;=0A=
+ 	}=0A=
+  	else=0A=
+	{=0A=
+		if (c)=0A=
+			newc->next =3D c;=0A=
+  		policydbp->ocontexts[OCON_NODE] =3D newc;=0A=
+	}=0A=
 =0A=
 	return 0;=0A=
 }=0A=
@@ -4577,15 +4594,31 @@=0A=
 		goto out;=0A=
 	}=0A=
 =0A=
-	/* Place this at the end of the list, to retain=0A=
-	   the matching order specified in the configuration. */=0A=
+	/* Create order of most specific to least retaining=0A=
+	   the order specified in the configuration. */=0A=
 	head =3D policydbp->ocontexts[OCON_NODE6];=0A=
-	for (l =3D NULL, c =3D head; c; l =3D c, c =3D c->next);=0A=
+	for (l =3D NULL, c =3D head; c; l =3D c, c =3D c->next)=0A=
+	{=0A=
+		if (memcmp(&newc->u.node6.mask,&c->u.node6.mask,16) > 0)=0A=
+			break;=0A=
+	}=0A=
 =0A=
 	if (l)=0A=
-		l->next =3D newc;=0A=
+	{=0A=
+		if (l->next)=0A=
+		{=0A=
+			newc->next =3D c;=0A=
+			l->next =3D newc;=0A=
+		}=0A=
+		else=0A=
+			l->next =3D newc;=0A=
+	}=0A=
 	else=0A=
-		policydbp->ocontexts[OCON_NODE6] =3D newc;=0A=
+	{=0A=
+		if (c)=0A=
+			newc->next =3D c;=0A=
+  		policydbp->ocontexts[OCON_NODE6] =3D newc;=0A=
+	}=0A=
 =0A=
 	rc =3D 0;=0A=
 out:=0A=

------_=_NextPart_000_01C4BDC0.ACC68B80--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
