Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4LEV1wD011351
	for <selinux@tycho.nsa.gov>; Tue, 21 May 2013 10:31:01 -0400
Received: by mail-qe0-f53.google.com with SMTP id s14so405743qeb.12
        for <selinux@tycho.nsa.gov>; Tue, 21 May 2013 07:31:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369066571-12452-1-git-send-email-bigon@debian.org>
References: <1369066571-12452-1-git-send-email-bigon@debian.org>
Date: Tue, 21 May 2013 16:31:02 +0200
Message-ID: <CAPzO=NxzbaCxmcJNZ8CJBBX=JAe9UOoSb60iuxSFR4TUD=LjnA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Requires libpcre and libpthread for static linking
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Laurent Bigonville <bigon@debian.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=14dae9d70f52782a8e04dd3b4c0d
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--14dae9d70f52782a8e04dd3b4c0d
Content-Type: text/plain; charset=ISO-8859-1

Yes, we have the same in Gentoo.

Ack-by: Sven Vermeulen <sven.vermeulen@siphos.be>
On May 20, 2013 6:31 PM, "Laurent Bigonville" <bigon@debian.org> wrote:

> From: Laurent Bigonville <bigon@bigon.be>
>
> ---
>  libselinux/src/libselinux.pc.in | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/libselinux.pc.in b/libselinux/src/
> libselinux.pc.in
> index 5691559..f453c8f 100644
> --- a/libselinux/src/libselinux.pc.in
> +++ b/libselinux/src/libselinux.pc.in
> @@ -7,6 +7,7 @@ Name: libselinux
>  Description: SELinux utility library
>  Version: @VERSION@
>  URL: http://userspace.selinuxproject.org/
> -Requires.private: libsepol
> +Requires.private: libsepol libpcre
>  Libs: -L${libdir} -lselinux
> +Libs.private: -lpthread
>  Cflags: -I${includedir}
> --
> 1.8.3.rc2
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

--14dae9d70f52782a8e04dd3b4c0d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Yes, we have the same in Gentoo.</p>
<p dir=3D"ltr">Ack-by: Sven Vermeulen &lt;<a href=3D"mailto:sven.vermeulen@=
siphos.be">sven.vermeulen@siphos.be</a>&gt;</p>
<div class=3D"gmail_quote">On May 20, 2013 6:31 PM, &quot;Laurent Bigonvill=
e&quot; &lt;<a href=3D"mailto:bigon@debian.org">bigon@debian.org</a>&gt; wr=
ote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
From: Laurent Bigonville &lt;<a href=3D"mailto:bigon@bigon.be">bigon@bigon.=
be</a>&gt;<br>
<br>
---<br>
=A0libselinux/src/<a href=3D"http://libselinux.pc.in" target=3D"_blank">lib=
selinux.pc.in</a> | 3 ++-<br>
=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/libselinux/src/<a href=3D"http://libselinux.pc.in" target=3D"_=
blank">libselinux.pc.in</a> b/libselinux/src/<a href=3D"http://libselinux.p=
c.in" target=3D"_blank">libselinux.pc.in</a><br>
index 5691559..f453c8f 100644<br>
--- a/libselinux/src/<a href=3D"http://libselinux.pc.in" target=3D"_blank">=
libselinux.pc.in</a><br>
+++ b/libselinux/src/<a href=3D"http://libselinux.pc.in" target=3D"_blank">=
libselinux.pc.in</a><br>
@@ -7,6 +7,7 @@ Name: libselinux<br>
=A0Description: SELinux utility library<br>
=A0Version: @VERSION@<br>
=A0URL: <a href=3D"http://userspace.selinuxproject.org/" target=3D"_blank">=
http://userspace.selinuxproject.org/</a><br>
-Requires.private: libsepol<br>
+Requires.private: libsepol libpcre<br>
=A0Libs: -L${libdir} -lselinux<br>
+Libs.private: -lpthread<br>
=A0Cflags: -I${includedir}<br>
--<br>
1.8.3.rc2<br>
<br>
<br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</blockquote></div>

--14dae9d70f52782a8e04dd3b4c0d--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
