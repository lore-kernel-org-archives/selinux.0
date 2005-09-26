Message-Id: <200509261807.j8QI79Ys022306@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'SELinux List'" <SELinux@tycho.nsa.gov>
Cc: <russell@coker.com.au>
Subject: RE: Fix for segfault on duplicate role transitions
Date: Mon, 26 Sep 2005 14:07:09 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0080_01C5C2A3.95C85880"
In-reply-to: 
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0080_01C5C2A3.95C85880
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Karl MacMillan [mailto:kmacmillan@tresys.com]
> Sent: Monday, September 26, 2005 2:05 PM
> To: 'SELinux List'
> Cc: 'russell@coker.com.au'
> Subject: Fix for segfault on duplicate role transitions
> 
> Attached is a patch to fix a segfault on defining duplicate role
> transitions. It also fixes an off-by-one error in the duplicate
> range_transition code path. Russell Coker reported the bug.
> 
> The patch is against CVS as of Friday evening - sourceforge anonymous cvs
> seems to be having issues and I can't update.
> 
> Karl
> 

Sorry - the previous patch was old and incorrect. Correct patch attached.

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com

> ------
> Karl MacMillan
> Tresys Technology
> http://www.tresys.com


------=_NextPart_000_0080_01C5C2A3.95C85880
Content-Type: application/octet-stream;
	name="1-role-trans-index-error.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="1-role-trans-index-error.patch"

--- checkpolicy/policy_parse.y	2005-09-23 15:04:06.000000000 -0400=0A=
+++ checkpolicy/policy_parse.y	2005-09-26 12:21:22.000000000 -0400=0A=
@@ -1899,6 +1899,11 @@ static int define_type(int alias)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+struct val_to_name {=0A=
+	unsigned int val;=0A=
+	char *name;=0A=
+};=0A=
+=0A=
 /* Adds a type, given by its textual name, to a typeset.  If *add is=0A=
    0, then add the type to the negative set; otherwise if *add is 1=0A=
    then add it to the positive side. */=0A=
@@ -2605,6 +2610,35 @@ static role_datum_t *=0A=
         return NULL;=0A=
 }=0A=
 =0A=
+static int role_val_to_name_helper(hashtab_key_t key, hashtab_datum_t =
datum, void *p)=0A=
+{=0A=
+	struct val_to_name *v =3D p;=0A=
+	role_datum_t *roldatum;=0A=
+=0A=
+	roldatum =3D (role_datum_t *) datum;=0A=
+=0A=
+	if (v->val =3D=3D roldatum->value) {=0A=
+		v->name =3D key;=0A=
+		return 1;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+=0A=
+static char *role_val_to_name(unsigned int val) =0A=
+{=0A=
+	struct val_to_name v;=0A=
+	int rc;=0A=
+=0A=
+	v.val =3D val;=0A=
+	rc =3D hashtab_map(policydbp->p_roles.table, =0A=
+			 role_val_to_name_helper, &v);=0A=
+	if (rc)=0A=
+		return v.name;=0A=
+	return NULL;=0A=
+}=0A=
+=0A=
 static int set_roles(role_set_t *set,=0A=
 		     char *id)=0A=
 {=0A=
@@ -2710,8 +2744,8 @@ static int define_role_trans(void)=0A=
 =0A=
 			for (tr =3D policydbp->role_tr; tr; tr =3D tr->next) {=0A=
 				if (tr->role =3D=3D (i+1) && tr->type =3D=3D (j+1)) {=0A=
-					sprintf(errormsg, "duplicate role transition defined for (%s,%s)", =0A=
-						policydbp->p_role_val_to_name[i], =
policydbp->p_type_val_to_name[j]);=0A=
+					sprintf(errormsg, "duplicate role transition for (%s,%s)",=0A=
+						role_val_to_name(i + 1), policydbp->p_type_val_to_name[j]);=0A=
 					yyerror(errormsg);=0A=
 					goto bad;=0A=
 				}=0A=
@@ -4530,8 +4564,7 @@ static int define_range_trans(void)=0A=
 			for (rt =3D policydbp->range_tr; rt; rt =3D rt->next) {=0A=
 				if (rt->dom =3D=3D (i + 1) && rt->type =3D=3D (j + 1)) {=0A=
 					sprintf(errormsg, "duplicate range_transition defined for (%s,%s)",=0A=
-					        policydbp->p_type_val_to_name[i + 1],=0A=
-                                                =
policydbp->p_type_val_to_name[j + 1]);=0A=
+					        policydbp->p_type_val_to_name[i], =
policydbp->p_type_val_to_name[j]);=0A=
 					yyerror(errormsg);=0A=
 					return -1;=0A=
 				}=0A=

------=_NextPart_000_0080_01C5C2A3.95C85880--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
