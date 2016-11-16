MIME-Version: 1.0
In-Reply-To: <1479256943-26743-1-git-send-email-william.c.roberts@intel.com>
References: <1479256943-26743-1-git-send-email-william.c.roberts@intel.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 15 Nov 2016 18:50:37 -0800
Message-ID: <CAFftDdohxuOTiWLoLQdWd-T46_5oPVZQ8W5PVz3oH=acnKGgwQ@mail.gmail.com>
Subject: Re: [PATCH take2 v6] libsepol: fix checkpolicy dontaudit compiler bug
To: William Roberts <william.c.roberts@intel.com>
Cc: Nick Kralevich <nnk@google.com>, selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=94eb2c115d464bdd140541622322
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c115d464bdd140541622322
Content-Type: text/plain; charset=UTF-8

On Nov 15, 2016 4:43 PM, <william.c.roberts@intel.com> wrote:
>
> From: William Roberts <william.c.roberts@intel.com>
>
> The combining logic for dontaudit rules was wrong, causing
> a dontaudit A B:C *; rule to be clobbered by a dontaudit A B:C p;
> rule.
>
> This is a reimplementation of:
> commit 6201bb5e258e2b5bcc04d502d6fbc05c69d21d71 ("libsepol:
> fix checkpolicy dontaudit compiler bug")
> that avoids the cumbersome pointer assignments on alloced.
>
> Reported-by: Nick Kralevich <nnk@google.com>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  libsepol/src/expand.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 004a029..3e16f58 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -1640,6 +1640,11 @@ static avtab_ptr_t find_avtab_node(sepol_handle_t
* handle,
>
>         if (!node) {
>                 memset(&avdatum, 0, sizeof avdatum);
> +               /*
> +                * AUDITDENY, aka DONTAUDIT, are &= assigned, versus |=
for
> +                * others. Initialize the data accordingly.
> +                */
> +               avdatum.data = key->specified == AVTAB_AUDITDENY ? ~0 : 0;
>                 /* this is used to get the node - insertion is actually
unique */
>                 node = avtab_insert_nonunique(avtab, key, &avdatum);
>                 if (!node) {
> @@ -1850,10 +1855,7 @@ static int expand_avrule_helper(sepol_handle_t *
handle,
>                          */
>                         avdatump->data &= cur->data;
>                 } else if (specified & AVRULE_DONTAUDIT) {
> -                       if (avdatump->data)
> -                               avdatump->data &= ~cur->data;
> -                       else
> -                               avdatump->data = ~cur->data;
> +                       avdatump->data &= ~cur->data;
>                 } else if (specified & AVRULE_XPERMS) {
>                         xperms = avdatump->xperms;
>                         if (!xperms) {
> --
> 2.7.4
>

This patch has the same sesearch and policy file md5sums compared to master
and after reverting + applying this.

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--94eb2c115d464bdd140541622322
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Nov 15, 2016 4:43 PM, &lt;<a href=3D"mailto:william.c.rob=
erts@intel.com">william.c.roberts@intel.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: William Roberts &lt;<a href=3D"mailto:william.c.roberts@intel.co=
m">william.c.roberts@intel.com</a>&gt;<br>
&gt;<br>
&gt; The combining logic for dontaudit rules was wrong, causing<br>
&gt; a dontaudit A B:C *; rule to be clobbered by a dontaudit A B:C p;<br>
&gt; rule.<br>
&gt;<br>
&gt; This is a reimplementation of:<br>
&gt; commit 6201bb5e258e2b5bcc04d502d6fbc05c69d21d71 (&quot;libsepol:<br>
&gt; fix checkpolicy dontaudit compiler bug&quot;)<br>
&gt; that avoids the cumbersome pointer assignments on alloced.<br>
&gt;<br>
&gt; Reported-by: Nick Kralevich &lt;<a href=3D"mailto:nnk@google.com">nnk@=
google.com</a>&gt;<br>
&gt; Signed-off-by: William Roberts &lt;<a href=3D"mailto:william.c.roberts=
@intel.com">william.c.roberts@intel.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0libsepol/src/expand.c | 10 ++++++----<br>
&gt; =C2=A01 file changed, 6 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c<br>
&gt; index 004a029..3e16f58 100644<br>
&gt; --- a/libsepol/src/expand.c<br>
&gt; +++ b/libsepol/src/expand.c<br>
&gt; @@ -1640,6 +1640,11 @@ static avtab_ptr_t find_avtab_node(sepol_handle=
_t * handle,<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!node) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&amp;av=
datum, 0, sizeof avdatum);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * AUDITDENY, =
aka DONTAUDIT, are &amp;=3D assigned, versus |=3D for<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * others. Ini=
tialize the data accordingly.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0avdatum.data =
=3D key-&gt;specified =3D=3D AVTAB_AUDITDENY ? ~0 : 0;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* this is use=
d to get the node - insertion is actually unique */<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node =3D avtab=
_insert_nonunique(avtab, key, &amp;avdatum);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!node) {<b=
r>
&gt; @@ -1850,10 +1855,7 @@ static int expand_avrule_helper(sepol_handle_t =
* handle,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 avdatump-&gt;data &amp;=3D cur-&gt;data;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (spe=
cified &amp; AVRULE_DONTAUDIT) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (avdatump-&gt;data)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0avdatump-&gt;data &amp;=3D ~cur-&=
gt;data;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0else<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0avdatump-&gt;data =3D ~cur-&gt;da=
ta;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0avdatump-&gt;data &amp;=3D ~cur-&gt;data;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (spe=
cified &amp; AVRULE_XPERMS) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 xperms =3D avdatump-&gt;xperms;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (!xperms) {<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;</p>
<p dir=3D"ltr">This patch has the same sesearch and policy file md5sums com=
pared to master and after reverting + applying this.<br></p>
<p dir=3D"ltr">&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>=
</p>

--94eb2c115d464bdd140541622322--
