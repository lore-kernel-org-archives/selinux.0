Message-ID: <36282A1733C57546BE392885C06185923AFE0D@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>
Cc: "Stephen Smalley (E-mail)" <sds@epoch.ncsc.mil>
Subject: [patch] Role Dominance Ordering
Date: Thu, 2 Sep 2004 11:17:46 -0400 
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C49100.007B88E0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C49100.007B88E0
Content-Type: text/plain;
	charset="iso-8859-1"


The attached patch addresses the role dominance ordering issues which has
been brought up on this list previously.

policy_parse.y |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions

 <<role_order.patch>> 
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


------_=_NextPart_000_01C49100.007B88E0
Content-Type: application/octet-stream;
	name="role_order.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="role_order.patch"

--- checkpolicy.old/policy_parse.y	2004-09-01 11:39:03.304407969 =
-0500=0A=
+++ checkpolicy/policy_parse.y	2004-09-01 11:41:49.345351281 -0500=0A=
@@ -2987,6 +2987,38 @@=0A=
 	return new;=0A=
 }=0A=
 =0A=
+/* This function eliminates the ordering dependency of role dominance =
rule */=0A=
+static int dominate_role_recheck(hashtab_key_t key, hashtab_datum_t =
datum, void *arg)=0A=
+{=0A=
+	role_datum_t *rdp =3D (role_datum_t *) arg;=0A=
+	role_datum_t *rdatum =3D (role_datum_t *) datum;=0A=
+	int i;=0A=
+=0A=
+	/* Don't bother to process against self role */=0A=
+	if (rdatum->value =3D=3D rdp->value)=0A=
+		return 0;=0A=
+=0A=
+	/* If a dominating role found */=0A=
+	if (ebitmap_get_bit(&(rdatum->dominates), rdp->value - 1))=0A=
+	{=0A=
+		/* raise types and dominates from dominated role */=0A=
+		for (i =3D ebitmap_startbit(&rdp->dominates); =0A=
+			i < ebitmap_length(&rdp->dominates); i++) =0A=
+		{=0A=
+			if (ebitmap_get_bit(&rdp->dominates, i))=0A=
+				ebitmap_set_bit(&rdatum->dominates, i, TRUE);=0A=
+		}=0A=
+		for (i =3D ebitmap_startbit(&rdp->types); =0A=
+			i < ebitmap_length(&rdp->types); i++)	=0A=
+		{=0A=
+			if (ebitmap_get_bit(&rdp->types, i))=0A=
+				ebitmap_set_bit(&rdatum->types, i, TRUE);=0A=
+		}		=0A=
+	}=0A=
+=0A=
+	/* go through all the roles */=0A=
+	return 0;=0A=
+}=0A=
 =0A=
 static role_datum_t *=0A=
  define_role_dom(role_datum_t * r)=0A=
@@ -3040,6 +3072,12 @@=0A=
 			ebitmap_destroy(&r->dominates);=0A=
 			free(r);=0A=
 		}=0A=
+		/*=0A=
+		 * Now go through all the roles and escalate this role's=0A=
+		 * dominates and types if a role dominates this role.=0A=
+		 */=0A=
+		hashtab_map(policydbp->p_roles.table,=0A=
+						dominate_role_recheck, role);=0A=
 	}=0A=
 	return role;=0A=
 }=0A=

------_=_NextPart_000_01C49100.007B88E0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
