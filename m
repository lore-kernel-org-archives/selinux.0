Received: from goalie.tycho.ncsc.mil (goalie.tycho.ncsc.mil [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w93I7wqF020013
 for <selinux@tycho.nsa.gov>; Wed, 3 Oct 2018 14:07:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so7130257wrr.4
 for <selinux@tycho.nsa.gov>; Wed, 03 Oct 2018 11:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181003155007.26898-1-omosnace@redhat.com>
In-Reply-To: <20181003155007.26898-1-omosnace@redhat.com>
From: Jason Zaman <jason@perfinion.com>
Date: Thu, 4 Oct 2018 02:05:32 +0800
Message-ID: <CAPuKSJaVTqrUMjh9g95+NmNq26RJ5h0OHvtq-Ri5aCKowuyw2Q@mail.gmail.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="000000000000ffa3f3057756e2b9"
Subject: Re: [PATCH] restorecond: Do not ignore the -f option
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--000000000000ffa3f3057756e2b9
Content-Type: text/plain; charset="UTF-8"

Ack. (sorry for the HTML email)

On Wed, 3 Oct 2018, 23:52 Ondrej Mosnacek, <omosnace@redhat.com> wrote:

> Since the default value of watch_file is set unconditionally *after* the
> command-line arguments have been parsed, the -f option is (and has
> always been) effectively ignored. Fix this by setting it before the
> parsing.
>
> Fixes: 48681bb49c03 ("policycoreutils: restorecond: make restorecond
> dbuss-able")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  restorecond/restorecond.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c
> index e1d26cb9..7b984b29 100644
> --- a/restorecond/restorecond.c
> +++ b/restorecond/restorecond.c
> @@ -148,6 +148,8 @@ int main(int argc, char **argv)
>         if (is_selinux_enabled() != 1)
>                 return 0;
>
> +       watch_file = server_watch_file;
> +
>         /* Set all options to zero/NULL except for ignore_noent & digest.
> */
>         memset(&r_opts, 0, sizeof(r_opts));
>         r_opts.ignore_noent = SELINUX_RESTORECON_IGNORE_NOENTRY;
> @@ -205,7 +207,6 @@ int main(int argc, char **argv)
>                 return 0;
>         }
>
> -       watch_file = server_watch_file;
>         read_config(master_fd, watch_file);
>
>         if (!debug_mode) {
> --
> 2.17.1
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--000000000000ffa3f3057756e2b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Ack. (sorry for the HTML email)</div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr">On Wed, 3 Oct 2018, 23:52 Ondrej Mosnacek, &lt;=
<a href=3D"mailto:omosnace@redhat.com">omosnace@redhat.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">Since the default value of watch_fil=
e is set unconditionally *after* the<br>
command-line arguments have been parsed, the -f option is (and has<br>
always been) effectively ignored. Fix this by setting it before the<br>
parsing.<br>
<br>
Fixes: 48681bb49c03 (&quot;policycoreutils: restorecond: make restorecond d=
buss-able&quot;)<br>
Signed-off-by: Ondrej Mosnacek &lt;<a href=3D"mailto:omosnace@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">omosnace@redhat.com</a>&gt;<br>
---<br>
=C2=A0restorecond/restorecond.c | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c<br>
index e1d26cb9..7b984b29 100644<br>
--- a/restorecond/restorecond.c<br>
+++ b/restorecond/restorecond.c<br>
@@ -148,6 +148,8 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_selinux_enabled() !=3D 1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0watch_file =3D server_watch_file;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set all options to zero/NULL except for igno=
re_noent &amp; digest. */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&amp;r_opts, 0, sizeof(r_opts));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 r_opts.ignore_noent =3D SELINUX_RESTORECON_IGNO=
RE_NOENTRY;<br>
@@ -205,7 +207,6 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0watch_file =3D server_watch_file;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 read_config(master_fd, watch_file);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!debug_mode) {<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank" rel=3D"noreferre=
r">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" target=3D"_blank" rel=3D"noreferrer">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" target=3D"_blank" rel=3D"noreferrer">Selinu=
x-request@tycho.nsa.gov</a>.<br>
</blockquote></div>

--000000000000ffa3f3057756e2b9--
