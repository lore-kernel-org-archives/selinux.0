Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8SL6YqA007437
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 17:06:34 -0400
Received: by mail-it0-f65.google.com with SMTP id n143so2716607ita.3
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 14:06:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160928205708.14686-1-nicolas.iooss@m4x.org>
References: <20160928205708.14686-1-nicolas.iooss@m4x.org>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 28 Sep 2016 17:06:31 -0400
Message-ID: <CAFftDdryDVqUhm8YagFQKw5zOXFSjy4GWjPfgCy+NS7zD_Mx0Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] libsepol/cil: do not heap-overflow when too many
 permissions are in a class
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a114457b0467c36053d97bc44
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114457b0467c36053d97bc44
Content-Type: text/plain; charset=UTF-8

On Sep 28, 2016 17:02, "Nicolas Iooss" <nicolas.iooss@m4x.org> wrote:
>
> When compiling a CIL policy with more than 32 items in a class (e.g. in
> (class capability (chown ...)) with many items),
> cil_classorder_to_policydb() overflows perm_value_to_cil[class_index]
> array. As this array is allocated on the heap through
> calloc(PERMS_PER_CLASS+1, sizeof(...)), this makes secilc crash with the
> following message:
>
>     *** Error in `/usr/bin/secilc': double free or corruption (!prev):
0x000000000062be80 ***
>     ======= Backtrace: =========
>     /usr/lib/libc.so.6(+0x70c4b)[0x7ffff76a7c4b]
>     /usr/lib/libc.so.6(+0x76fe6)[0x7ffff76adfe6]
>     /usr/lib/libc.so.6(+0x777de)[0x7ffff76ae7de]
>     /lib/libsepol.so.1(+0x14fbda)[0x7ffff7b24bda]
>     /lib/libsepol.so.1(+0x152db8)[0x7ffff7b27db8]
>     /lib/libsepol.so.1(cil_build_policydb+0x63)[0x7ffff7af8723]
>     /usr/bin/secilc[0x40273b]
>     /usr/lib/libc.so.6(__libc_start_main+0xf1)[0x7ffff7657291]
>     /usr/bin/secilc[0x402f7a]
>
> Fix this by detecting the overflow before adding new permissions to a
> class.
>
> This bug has been found by fuzzing secilc with american fuzzy lop.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsepol/cil/src/cil_binary.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index cc73648ad1b7..d3b3e90df45b 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -332,6 +332,11 @@ int cil_classorder_to_policydb(policydb_t *pdb,
const struct cil_db *db, struct
>                                         goto exit;
>                                 }
>                         }
> +                       if (sepol_class->permissions.nprim +
sepol_common->permissions.nprim > PERMS_PER_CLASS) {
> +                               cil_log(CIL_ERR, "Too many permissions in
class '%s'\n", cil_class->datum.fqn);
> +                               rc = SEPOL_ERR;
> +                               goto exit;
> +                       }
>                         sepol_class->comdatum = sepol_common;
>                         sepol_class->comkey = cil_strdup(key);
>                         sepol_class->permissions.nprim +=
sepol_common->permissions.nprim;
> @@ -344,9 +349,15 @@ int cil_classorder_to_policydb(policydb_t *pdb,
const struct cil_db *db, struct
>
>                 for (curr = NODE(cil_class)->cl_head; curr; curr =
curr->next) {
>                         struct cil_perm *cil_perm = curr->data;
> -                       perm_datum_t *sepol_perm =
cil_malloc(sizeof(*sepol_perm));
> -                       memset(sepol_perm, 0, sizeof(perm_datum_t));
> +                       perm_datum_t *sepol_perm;
>
> +                       if (sepol_class->permissions.nprim + 1 >
PERMS_PER_CLASS)

Is nprim input data? This could overflow here and be 0 right? You probably
want to check if nprim is saturated assuming unsigned.

{
> +                               cil_log(CIL_ERR, "Too many permissions in
class '%s'\n", cil_class->datum.fqn);
> +                               rc = SEPOL_ERR;
> +                               goto exit;
> +                       }
> +                       sepol_perm = cil_malloc(sizeof(*sepol_perm));
> +                       memset(sepol_perm, 0, sizeof(perm_datum_t));
>                         key = cil_strdup(cil_perm->datum.fqn);
>                         rc =
hashtab_insert(sepol_class->permissions.table, key, sepol_perm);
>                         if (rc != SEPOL_OK) {
> --
> 2.10.0
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--001a114457b0467c36053d97bc44
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Sep 28, 2016 17:02, &quot;Nicolas Iooss&quot; &lt;<a href=
=3D"mailto:nicolas.iooss@m4x.org">nicolas.iooss@m4x.org</a>&gt; wrote:<br>
&gt;<br>
&gt; When compiling a CIL policy with more than 32 items in a class (e.g. i=
n<br>
&gt; (class capability (chown ...)) with many items),<br>
&gt; cil_classorder_to_policydb() overflows perm_value_to_cil[class_index]<=
br>
&gt; array. As this array is allocated on the heap through<br>
&gt; calloc(PERMS_PER_CLASS+1, sizeof(...)), this makes secilc crash with t=
he<br>
&gt; following message:<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 *** Error in `/usr/bin/secilc&#39;: double free or corru=
ption (!prev): 0x000000000062be80 ***<br>
&gt; =C2=A0 =C2=A0 =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>
&gt; =C2=A0 =C2=A0 /usr/lib/libc.so.6(+0x70c4b)[0x7ffff76a7c4b]<br>
&gt; =C2=A0 =C2=A0 /usr/lib/libc.so.6(+0x76fe6)[0x7ffff76adfe6]<br>
&gt; =C2=A0 =C2=A0 /usr/lib/libc.so.6(+0x777de)[0x7ffff76ae7de]<br>
&gt; =C2=A0 =C2=A0 /lib/libsepol.so.1(+0x14fbda)[0x7ffff7b24bda]<br>
&gt; =C2=A0 =C2=A0 /lib/libsepol.so.1(+0x152db8)[0x7ffff7b27db8]<br>
&gt; =C2=A0 =C2=A0 /lib/libsepol.so.1(cil_build_policydb+0x63)[0x7ffff7af87=
23]<br>
&gt; =C2=A0 =C2=A0 /usr/bin/secilc[0x40273b]<br>
&gt; =C2=A0 =C2=A0 /usr/lib/libc.so.6(__libc_start_main+0xf1)[0x7ffff765729=
1]<br>
&gt; =C2=A0 =C2=A0 /usr/bin/secilc[0x402f7a]<br>
&gt;<br>
&gt; Fix this by detecting the overflow before adding new permissions to a<=
br>
&gt; class.<br>
&gt;<br>
&gt; This bug has been found by fuzzing secilc with american fuzzy lop.<br>
&gt;<br>
&gt; Signed-off-by: Nicolas Iooss &lt;<a href=3D"mailto:nicolas.iooss@m4x.o=
rg">nicolas.iooss@m4x.org</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0libsepol/cil/src/cil_binary.c | 15 +++++++++++++--<br>
&gt; =C2=A01 file changed, 13 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_bina=
ry.c<br>
&gt; index cc73648ad1b7..d3b3e90df45b 100644<br>
&gt; --- a/libsepol/cil/src/cil_binary.c<br>
&gt; +++ b/libsepol/cil/src/cil_binary.c<br>
&gt; @@ -332,6 +332,11 @@ int cil_classorder_to_policydb(policydb_t *pdb, c=
onst struct cil_db *db, struct<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto =
exit;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (sepol_class-&gt;permissions.nprim + sepol_common-&gt;perm=
issions.nprim &gt; PERMS_PER_CLASS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cil_log(CIL_ERR, &quot;Too many p=
ermissions in class &#39;%s&#39;\n&quot;, cil_class-&gt;datum.fqn);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D SEPOL_ERR;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 sepol_class-&gt;comdatum =3D sepol_common;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 sepol_class-&gt;comkey =3D cil_strdup(key);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 sepol_class-&gt;permissions.nprim +=3D sepol_common-&gt;permi=
ssions.nprim;<br>
&gt; @@ -344,9 +349,15 @@ int cil_classorder_to_policydb(policydb_t *pdb, c=
onst struct cil_db *db, struct<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (curr =3D =
NODE(cil_class)-&gt;cl_head; curr; curr =3D curr-&gt;next) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 struct cil_perm *cil_perm =3D curr-&gt;data;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0perm_datum_t *sepol_perm =3D cil_malloc(sizeof(*sepol_perm));=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0memset(sepol_perm, 0, sizeof(perm_datum_t));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0perm_datum_t *sepol_perm;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (sepol_class-&gt;permissions.nprim + 1 &gt; PERMS_PER_CLAS=
S)</p>
<p dir=3D"ltr">Is nprim input data? This could overflow here and be 0 right=
? You probably want to check if nprim is saturated assuming unsigned.</p>
<p dir=3D"ltr"> {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cil_log(CIL_ERR, &quot;Too many p=
ermissions in class &#39;%s&#39;\n&quot;, cil_class-&gt;datum.fqn);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D SEPOL_ERR;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0sepol_perm =3D cil_malloc(sizeof(*sepol_perm));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0memset(sepol_perm, 0, sizeof(perm_datum_t));<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 key =3D cil_strdup(cil_perm-&gt;datum.fqn);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 rc =3D hashtab_insert(sepol_class-&gt;permissions.table, key,=
 sepol_perm);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (rc !=3D SEPOL_OK) {<br>
&gt; --<br>
&gt; 2.10.0<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>=
</p>

--001a114457b0467c36053d97bc44--
