Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9VE8jgK004972
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2013 10:08:46 -0400
References: <1382398322.27942.61.camel@localhost> <52716BC7.5070005@tycho.nsa.gov>
Message-ID: <1383228520.10830.YahooMailNeo@web87902.mail.ir2.yahoo.com>
Date: Thu, 31 Oct 2013 14:08:40 +0000 (GMT)
From: Richard Haines <richard_c_haines@btinternet.com>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: SELinux: Update policy version to support constraints info
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
In-Reply-To: <52716BC7.5070005@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-153594417-1460649934-1383228520=:10830"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---153594417-1460649934-1383228520=:10830
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Here is my go at another kernel patch. I've done most of what you asked=0Ae=
xcept I could not work out this=A0 comment:=0A=0A"Couldn't we avoid the nee=
d for passing down the policydb and checking=0Athe version just by ensuring=
 e->type_names gets initialized to NULL and=0Athen the type_set_destroy() a=
nd kfree() calls degenerate to no-ops?=A0 I=0Asuppose this works, but it co=
mplicates the code a bit."=0A=0AI've used=A0the /sys/fs/selinux/policy faci=
lity to dump policy and loaded many=0Adifferent policy types/versions and t=
he kernel still lives.=0ARichard=0A=A0=0A----- Original Message -----=0A> F=
rom: Stephen Smalley <sds@tycho.nsa.gov>=0A> To: Eric Paris <eparis@redhat.=
com>=0A> Cc: selinux@tycho.nsa.gov; Richard Haines <richard_c_haines@btinte=
rnet.com>; Paul Moore <paul@paul-moore.com>=0A> Sent: Wednesday, 30 October=
 2013, 20:27=0A> Subject: Re: SELinux: Update policy version to support con=
straints info=0A> =0A> On 10/21/2013 07:32 PM, Eric Paris wrote:=0A>>  From=
: Richard Haines <richard_c_haines@btinternet.com>=0A>>  Date: Tue, 18 Dec =
2012 19:37:46 +0000=0A>> =0A>>  Update the policy version (POLICYDB_VERSION=
_CONSTRAINT_NAMES) to allow=0A>>  holding of policy source info for constra=
ints.=0A>> =0A>>  Signed-off-by: Richard Haines <richard_c_haines@btinterne=
t.com>=0A> =0A> Can we get an updated version of this patch with my comment=
s addressed=0A> so we can get this queued for mainline?=A0 The libsepol/che=
ckpolicy I just=0A> released includes the userspace support, so it would be=
 nice if the=0A> kernel support could become available in the not-too-dista=
nt future.=0A> =0A> =0A>>  ---=0A>> =A0 security/selinux/include/security.h=
 |=A0 =A0 3 +-=0A>> =A0 security/selinux/ss/constraint.h=A0 =A0 |=A0 =A0 1 =
+=0A>> =A0 security/selinux/ss/policydb.c=A0 =A0 =A0 |=A0 100 =0A> ++++++++=
++++++++++++++++++++++++---=0A>> =A0 security/selinux/ss/policydb.h=A0 =A0 =
=A0 |=A0  11 ++++=0A>> =A0 4 files changed, 107 insertions(+), 8 deletions(=
-)=0A>> =0A>>  diff --git a/security/selinux/include/security.h =0A> b/secu=
rity/selinux/include/security.h=0A>>  index 927fc14..bdf0a56 100644=0A>>  -=
-- a/security/selinux/include/security.h=0A>>  +++ b/security/selinux/inclu=
de/security.h=0A>>  @@ -33,13 +33,14 @@=0A>> =A0 #define POLICYDB_VERSION_R=
OLETRANS=A0=A0=A0 26=0A>> =A0 #define POLICYDB_VERSION_NEW_OBJECT_DEFAULTS=
=A0=A0=A0 27=0A>> =A0 #define POLICYDB_VERSION_DEFAULT_TYPE=A0=A0=A0 28=0A>=
>  +#define POLICYDB_VERSION_CONSTRAINT_NAMES=A0=A0=A0 29=0A>> =A0 =0A>> =
=A0 /* Range of policy versions we understand*/=0A>> =A0 #define POLICYDB_V=
ERSION_MIN=A0  POLICYDB_VERSION_BASE=0A>> =A0 #ifdef CONFIG_SECURITY_SELINU=
X_POLICYDB_VERSION_MAX=0A>> =A0 #define POLICYDB_VERSION_MAX=A0=A0=A0 =0A> =
CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE=0A>> =A0 #else=0A>>  -#d=
efine POLICYDB_VERSION_MAX=A0=A0=A0 POLICYDB_VERSION_DEFAULT_TYPE=0A>>  +#d=
efine POLICYDB_VERSION_MAX=A0=A0=A0 POLICYDB_VERSION_CONSTRAINT_NAMES=0A>> =
=A0 #endif=0A>> =A0 =0A>> =A0 /* Mask for just the mount related flags */=
=0A>>  diff --git a/security/selinux/ss/constraint.h =0A> b/security/selinu=
x/ss/constraint.h=0A>>  index 149dda7..3855ea8 100644=0A>>  --- a/security/=
selinux/ss/constraint.h=0A>>  +++ b/security/selinux/ss/constraint.h=0A>>  =
@@ -48,6 +48,7 @@ struct constraint_expr {=0A>> =A0 =A0=A0=A0 u32 op;=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 /* operator */=0A>> =A0 =0A>> =A0 =A0=A0=A0 struct =
ebitmap names;=A0=A0=A0 /* names */=0A>>  +=A0=A0=A0 struct type_set_datum =
*type_names;=0A>> =A0 =0A>> =A0 =A0=A0=A0 struct constraint_expr *next;=A0 =
 /* next expression */=0A>> =A0 };=0A>>  diff --git a/security/selinux/ss/p=
