Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8TBP7OT024942
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 07:25:07 -0400
Received: by mail-it0-f67.google.com with SMTP id x192so4472581itb.0
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 04:24:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c5f03c00-fbad-fe5b-cbb0-330f0fbe7329@m4x.org>
References: <20160928205708.14686-1-nicolas.iooss@m4x.org>
 <CAFftDdryDVqUhm8YagFQKw5zOXFSjy4GWjPfgCy+NS7zD_Mx0Q@mail.gmail.com>
 <049bd4f3-74d6-f460-b703-8135100f2f33@m4x.org>
 <CAFftDdqsoqPgc9zk8YhcdLEQyGzNd2Q86Fhy6o=WQ5RprtTccQ@mail.gmail.com>
 <c5f03c00-fbad-fe5b-cbb0-330f0fbe7329@m4x.org>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 29 Sep 2016 07:24:56 -0400
Message-ID: <CAFftDdrrCsRSFxP4EMaUTufdS59xjHjPZrzknCGFSbpc=uLwwA@mail.gmail.com>
Subject: Re: [PATCH 1/1] libsepol/cil: do not heap-overflow when too many
 permissions are in a class
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a1143ee8e4240d5053da3bacf
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1143ee8e4240d5053da3bacf
Content-Type: text/plain; charset=UTF-8

