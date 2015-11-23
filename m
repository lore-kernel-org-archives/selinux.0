Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tANFIK2v002516
 for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2015 10:18:20 -0500
Received: by oies6 with SMTP id s6so129552596oie.1
 for <selinux@tycho.nsa.gov>; Mon, 23 Nov 2015 07:18:15 -0800 (PST)
MIME-Version: 1.0
References: <1448123208-5557-1-git-send-email-richard_c_haines@btinternet.com>
In-Reply-To: <1448123208-5557-1-git-send-email-richard_c_haines@btinternet.com>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Mon, 23 Nov 2015 15:18:05 +0000
Message-ID: <CABXk95DgzRp=HR+t15QjtCs-P3VUeYW38TUnnzebEBvQWw3N_g@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Fully expand neverallowxperm rules
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=089e013a0112ece7b2052536bb12
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e013a0112ece7b2052536bb12
Content-Type: text/plain; charset=UTF-8

Acked-by: Jeff Vander Stoep <jeffv@google.com>

On Sat, Nov 21, 2015 at 8:30 AM Richard Haines <
richard_c_haines@btinternet.com> wrote:

> Currently neverallowxperm rules will be resolved correctly when
> building policy, however they are not detectable when using tools
> such as an updated version of setools. This patch will allow
> these to be viewed in the same way as neverallow rules are in a
> text based kernel policy file (e.g. policy.conf).
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  libsepol/src/expand.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 9047c6d..9cb7965 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -1811,6 +1811,8 @@ static int expand_avrule_helper(sepol_handle_t *
> handle,
>                 if (handle && handle->disable_dontaudit)
>                         return EXPAND_RULE_SUCCESS;
>                 spec = AVTAB_XPERMS_DONTAUDIT;
> +       } else if (specified & AVRULE_XPERMS_NEVERALLOW) {
> +               spec = AVTAB_XPERMS_NEVERALLOW;
>         } else {
>                 assert(0);      /* unreachable */
>         }
> @@ -1948,7 +1950,7 @@ static int convert_and_expand_rule(sepol_handle_t *
> handle,
>
>         if (!do_neverallow && source_rule->specified & AVRULE_NEVERALLOW)
>                 return EXPAND_RULE_SUCCESS;
> -       if (source_rule->specified & AVRULE_XPERMS_NEVERALLOW)
> +       if (!do_neverallow && source_rule->specified &
> AVRULE_XPERMS_NEVERALLOW)
>                 return EXPAND_RULE_SUCCESS;
>
>         ebitmap_init(&stypes);
> --
> 2.5.0
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--089e013a0112ece7b2052536bb12
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Acked-by: Jeff Vander Stoep &lt;<a href=3D"mailto:jeffv@go=
ogle.com" target=3D"_blank">jeffv@google.com</a>&gt;<br><br><div class=3D"g=
mail_quote"><div dir=3D"ltr">On Sat, Nov 21, 2015 at 8:30 AM Richard Haines=
 &lt;<a href=3D"mailto:richard_c_haines@btinternet.com" target=3D"_blank">r=
ichard_c_haines@btinternet.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">Currently neverallowxperm rules will be resolved correctly when<=
br>
building policy, however they are not detectable when using tools<br>
such as an updated version of setools. This patch will allow<br>
these to be viewed in the same way as neverallow rules are in a<br>
text based kernel policy file (e.g. policy.conf).<br>
<br>
Signed-off-by: Richard Haines &lt;<a href=3D"mailto:richard_c_haines@btinte=
rnet.com" target=3D"_blank">richard_c_haines@btinternet.com</a>&gt;<br>
---<br>
=C2=A0libsepol/src/expand.c | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c<br>
index 9047c6d..9cb7965 100644<br>
--- a/libsepol/src/expand.c<br>
+++ b/libsepol/src/expand.c<br>
@@ -1811,6 +1811,8 @@ static int expand_avrule_helper(sepol_handle_t * hand=
le,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (handle &amp;&am=
p; handle-&gt;disable_dontaudit)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return EXPAND_RULE_SUCCESS;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec =3D AVTAB_XPER=
MS_DONTAUDIT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (specified &amp; AVRULE_XPERMS_NEVERA=
LLOW) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spec =3D AVTAB_XPER=
MS_NEVERALLOW;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(0);=C2=A0 =
=C2=A0 =C2=A0 /* unreachable */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
@@ -1948,7 +1950,7 @@ static int convert_and_expand_rule(sepol_handle_t * h=
andle,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!do_neverallow &amp;&amp; source_rule-&gt;s=
pecified &amp; AVRULE_NEVERALLOW)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return EXPAND_RULE_=
SUCCESS;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (source_rule-&gt;specified &amp; AVRULE_XPER=
MS_NEVERALLOW)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!do_neverallow &amp;&amp; source_rule-&gt;s=
pecified &amp; AVRULE_XPERMS_NEVERALLOW)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return EXPAND_RULE_=
SUCCESS;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ebitmap_init(&amp;stypes);<br>
--<br>
2.5.0<br>
<br>
_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.ns=
a.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa=
.gov</a>.<br>
</blockquote></div></div>

--089e013a0112ece7b2052536bb12--