olicydb.c =0A> b/security/selinux/ss/policydb.c=0A>>  index 9cd9b7c..f1b23d=
f 100644=0A>>  --- a/security/selinux/ss/policydb.c=0A>>  +++ b/security/se=
linux/ss/policydb.c=0A>>  @@ -143,6 +143,11 @@ static struct policydb_compa=
t_info policydb_compat[] =3D =0A> {=0A>> =A0 =A0=A0=A0 =A0=A0=A0 .sym_num=
=A0=A0=A0 =3D SYM_NUM,=0A>> =A0 =A0=A0=A0 =A0=A0=A0 .ocon_num=A0=A0=A0 =3D =
OCON_NUM,=0A>> =A0 =A0=A0=A0 },=0A>>  +=A0=A0=A0 {=0A>>  +=A0=A0=A0 =A0=A0=
=A0 .version=A0=A0=A0 =3D POLICYDB_VERSION_CONSTRAINT_NAMES,=0A>>  +=A0=A0=
=A0 =A0=A0=A0 .sym_num=A0=A0=A0 =3D SYM_NUM,=0A>>  +=A0=A0=A0 =A0=A0=A0 .oc=
on_num=A0=A0=A0 =3D OCON_NUM,=0A>>  +=A0=A0=A0 },=0A>> =A0 };=0A>> =A0 =0A>=
> =A0 static struct policydb_compat_info *policydb_lookup_compat(int versio=
n)=0A>>  @@ -613,11 +618,20 @@ static int common_destroy(void *key, void *d=
atum, =0A> void *p)=0A>> =A0 =A0=A0=A0 return 0;=0A>> =A0 }=0A>> =A0 =0A>> =
 -static int cls_destroy(void *key, void *datum, void *p)=0A>>  +static voi=