On Sep 29, 2016 01:44, "Nicolas Iooss" <nicolas.iooss@m4x.org> wrote:
>
> On 29/09/16 00:44, William Roberts wrote:
> > On Wed, Sep 28, 2016 at 5:34 PM, Nicolas Iooss <nicolas.iooss@m4x.org>
wrote:
> >> On 28/09/16 23:06, William Roberts wrote:
> >>> On Sep 28, 2016 17:02, "Nicolas Iooss" <nicolas.iooss@m4x.org
> >>> <mailto:nicolas.iooss@m4x.org>> wrote:
> >>>>
> >>>> When compiling a CIL policy with more than 32 items in a class (e.g.
in
> >>>> (class capability (chown ...)) with many items),
> >>>> cil_classorder_to_policydb() overflows perm_value_to_cil[class_index]
> >>>> array. As this array is allocated on the heap through
> >>>> calloc(PERMS_PER_CLASS+1, sizeof(...)), this makes secilc crash with
the
> >>>> following message:
> >>>>
> >>>>     *** Error in `/usr/bin/secilc': double free or corruption
(!prev):
> >>> 0x000000000062be80 ***
> >>>>     ======= Backtrace: =========
> >>>>     /usr/lib/libc.so.6(+0x70c4b)[0x7ffff76a7c4b]
> >>>>     /usr/lib/libc.so.6(+0x76fe6)[0x7ffff76adfe6]
> >>>>     /usr/lib/libc.so.6(+0x777de)[0x7ffff76ae7de]
> >>>>     /lib/libsepol.so.1(+0x14fbda)[0x7ffff7b24bda]
> >>>>     /lib/libsepol.so.1(+0x152db8)[0x7ffff7b27db8]
> >>>>     /lib/libsepol.so.1(cil_build_policydb+0x63)[0x7ffff7af8723]
> >>>>     /usr/bin/secilc[0x40273b]
> >>>>     /usr/lib/libc.so.6(__libc_start_main+0xf1)[0x7ffff7657291]
> >>>>     /usr/bin/secilc[0x402f7a]
> >>>>
> >>>> Fix this by detecting the overflow before adding new permissions to a
> >>>> class.
> >>>>
> >>>> This bug has been found by fuzzing secilc with american fuzzy lop.
> >>>>
> >>>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org
> >>> <mailto:nicolas.iooss@m4x.org>>
> >>>> ---
> >>>>  libsepol/cil/src/cil_binary.c | 15 +++++++++++++--
> >>>>  1 file changed, 13 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/libsepol/cil/src/cil_binary.c
b/libsepol/cil/src/cil_binary.c
> >>>> index cc73648ad1b7..d3b3e90df45b 100644
> >>>> --- a/libsepol/cil/src/cil_binary.c
> >>>> +++ b/libsepol/cil/src/cil_binary.c
> >>>> @@ -332,6 +332,11 @@ int cil_classorder_to_policydb(policydb_t *pdb,
> >>> const struct cil_db *db, struct
> >>>>                                         goto exit;
> >>>>                                 }
> >>>>                         }
> >>>> +                       if (sepol_class->permissions.nprim +
> >>> sepol_common->permissions.nprim > PERMS_PER_CLASS) {
> >>>> +                               cil_log(CIL_ERR, "Too many
permissions
> >>> in class '%s'\n", cil_class->datum.fqn);
> >>>> +                               rc = SEPOL_ERR;
> >>>> +                               goto exit;
> >>>> +                       }
> >>>>                         sepol_class->comdatum = sepol_common;
> >>>>                         sepol_class->comkey = cil_strdup(key);
> >>>>                         sepol_class->permissions.nprim +=
> >>> sepol_common->permissions.nprim;
> >>>> @@ -344,9 +349,15 @@ int cil_classorder_to_policydb(policydb_t *pdb,
> >>> const struct cil_db *db, struct
> >>>>
> >>>>                 for (curr = NODE(cil_class)->cl_head; curr; curr =
> >>> curr->next) {
> >>>>                         struct cil_perm *cil_perm = curr->data;
> >>>> -                       perm_datum_t *sepol_perm =
> >>> cil_malloc(sizeof(*sepol_perm));
> >>>> -                       memset(sepol_perm, 0, sizeof(perm_datum_t));
> >>>> +                       perm_datum_t *sepol_perm;
> >>>>
> >>>> +                       if (sepol_class->permissions.nprim + 1 >
> >>> PERMS_PER_CLASS)
> >>>
> >>> Is nprim input data? This could overflow here and be 0 right? You
> >>> probably want to check if nprim is saturated assuming unsigned.
> >>
> >> I mostly read the code of cil_classorder_to_policydb() in the way it is
> >> used in secilc: ...permissions.nprim is both the length of an array of
> >> perm_value_to_cil[] (off one) and the length of a linked list of CIL
> >> nodes. Therefore I did not consider the possibility of the addition to
> >> overflow here, and afterwards I still fail to see how it could
overflow.
> >>
> >> In case you want to reproduce the bug, please find attached the source
> >> file I used (it is secilc/test/minimum.cil with 33 permissions defined
> >> in the first class).
> >>
> >
> > Its that both additions in that file, and the nprim++ statements are
> > ripe for overflows.
> >
> > All those additions occur based on the inputs from source code.
> > So, if you defined (uint32_t)~0 amount of classes, you should
> > be able to hit an overflow. nprim itself is a uint32_t.
>
> After a good night sleep I see now "rc =
> symtab_init(&sepol_class->permissions, PERM_SYMTAB_SIZE);" in
> cil_classorder_to_policydb(). This statement initializes
> sepol_class->permissions.nprim with 0. Later nprim is incremented both
> with sepol_common->permissions.nprim (which should be <= 32 and I will
> add a check for this) and one. If I define (uint32_t)~0 permissions in a
> CIL class object, I hit the if() when it crosses 32.

OK if it's hitting that check after every increment then I dont think it
can, that's what i wanted verification .

>
> Is there a way to make nprim equals to a value which would overflow that
> I am missing?

Nothing

>
> -- Nicolas

--001a1143ee8e4240d5053da3bacf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Sep 29, 2016 01:44, &quot;Nicolas Iooss&quot; &lt;<a href=
=3D"mailto:nicolas.iooss@m4x.org">nicolas.iooss@m4x.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On 29/09/16 00:44, William Roberts wrote:<br>
&gt; &gt; On Wed, Sep 28, 2016 at 5:34 PM, Nicolas Iooss &lt;<a href=3D"mai=
lto:nicolas.iooss@m4x.org">nicolas.iooss@m4x.org</a>&gt; wrote:<br>
&gt; &gt;&gt; On 28/09/16 23:06, William Roberts wrote:<br>
&gt; &gt;&gt;&gt; On Sep 28, 2016 17:02, &quot;Nicolas Iooss&quot; &lt;<a h=
ref=3D"mailto:nicolas.iooss@m4x.org">nicolas.iooss@m4x.org</a><br>
&gt; &gt;&gt;&gt; &lt;mailto:<a href=3D"mailto:nicolas.iooss@m4x.org">nicol=
as.iooss@m4x.org</a>&gt;&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; When compiling a CIL policy with more than 32 items i=
n a class (e.g. in<br>
&gt; &gt;&gt;&gt;&gt; (class capability (chown ...)) with many items),<br>
&gt; &gt;&gt;&gt;&gt; cil_classorder_to_policydb() overflows perm_value_to_=
cil[class_index]<br>
&gt; &gt;&gt;&gt;&gt; array. As this array is allocated on the heap through=
<br>
&gt; &gt;&gt;&gt;&gt; calloc(PERMS_PER_CLASS+1, sizeof(...)), this makes se=
cilc crash with the<br>
&gt; &gt;&gt;&gt;&gt; following message:<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0*** Error in `/usr/bin/secilc&#39;=
: double free or corruption (!prev):<br>
&gt; &gt;&gt;&gt; 0x000000000062be80 ***<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D Backtrace: =
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0/usr/lib/libc.so.6(+0x70c4b)[0x7ff=
ff76a7c4b]<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0/usr/lib/libc.so.6(+0x76fe6)[0x7ff=
ff76adfe6]<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0/usr/lib/libc.so.6(+0x777de)[0x7ff=
ff76ae7de]<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0/lib/libsepol.so.1(+0x14fbda)[0x7f=
fff7b24bda]<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0/lib/libsepol.so.1(+0x152db8)[0x7f=
fff7b27db8]<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0/lib/libsepol.so.1(cil_build_polic=
ydb+0x63)[0x7ffff7af8723]<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0/usr/bin/secilc[0x40273b]<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0/usr/lib/libc.so.6(__libc_start_ma=
in+0xf1)[0x7ffff7657291]<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0/usr/bin/secilc[0x402f7a]<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Fix this by detecting the overflow before adding new =
permissions to a<br>
&gt; &gt;&gt;&gt;&gt; class.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; This bug has been found by fuzzing secilc with americ=
an fuzzy lop.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Signed-off-by: Nicolas Iooss &lt;<a href=3D"mailto:ni=
colas.iooss@m4x.org">nicolas.iooss@m4x.org</a><br>
&gt; &gt;&gt;&gt; &lt;mailto:<a href=3D"mailto:nicolas.iooss@m4x.org">nicol=
as.iooss@m4x.org</a>&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 libsepol/cil/src/cil_binary.c | 15 ++++++++++++=
+--<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 1 file changed, 13 insertions(+), 2 deletions(-=
)<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; diff --git a/libsepol/cil/src/cil_binary.c b/libsepol=
/cil/src/cil_binary.c<br>
&gt; &gt;&gt;&gt;&gt; index cc73648ad1b7..d3b3e90df45b 100644<br>
&gt; &gt;&gt;&gt;&gt; --- a/libsepol/cil/src/cil_binary.c<br>
&gt; &gt;&gt;&gt;&gt; +++ b/libsepol/cil/src/cil_binary.c<br>
&gt; &gt;&gt;&gt;&gt; @@ -332,6 +332,11 @@ int cil_classorder_to_policydb(p=
olicydb_t *pdb,<br>
&gt; &gt;&gt;&gt; const struct cil_db *db, struct<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0goto exit;<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sepol_class-&gt;permissions.nprim +<br>
&gt; &gt;&gt;&gt; sepol_common-&gt;permissions.nprim &gt; PERMS_PER_CLASS) =
{<br>
&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cil_log(CIL_ERR,=
 &quot;Too many permissions<br>
&gt; &gt;&gt;&gt; in class &#39;%s&#39;\n&quot;, cil_class-&gt;datum.fqn);<=
br>
&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D SEPOL_ERR=
;<br>
&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto exit;<br>
&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sepol_class-&gt;comdatum =3D sepol_co=
mmon;<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sepol_class-&gt;comkey =3D cil_strdup=
(key);<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sepol_class-&gt;permissions.nprim +=
=3D<br>
&gt; &gt;&gt;&gt; sepol_common-&gt;permissions.nprim;<br>
&gt; &gt;&gt;&gt;&gt; @@ -344,9 +349,15 @@ int cil_classorder_to_policydb(p=
olicydb_t *pdb,<br>
&gt; &gt;&gt;&gt; const struct cil_db *db, struct<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0for (curr =3D NODE(cil_class)-&gt;cl_head; curr; curr =3D<br>
&gt; &gt;&gt;&gt; curr-&gt;next) {<br>
&gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cil_perm *cil_perm =3D curr-&g=
t;data;<br>
&gt; &gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perm_datum_t *sepol_perm =3D<br>
&gt; &gt;&gt;&gt; cil_malloc(sizeof(*sepol_perm));<br>
&gt; &gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(sepol_perm, 0, sizeof(perm_datum_t));=
<br>
&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perm_datum_t *sepol_perm;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sepol_class-&gt;permissions.nprim + 1 &g=
t;<br>
&gt; &gt;&gt;&gt; PERMS_PER_CLASS)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Is nprim input data? This could overflow here and be 0 ri=
ght? You<br>
&gt; &gt;&gt;&gt; probably want to check if nprim is saturated assuming uns=
igned.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I mostly read the code of cil_classorder_to_policydb() in the=
 way it is<br>
&gt; &gt;&gt; used in secilc: ...permissions.nprim is both the length of an=
 array of<br>
&gt; &gt;&gt; perm_value_to_cil[] (off one) and the length of a linked list=
 of CIL<br>
&gt; &gt;&gt; nodes. Therefore I did not consider the possibility of the ad=
dition to<br>
&gt; &gt;&gt; overflow here, and afterwards I still fail to see how it coul=
d overflow.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; In case you want to reproduce the bug, please find attached t=
he source<br>
&gt; &gt;&gt; file I used (it is secilc/test/minimum.cil with 33 permission=
s defined<br>
&gt; &gt;&gt; in the first class).<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; Its that both additions in that file, and the nprim++ statements =
are<br>
&gt; &gt; ripe for overflows.<br>
&gt; &gt;<br>
&gt; &gt; All those additions occur based on the inputs from source code.<b=
r>
&gt; &gt; So, if you defined (uint32_t)~0 amount of classes, you should<br>
&gt; &gt; be able to hit an overflow. nprim itself is a uint32_t.<br>
&gt;<br>
&gt; After a good night sleep I see now &quot;rc =3D<br>
&gt; symtab_init(&amp;sepol_class-&gt;permissions, PERM_SYMTAB_SIZE);&quot;=
 in<br>
&gt; cil_classorder_to_policydb(). This statement initializes<br>
&gt; sepol_class-&gt;permissions.nprim with 0. Later nprim is incremented b=
oth<br>
&gt; with sepol_common-&gt;permissions.nprim (which should be &lt;=3D 32 an=
d I will<br>
&gt; add a check for this) and one. If I define (uint32_t)~0 permissions in=
 a<br>
&gt; CIL class object, I hit the if() when it crosses 32.</p>
<p dir=3D"ltr">OK if it&#39;s hitting that check after every increment then=
 I dont think it can, that&#39;s what i wanted verification .</p>
<p dir=3D"ltr">&gt;<br>
&gt; Is there a way to make nprim equals to a value which would overflow th=
at<br>
&gt; I am missing?</p>
<p dir=3D"ltr">Nothing</p>
<p dir=3D"ltr">&gt;<br>
&gt; -- Nicolas<br></p>

--001a1143ee8e4240d5053da3bacf--