d type_set_destroy(struct type_set_datum * t)=0A>>  +{=0A>>  +=A0=A0=A0 if =
(t !=3D NULL) {=0A>>  +=A0=A0=A0 =A0=A0=A0 ebitmap_destroy(&t->types);=0A>>=
  +=A0=A0=A0 =A0=A0=A0 ebitmap_destroy(&t->negset);=0A>>  +=A0=A0=A0 }=0A>>=
  +}=0A>>  +=0A>>  +static int cls_destroy(void *key, void *datum, void *da=
tap)=0A>> =A0 {=0A>> =A0 =A0=A0=A0 struct class_datum *cladatum;=0A>> =A0 =
=A0=A0=A0 struct constraint_node *constraint, *ctemp;=0A>> =A0 =A0=A0=A0 st=
ruct constraint_expr *e, *etmp;=0A>>  +=A0=A0=A0 struct policydb *p =3D dat=
ap;=0A>> =A0 =0A>> =A0 =A0=A0=A0 kfree(key);=0A>> =A0 =A0=A0=A0 if (datum) =
{=0A>>  @@ -629,6 +643,10 @@ static int cls_destroy(void *key, void *datum,=
 void =0A> *p)=0A>> =A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 e =3D constraint->exp=
r;=0A>> =A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 while (e) {=0A>> =A0 =A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ebitmap_destroy(&e->names);=0A>>  +=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (p->policyvers >=3D =0A> POLICYDB_VERSION_=
CONSTRAINT_NAMES) {=0A>>  +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 type_set_destroy(e->type_names);=0A>>  +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 kfree(e->type_names);=0A>>  +=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 }=0A>> =A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 etmp =3D e=
;=0A>> =A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 e =3D e->next;=0A>> =A0 =
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 kfree(etmp);=0A>>  @@ -643,6 +661,1=
0 @@ static int cls_destroy(void *key, void *datum, void =0A> *p)=0A>> =A0 =
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 e =3D constraint->expr;=0A>> =A0 =A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 while (e) {=0A>> =A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 ebitmap_destroy(&e->names);=0A>>  +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 if (p->policyvers >=3D =0A> POLICYDB_VERSION_CONSTRAINT_NAMES) {=0A>=
>  +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 type_set_destroy(e->t=
ype_names);=0A>>  +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 kfree(=
e->type_names);=0A>>  +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 }=0A>> =A0 =
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 etmp =3D e;=0A>> =A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 e =3D e->next;=0A>> =A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 kfree(etmp);=0A>>  @@ -775,7 +797,7 @@ void policydb_destr=
oy(struct policydb *p)=0A>> =A0 =0A>> =A0 =A0=A0=A0 for (i =3D 0; i < SYM_N=
UM; i++) {=0A>> =A0 =A0=A0=A0 =A0=A0=A0 cond_resched();=0A>>  -=A0=A0=A0 =
=A0=A0=A0 hashtab_map(p->symtab[i].table, destroy_f[i], NULL);=0A>>  +=A0=
=A0=A0 =A0=A0=A0 hashtab_map(p->symtab[i].table, destroy_f[i], p);=0A>> =A0=
 =A0=A0=A0 =A0=A0=A0 hashtab_destroy(p->symtab[i].table);=0A>> =A0 =A0=A0=
=A0 }=0A>> =A0 =0A>>  @@ -1156,8 +1178,34 @@ bad:=0A>> =A0 =A0=A0=A0 return=
 rc;=0A>> =A0 }=0A>> =A0 =0A>>  -static int read_cons_helper(struct constra=
int_node **nodep, int ncons,=0A>>  -=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 i=
nt allowxtarget, void *fp)=0A>>  +static void type_set_init(struct type_set=
_datum * t)=0A>>  +{=0A>>  +=A0=A0=A0 ebitmap_init(&t->types);=0A>>  +=A0=
=A0=A0 ebitmap_init(&t->negset);=0A>>  +}=0A>>  +=0A>>  +static int type_se=
t_read(struct type_set_datum * t, void *fp)=0A>>  +{=0A>>  +=A0=A0=A0 __le3=
2 buf[1];=0A>>  +=A0=A0=A0 int rc;=0A>>  +=0A>>  +=A0=A0=A0 if (ebitmap_rea=
d(&t->types, fp))=0A>>  +=A0=A0=A0 =A0=A0=A0 return -EINVAL;=0A>>  +=A0=A0=
=A0 if (ebitmap_read(&t->negset, fp))=0A>>  +=A0=A0=A0 =A0=A0=A0 return -EI=
NVAL;=0A>>  +=0A>>  +=A0=A0=A0 rc =3D next_entry(buf, fp, sizeof(u32));=0A>=
>  +=A0=A0=A0 if (rc < 0)=0A>>  +=A0=A0=A0 =A0=A0=A0 return -EINVAL;=0A>>  =
+=A0=A0=A0 t->flags =3D le32_to_cpu(buf[0]);=0A>>  +=0A>>  +=A0=A0=A0 retur=
n 0;=0A>>  +}=0A>>  +=0A>>  +=0A>>  +static int read_cons_helper(struct pol=
icydb *p,=0A>>  +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 struct constraint_=
node **nodep,=0A>>  +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 int ncons, int=
 allowxtarget, void *fp)=0A>> =A0 {=0A>> =A0 =A0=A0=A0 struct constraint_no=
de *c, *lc;=0A>> =A0 =A0=A0=A0 struct constraint_expr *e, *le;=0A>>  @@ -11=
96,6 +1244,7 @@ static int read_cons_helper(struct constraint_node =0A> **n=
odep, int ncons,=0A>> =A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 rc =3D next_entry(b=
uf, fp, (sizeof(u32) * 3));=0A>> =A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (rc)=
=0A>> =A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return rc;=0A>>  +=0A>> =
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 e->expr_type =3D le32_to_cpu(buf[0]);=0A>=
> =A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 e->attr =3D le32_to_cpu(buf[1]);=0A>> =
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 e->op =3D le32_to_cpu(buf[2]);=0A>>  @@ -=
1225,6 +1274,17 @@ static int read_cons_helper(struct constraint_node =0A> =
**nodep, int ncons,=0A>> =A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 rc =3D=
 ebitmap_read(&e->names, fp);=0A>> =A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 if (rc)=0A>> =A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 retu=
rn rc;=0A>>  +=0A>>  +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (p->policy=
vers >=3D =0A> POLICYDB_VERSION_CONSTRAINT_NAMES) {=0A>>  +=A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 e->type_names =3D kzalloc(sizeof(*e->type=
_names), =0A> GFP_KERNEL);=0A>>  +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 if (!e->type_names)=0A>>  +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 return -ENOMEM;=0A>>  +=0A>>  +=A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 type_set_init(e->type_names);=0A>>  +=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 rc =3D type_set_read(e->type_na=
mes, fp);=0A>>  +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (rc)=
=0A>>  +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return =
rc;=0A>>  +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 }=0A>> =A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 break;=0A>> =A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 de=
fault:=0A>> =A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return -EINVAL;=0A>=
>  @@ -1233,6 +1293,7 @@ static int read_cons_helper(struct constraint_node=
 =0A> **nodep, int ncons,=0A>> =A0 =A0=A0=A0 =A0=A0=A0 }=0A>> =A0 =A0=A0=A0=
 =A0=A0=A0 if (depth !=3D 0)=0A>> =A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return =
-EINVAL;=0A>>  +=0A>> =A0 =A0=A0=A0 =A0=A0=A0 lc =3D c;=0A>> =A0 =A0=A0=A0 =
}=0A>> =A0 =0A>>  @@ -1301,7 +1362,7 @@ static int class_read(struct policy=
db *p, struct =0A> hashtab *h, void *fp)=0A>> =A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 goto bad;=0A>> =A0 =A0=A0=A0 }=0A>> =A0 =0A>>  -=A0=A0=A0 rc =3D rea=
d_cons_helper(&cladatum->constraints, ncons, 0, fp);=0A>>  +=A0=A0=A0 rc =
=3D read_cons_helper(p, &cladatum->constraints, ncons, 0, fp);=0A>> =A0 =A0=
=A0=A0 if (rc)=0A>> =A0 =A0=A0=A0 =A0=A0=A0 goto bad;=0A>> =A0 =0A>>  @@ -1=
311,7 +1372,7 @@ static int class_read(struct policydb *p, struct =0A> hash=
tab *h, void *fp)=0A>> =A0 =A0=A0=A0 =A0=A0=A0 if (rc)=0A>> =A0 =A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 goto bad;=0A>> =A0 =A0=A0=A0 =A0=A0=A0 ncons =3D le32_t=
o_cpu(buf[0]);=0A>>  -=A0=A0=A0 =A0=A0=A0 rc =3D read_cons_helper(&cladatum=
->validatetrans, ncons, 1, =0A> fp);=0A>>  +=A0=A0=A0 =A0=A0=A0 rc =3D read=
_cons_helper(p, &cladatum->validatetrans, ncons, =0A> 1, fp);=0A>> =A0 =A0=
=A0=A0 =A0=A0=A0 if (rc)=0A>> =A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 goto bad;=
=0A>> =A0 =A0=A0=A0 }=0A>>  @@ -1339,7 +1400,7 @@ static int class_read(str=
uct policydb *p, struct =0A> hashtab *h, void *fp)=0A>> =A0 =0A>> =A0 =A0=
=A0=A0 return 0;=0A>> =A0 bad:=0A>>  -=A0=A0=A0 cls_destroy(key, cladatum, =
NULL);=0A>>  +=A0=A0=A0 cls_destroy(key, cladatum, p);=0A>> =A0 =A0=A0=A0 r=
eturn rc;=0A>> =A0 }=0A>> =A0 =0A>>  @@ -2750,6 +2811,24 @@ static int comm=
on_write(void *vkey, void *datum, =0A> void *ptr)=0A>> =A0 =A0=A0=A0 return=
 0;=0A>> =A0 }=0A>> =A0 =0A>>  +static int type_set_write(struct type_set_d=
atum * t, void *fp)=0A>>  +{=0A>>  +=A0=A0=A0 int rc;=0A>>  +=A0=A0=A0 __le=
32 buf[1];=0A>>  +=0A>>  +=A0=A0=A0 if (ebitmap_write(&t->types, fp))=0A>> =
 +=A0=A0=A0 =A0=A0=A0 return -EINVAL;=0A>>  +=A0=A0=A0 if (ebitmap_write(&t=
->negset, fp))=0A>>  +=A0=A0=A0 =A0=A0=A0 return -EINVAL;=0A>>  +=0A>>  +=
=A0=A0=A0 buf[0] =3D cpu_to_le32(t->flags);=0A>>  +=A0=A0=A0 rc =3D put_ent=
ry(buf, sizeof(u32), 1, fp);=0A>>  +=A0=A0=A0 if (rc)=0A>>  +=A0=A0=A0 =A0=
=A0=A0 return -EINVAL;=0A>>  +=0A>>  +=A0=A0=A0 return 0;=0A>>  +}=0A>>  +=
=0A>> =A0 static int write_cons_helper(struct policydb *p, struct constrain=
t_node =0A> *node,=0A>> =A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0  void *fp=
)=0A>> =A0 {=0A>>  @@ -2781,6 +2860,13 @@ static int write_cons_helper(stru=
ct policydb *p, =0A> struct constraint_node *node,=0A>> =A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 rc =3D ebitmap_write(&e->names, fp);=0A>> =A0 =
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 if (rc)=0A>> =A0 =A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return rc;=0A>>  +=0A>>  +=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 if (p->policyvers >=3D =0A> POLICYDB_VERSION_CON=
STRAINT_NAMES) {=0A>>  +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 r=
c =3D type_set_write(e->type_names, fp);=0A>>  +=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 if (rc)=0A>>  +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 return rc;=0A>>  +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 }=0A>>  +=0A>> =A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 break;=0A=
>> =A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 default:=0A>> =A0 =A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 break;=0A>>  diff --git a/security/selinux/ss/policydb.=
h =0A> b/security/selinux/ss/policydb.h=0A>>  index da63747..c0bb6cb 100644=
=0A>>  --- a/security/selinux/ss/policydb.h=0A>>  +++ b/security/selinux/ss=
/policydb.h=0A>>  @@ -154,6 +154,17 @@ struct cond_bool_datum {=0A>> =A0 st=
ruct cond_node;=0A>> =A0 =0A>> =A0 /*=0A>>  + * type set preserves data nee=
ded to determine constraint info from=0A>>  + * policy source. This is not =
used by the kernel policy but allows=0A>>  + * utilities such as audit2allo=
w to determine constraint denials.=0A>>  + */=0A>>  +struct type_set_datum =
{=0A>>  +=A0=A0=A0 struct ebitmap types;=0A>>  +=A0=A0=A0 struct ebitmap ne=
gset;=0A>>  +=A0=A0=A0 u32 flags;=0A>>  +};=0A>>  +=0A>>  +/*=0A>> =A0  * T=
he configuration data includes security contexts for=0A>> =A0  * initial SI=
Ds, unlabeled file systems, TCP and UDP port numbers,=0A>> =A0  * network i=
nterfaces, and nodes.=A0 This structure stores the=0A>> =0A> =0A> =0A> --=
=0A> This message was distributed to subscribers of the selinux mailing lis=
t.=0A> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa=
.gov with=0A> the words "unsubscribe selinux" without quotes as the message=
.=0A>  
---153594417-1460649934-1383228520=:10830
Content-Type: text/plain; name="0001-SELinux-Update-policy-version-to-support-constraints.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-SELinux-Update-policy-version-to-support-constraints.patch"

RnJvbSBiYmE5N2I3NzI0Y2E2MmQ4ZGI5NWFlOWI3NDE5MzE2MWM4Mzg1ZTRi
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBSaWNoYXJkIEhhaW5l
cyA8cmljaGFyZF9jX2hhaW5lc0BidGludGVybmV0LmNvbT4KRGF0ZTogU2F0
LCAyNiBPY3QgMjAxMyAxNTozOToxMCArMDEwMApTdWJqZWN0OiBbUEFUQ0hd
IFNFTGludXg6IFVwZGF0ZSBwb2xpY3kgdmVyc2lvbiB0byBzdXBwb3J0IGNv
bnN0cmFpbnRzIGluZm8KClVwZGF0ZSB0aGUgcG9saWN5IHZlcnNpb24gKFBP
TElDWURCX1ZFUlNJT05fQ09OU1RSQUlOVF9OQU1FUykgdG8gYWxsb3cKaG9s
ZGluZyBvZiBwb2xpY3kgc291cmNlIGluZm8gZm9yIGNvbnN0cmFpbnRzLgoK
U2lnbmVkLW9mZi1ieTogUmljaGFyZCBIYWluZXMgPHJpY2hhcmRfY19oYWlu
ZXNAYnRpbnRlcm5ldC5jb20+Ci0tLQogc2VjdXJpdHkvc2VsaW51eC9pbmNs
dWRlL3NlY3VyaXR5LmggfCAgMyArLQogc2VjdXJpdHkvc2VsaW51eC9zcy9j
b25zdHJhaW50LmggICAgfCAgMSArCiBzZWN1cml0eS9zZWxpbnV4L3NzL3Bv
bGljeWRiLmMgICAgICB8IDk1ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0KIHNlY3VyaXR5L3NlbGludXgvc3MvcG9saWN5ZGIuaCAg
ICAgIHwgMTEgKysrKysKIDQgZmlsZXMgY2hhbmdlZCwgOTggaW5zZXJ0aW9u
cygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc2VjdXJpdHkv
c2VsaW51eC9pbmNsdWRlL3NlY3VyaXR5LmggYi9zZWN1cml0eS9zZWxpbnV4
L2luY2x1ZGUvc2VjdXJpdHkuaAppbmRleCA5MjdmYzE0Li5iZGYwYTU2IDEw
MDY0NAotLS0gYS9zZWN1cml0eS9zZWxpbnV4L2luY2x1ZGUvc2VjdXJpdHku
aAorKysgYi9zZWN1cml0eS9zZWxpbnV4L2luY2x1ZGUvc2VjdXJpdHkuaApA
QCAtMzMsMTMgKzMzLDE0IEBACiAjZGVmaW5lIFBPTElDWURCX1ZFUlNJT05f
Uk9MRVRSQU5TCTI2CiAjZGVmaW5lIFBPTElDWURCX1ZFUlNJT05fTkVXX09C
SkVDVF9ERUZBVUxUUwkyNwogI2RlZmluZSBQT0xJQ1lEQl9WRVJTSU9OX0RF
RkFVTFRfVFlQRQkyOAorI2RlZmluZSBQT0xJQ1lEQl9WRVJTSU9OX0NPTlNU
UkFJTlRfTkFNRVMJMjkKIAogLyogUmFuZ2Ugb2YgcG9saWN5IHZlcnNpb25z
IHdlIHVuZGVyc3RhbmQqLwogI2RlZmluZSBQT0xJQ1lEQl9WRVJTSU9OX01J
TiAgIFBPTElDWURCX1ZFUlNJT05fQkFTRQogI2lmZGVmIENPTkZJR19TRUNV
UklUWV9TRUxJTlVYX1BPTElDWURCX1ZFUlNJT05fTUFYCiAjZGVmaW5lIFBP
TElDWURCX1ZFUlNJT05fTUFYCUNPTkZJR19TRUNVUklUWV9TRUxJTlVYX1BP
TElDWURCX1ZFUlNJT05fTUFYX1ZBTFVFCiAjZWxzZQotI2RlZmluZSBQT0xJ
Q1lEQl9WRVJTSU9OX01BWAlQT0xJQ1lEQl9WRVJTSU9OX0RFRkFVTFRfVFlQ
RQorI2RlZmluZSBQT0xJQ1lEQl9WRVJTSU9OX01BWAlQT0xJQ1lEQl9WRVJT
SU9OX0NPTlNUUkFJTlRfTkFNRVMKICNlbmRpZgogCiAvKiBNYXNrIGZvciBq
dXN0IHRoZSBtb3VudCByZWxhdGVkIGZsYWdzICovCmRpZmYgLS1naXQgYS9z
ZWN1cml0eS9zZWxpbnV4L3NzL2NvbnN0cmFpbnQuaCBiL3NlY3VyaXR5L3Nl
bGludXgvc3MvY29uc3RyYWludC5oCmluZGV4IDE0OWRkYTcuLjk2ZmQ5NDcg
MTAwNjQ0Ci0tLSBhL3NlY3VyaXR5L3NlbGludXgvc3MvY29uc3RyYWludC5o
CisrKyBiL3NlY3VyaXR5L3NlbGludXgvc3MvY29uc3RyYWludC5oCkBAIC00
OCw2ICs0OCw3IEBAIHN0cnVjdCBjb25zdHJhaW50X2V4cHIgewogCXUzMiBv
cDsJCQkvKiBvcGVyYXRvciAqLwogCiAJc3RydWN0IGViaXRtYXAgbmFtZXM7
CS8qIG5hbWVzICovCisJc3RydWN0IHR5cGVfc2V0ICp0eXBlX25hbWVzOwog
CiAJc3RydWN0IGNvbnN0cmFpbnRfZXhwciAqbmV4dDsgICAvKiBuZXh0IGV4
cHJlc3Npb24gKi8KIH07CmRpZmYgLS1naXQgYS9zZWN1cml0eS9zZWxpbnV4
L3NzL3BvbGljeWRiLmMgYi9zZWN1cml0eS9zZWxpbnV4L3NzL3BvbGljeWRi
LmMKaW5kZXggOWNkOWI3Yy4uM2ZjZDc1ZCAxMDA2NDQKLS0tIGEvc2VjdXJp
dHkvc2VsaW51eC9zcy9wb2xpY3lkYi5jCisrKyBiL3NlY3VyaXR5L3NlbGlu
dXgvc3MvcG9saWN5ZGIuYwpAQCAtMTQzLDYgKzE0MywxMSBAQCBzdGF0aWMg
c3RydWN0IHBvbGljeWRiX2NvbXBhdF9pbmZvIHBvbGljeWRiX2NvbXBhdFtd
ID0gewogCQkuc3ltX251bQk9IFNZTV9OVU0sCiAJCS5vY29uX251bQk9IE9D
T05fTlVNLAogCX0sCisJeworCQkudmVyc2lvbgk9IFBPTElDWURCX1ZFUlNJ
T05fQ09OU1RSQUlOVF9OQU1FUywKKwkJLnN5bV9udW0JPSBTWU1fTlVNLAor
CQkub2Nvbl9udW0JPSBPQ09OX05VTSwKKwl9LAogfTsKIAogc3RhdGljIHN0
cnVjdCBwb2xpY3lkYl9jb21wYXRfaW5mbyAqcG9saWN5ZGJfbG9va3VwX2Nv
bXBhdChpbnQgdmVyc2lvbikKQEAgLTYxMyw2ICs2MTgsMTkgQEAgc3RhdGlj
IGludCBjb21tb25fZGVzdHJveSh2b2lkICprZXksIHZvaWQgKmRhdHVtLCB2
b2lkICpwKQogCXJldHVybiAwOwogfQogCitzdGF0aWMgdm9pZCBjb25zdHJh
aW50X2V4cHJfZGVzdHJveShzdHJ1Y3QgY29uc3RyYWludF9leHByICpleHBy
KQoreworCWlmIChleHByICE9IE5VTEwpIHsKKwkJZWJpdG1hcF9kZXN0cm95
KCZleHByLT5uYW1lcyk7CisJCWlmIChleHByLT50eXBlX25hbWVzICE9IE5V
TEwpIHsKKwkJCWViaXRtYXBfZGVzdHJveSgmZXhwci0+dHlwZV9uYW1lcy0+
dHlwZXMpOworCQkJZWJpdG1hcF9kZXN0cm95KCZleHByLT50eXBlX25hbWVz
LT5uZWdzZXQpOworCQkJa2ZyZWUoZXhwci0+dHlwZV9uYW1lcyk7CisJCX0K
KwkJa2ZyZWUoZXhwcik7CisJfQorfQorCiBzdGF0aWMgaW50IGNsc19kZXN0
cm95KHZvaWQgKmtleSwgdm9pZCAqZGF0dW0sIHZvaWQgKnApCiB7CiAJc3Ry
dWN0IGNsYXNzX2RhdHVtICpjbGFkYXR1bTsKQEAgLTYyOCwxMCArNjQ2LDkg
QEAgc3RhdGljIGludCBjbHNfZGVzdHJveSh2b2lkICprZXksIHZvaWQgKmRh
dHVtLCB2b2lkICpwKQogCQl3aGlsZSAoY29uc3RyYWludCkgewogCQkJZSA9
IGNvbnN0cmFpbnQtPmV4cHI7CiAJCQl3aGlsZSAoZSkgewotCQkJCWViaXRt
YXBfZGVzdHJveSgmZS0+bmFtZXMpOwogCQkJCWV0bXAgPSBlOwogCQkJCWUg
PSBlLT5uZXh0OwotCQkJCWtmcmVlKGV0bXApOworCQkJCWNvbnN0cmFpbnRf
ZXhwcl9kZXN0cm95KGV0bXApOwogCQkJfQogCQkJY3RlbXAgPSBjb25zdHJh
aW50OwogCQkJY29uc3RyYWludCA9IGNvbnN0cmFpbnQtPm5leHQ7CkBAIC02
NDIsMTYgKzY1OSwxNCBAQCBzdGF0aWMgaW50IGNsc19kZXN0cm95KHZvaWQg
KmtleSwgdm9pZCAqZGF0dW0sIHZvaWQgKnApCiAJCXdoaWxlIChjb25zdHJh
aW50KSB7CiAJCQllID0gY29uc3RyYWludC0+ZXhwcjsKIAkJCXdoaWxlIChl
KSB7Ci0JCQkJZWJpdG1hcF9kZXN0cm95KCZlLT5uYW1lcyk7CiAJCQkJZXRt
cCA9IGU7CiAJCQkJZSA9IGUtPm5leHQ7Ci0JCQkJa2ZyZWUoZXRtcCk7CisJ
CQkJY29uc3RyYWludF9leHByX2Rlc3Ryb3koZXRtcCk7CiAJCQl9CiAJCQlj
dGVtcCA9IGNvbnN0cmFpbnQ7CiAJCQljb25zdHJhaW50ID0gY29uc3RyYWlu
dC0+bmV4dDsKIAkJCWtmcmVlKGN0ZW1wKTsKIAkJfQotCiAJCWtmcmVlKGNs
YWRhdHVtLT5jb21rZXkpOwogCX0KIAlrZnJlZShkYXR1bSk7CkBAIC03NzUs
NyArNzkwLDcgQEAgdm9pZCBwb2xpY3lkYl9kZXN0cm95KHN0cnVjdCBwb2xp
Y3lkYiAqcCkKIAogCWZvciAoaSA9IDA7IGkgPCBTWU1fTlVNOyBpKyspIHsK
IAkJY29uZF9yZXNjaGVkKCk7Ci0JCWhhc2h0YWJfbWFwKHAtPnN5bXRhYltp
XS50YWJsZSwgZGVzdHJveV9mW2ldLCBOVUxMKTsKKwkJaGFzaHRhYl9tYXAo
cC0+c3ltdGFiW2ldLnRhYmxlLCBkZXN0cm95X2ZbaV0sIHApOwogCQloYXNo
dGFiX2Rlc3Ryb3kocC0+c3ltdGFiW2ldLnRhYmxlKTsKIAl9CiAKQEAgLTEx
NTYsOCArMTE3MSwzNCBAQCBiYWQ6CiAJcmV0dXJuIHJjOwogfQogCi1zdGF0
aWMgaW50IHJlYWRfY29uc19oZWxwZXIoc3RydWN0IGNvbnN0cmFpbnRfbm9k
ZSAqKm5vZGVwLCBpbnQgbmNvbnMsCi0JCQkgICAgaW50IGFsbG93eHRhcmdl
dCwgdm9pZCAqZnApCitzdGF0aWMgdm9pZCB0eXBlX3NldF9pbml0KHN0cnVj
dCB0eXBlX3NldCAqdCkKK3sKKwllYml0bWFwX2luaXQoJnQtPnR5cGVzKTsK
KwllYml0bWFwX2luaXQoJnQtPm5lZ3NldCk7Cit9CisKK3N0YXRpYyBpbnQg
dHlwZV9zZXRfcmVhZChzdHJ1Y3QgdHlwZV9zZXQgKnQsIHZvaWQgKmZwKQor
eworCV9fbGUzMiBidWZbMV07CisJaW50IHJjOworCisJaWYgKGViaXRtYXBf
cmVhZCgmdC0+dHlwZXMsIGZwKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisJaWYg
KGViaXRtYXBfcmVhZCgmdC0+bmVnc2V0LCBmcCkpCisJCXJldHVybiAtRUlO
VkFMOworCisJcmMgPSBuZXh0X2VudHJ5KGJ1ZiwgZnAsIHNpemVvZih1MzIp
KTsKKwlpZiAocmMgPCAwKQorCQlyZXR1cm4gLUVJTlZBTDsKKwl0LT5mbGFn
cyA9IGxlMzJfdG9fY3B1KGJ1ZlswXSk7CisKKwlyZXR1cm4gMDsKK30KKwor
CitzdGF0aWMgaW50IHJlYWRfY29uc19oZWxwZXIoc3RydWN0IHBvbGljeWRi
ICpwLAorCQkJCXN0cnVjdCBjb25zdHJhaW50X25vZGUgKipub2RlcCwKKwkJ
CQlpbnQgbmNvbnMsIGludCBhbGxvd3h0YXJnZXQsIHZvaWQgKmZwKQogewog
CXN0cnVjdCBjb25zdHJhaW50X25vZGUgKmMsICpsYzsKIAlzdHJ1Y3QgY29u
c3RyYWludF9leHByICplLCAqbGU7CkBAIC0xMjI1LDYgKzEyNjYsMTUgQEAg
c3RhdGljIGludCByZWFkX2NvbnNfaGVscGVyKHN0cnVjdCBjb25zdHJhaW50
X25vZGUgKipub2RlcCwgaW50IG5jb25zLAogCQkJCXJjID0gZWJpdG1hcF9y
ZWFkKCZlLT5uYW1lcywgZnApOwogCQkJCWlmIChyYykKIAkJCQkJcmV0dXJu
IHJjOworCQkJCWlmIChwLT5wb2xpY3l2ZXJzID49IFBPTElDWURCX1ZFUlNJ
T05fQ09OU1RSQUlOVF9OQU1FUykgeworCQkJCQllLT50eXBlX25hbWVzID0g
a3phbGxvYyhzaXplb2YoKmUtPnR5cGVfbmFtZXMpLCBHRlBfS0VSTkVMKTsK
KwkJCQkJaWYgKCFlLT50eXBlX25hbWVzKQorCQkJCQkJcmV0dXJuIC1FTk9N
RU07CisJCQkJCXR5cGVfc2V0X2luaXQoZS0+dHlwZV9uYW1lcyk7CisJCQkJ
CXJjID0gdHlwZV9zZXRfcmVhZChlLT50eXBlX25hbWVzLCBmcCk7CisJCQkJ
CWlmIChyYykKKwkJCQkJCXJldHVybiByYzsKKwkJCQl9CiAJCQkJYnJlYWs7
CiAJCQlkZWZhdWx0OgogCQkJCXJldHVybiAtRUlOVkFMOwpAQCAtMTMwMSw3
ICsxMzUxLDcgQEAgc3RhdGljIGludCBjbGFzc19yZWFkKHN0cnVjdCBwb2xp
Y3lkYiAqcCwgc3RydWN0IGhhc2h0YWIgKmgsIHZvaWQgKmZwKQogCQkJZ290
byBiYWQ7CiAJfQogCi0JcmMgPSByZWFkX2NvbnNfaGVscGVyKCZjbGFkYXR1
bS0+Y29uc3RyYWludHMsIG5jb25zLCAwLCBmcCk7CisJcmMgPSByZWFkX2Nv
bnNfaGVscGVyKHAsICZjbGFkYXR1bS0+Y29uc3RyYWludHMsIG5jb25zLCAw
LCBmcCk7CiAJaWYgKHJjKQogCQlnb3RvIGJhZDsKIApAQCAtMTMxMSw3ICsx
MzYxLDcgQEAgc3RhdGljIGludCBjbGFzc19yZWFkKHN0cnVjdCBwb2xpY3lk
YiAqcCwgc3RydWN0IGhhc2h0YWIgKmgsIHZvaWQgKmZwKQogCQlpZiAocmMp
CiAJCQlnb3RvIGJhZDsKIAkJbmNvbnMgPSBsZTMyX3RvX2NwdShidWZbMF0p
OwotCQlyYyA9IHJlYWRfY29uc19oZWxwZXIoJmNsYWRhdHVtLT52YWxpZGF0
ZXRyYW5zLCBuY29ucywgMSwgZnApOworCQlyYyA9IHJlYWRfY29uc19oZWxw
ZXIocCwgJmNsYWRhdHVtLT52YWxpZGF0ZXRyYW5zLCBuY29ucywgMSwgZnAp
OwogCQlpZiAocmMpCiAJCQlnb3RvIGJhZDsKIAl9CkBAIC0xMzM5LDcgKzEz
ODksNyBAQCBzdGF0aWMgaW50IGNsYXNzX3JlYWQoc3RydWN0IHBvbGljeWRi
ICpwLCBzdHJ1Y3QgaGFzaHRhYiAqaCwgdm9pZCAqZnApCiAKIAlyZXR1cm4g
MDsKIGJhZDoKLQljbHNfZGVzdHJveShrZXksIGNsYWRhdHVtLCBOVUxMKTsK
KwljbHNfZGVzdHJveShrZXksIGNsYWRhdHVtLCBwKTsKIAlyZXR1cm4gcmM7
CiB9CiAKQEAgLTI3NTAsNiArMjgwMCwyNCBAQCBzdGF0aWMgaW50IGNvbW1v
bl93cml0ZSh2b2lkICp2a2V5LCB2b2lkICpkYXR1bSwgdm9pZCAqcHRyKQog
CXJldHVybiAwOwogfQogCitzdGF0aWMgaW50IHR5cGVfc2V0X3dyaXRlKHN0
cnVjdCB0eXBlX3NldCAqdCwgdm9pZCAqZnApCit7CisJaW50IHJjOworCV9f
bGUzMiBidWZbMV07CisKKwlpZiAoZWJpdG1hcF93cml0ZSgmdC0+dHlwZXMs
IGZwKSkKKwkJcmV0dXJuIC1FSU5WQUw7CisJaWYgKGViaXRtYXBfd3JpdGUo
JnQtPm5lZ3NldCwgZnApKQorCQlyZXR1cm4gLUVJTlZBTDsKKworCWJ1Zlsw
XSA9IGNwdV90b19sZTMyKHQtPmZsYWdzKTsKKwlyYyA9IHB1dF9lbnRyeShi
dWYsIHNpemVvZih1MzIpLCAxLCBmcCk7CisJaWYgKHJjKQorCQlyZXR1cm4g
LUVJTlZBTDsKKworCXJldHVybiAwOworfQorCiBzdGF0aWMgaW50IHdyaXRl
X2NvbnNfaGVscGVyKHN0cnVjdCBwb2xpY3lkYiAqcCwgc3RydWN0IGNvbnN0
cmFpbnRfbm9kZSAqbm9kZSwKIAkJCSAgICAgdm9pZCAqZnApCiB7CkBAIC0y
NzgxLDYgKzI4NDksMTEgQEAgc3RhdGljIGludCB3cml0ZV9jb25zX2hlbHBl
cihzdHJ1Y3QgcG9saWN5ZGIgKnAsIHN0cnVjdCBjb25zdHJhaW50X25vZGUg
Km5vZGUsCiAJCQkJcmMgPSBlYml0bWFwX3dyaXRlKCZlLT5uYW1lcywgZnAp
OwogCQkJCWlmIChyYykKIAkJCQkJcmV0dXJuIHJjOworCQkJCWlmIChwLT5w
b2xpY3l2ZXJzID49IFBPTElDWURCX1ZFUlNJT05fQ09OU1RSQUlOVF9OQU1F
UykgeworCQkJCQlyYyA9IHR5cGVfc2V0X3dyaXRlKGUtPnR5cGVfbmFtZXMs
IGZwKTsKKwkJCQkJaWYgKHJjKQorCQkJCQkJcmV0dXJuIHJjOworCQkJCX0K
IAkJCQlicmVhazsKIAkJCWRlZmF1bHQ6CiAJCQkJYnJlYWs7CmRpZmYgLS1n
aXQgYS9zZWN1cml0eS9zZWxpbnV4L3NzL3BvbGljeWRiLmggYi9zZWN1cml0
eS9zZWxpbnV4L3NzL3BvbGljeWRiLmgKaW5kZXggZGE2Mzc0Ny4uNzI1ZDU5
NCAxMDA2NDQKLS0tIGEvc2VjdXJpdHkvc2VsaW51eC9zcy9wb2xpY3lkYi5o
CisrKyBiL3NlY3VyaXR5L3NlbGludXgvc3MvcG9saWN5ZGIuaApAQCAtMTU0
LDYgKzE1NCwxNyBAQCBzdHJ1Y3QgY29uZF9ib29sX2RhdHVtIHsKIHN0cnVj
dCBjb25kX25vZGU7CiAKIC8qCisgKiB0eXBlIHNldCBwcmVzZXJ2ZXMgZGF0
YSBuZWVkZWQgdG8gZGV0ZXJtaW5lIGNvbnN0cmFpbnQgaW5mbyBmcm9tCisg
KiBwb2xpY3kgc291cmNlLiBUaGlzIGlzIG5vdCB1c2VkIGJ5IHRoZSBrZXJu
ZWwgcG9saWN5IGJ1dCBhbGxvd3MKKyAqIHV0aWxpdGllcyBzdWNoIGFzIGF1
ZGl0MmFsbG93IHRvIGRldGVybWluZSBjb25zdHJhaW50IGRlbmlhbHMuCisg
Ki8KK3N0cnVjdCB0eXBlX3NldCB7CisJc3RydWN0IGViaXRtYXAgdHlwZXM7
CisJc3RydWN0IGViaXRtYXAgbmVnc2V0OworCXUzMiBmbGFnczsKK307CisK
Ky8qCiAgKiBUaGUgY29uZmlndXJhdGlvbiBkYXRhIGluY2x1ZGVzIHNlY3Vy
aXR5IGNvbnRleHRzIGZvcgogICogaW5pdGlhbCBTSURzLCB1bmxhYmVsZWQg
ZmlsZSBzeXN0ZW1zLCBUQ1AgYW5kIFVEUCBwb3J0IG51bWJlcnMsCiAgKiBu
ZXR3b3JrIGludGVyZmFjZXMsIGFuZCBub2Rlcy4gIFRoaXMgc3RydWN0dXJl
IHN0b3JlcyB0aGUKLS0gCjEuOC4zLjEKCg==

---153594417-1460649934-1383228520=:10830--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
