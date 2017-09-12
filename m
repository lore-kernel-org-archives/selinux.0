Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8CH1UG9025638
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 13:01:34 -0400
Received: by mail-it0-f67.google.com with SMTP id e134so3131001ite.3
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 09:04:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170911104141.2629-1-cgzones@googlemail.com>
References: <20170911104141.2629-1-cgzones@googlemail.com>
From: Stephen Smalley <stephen.smalley@gmail.com>
Date: Tue, 12 Sep 2017 12:04:21 -0400
Message-ID: <CAB9W1A1s20MMUyA5cgJteNA+r4V1Wo1VvWvaDj5M-ZSyR=o-8Q@mail.gmail.com>
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="94eb2c07e8404cc07005590032c2"
Subject: Re: [PATCH] libselinux: log no default label warning in verbose mode
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c07e8404cc07005590032c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sep 11, 2017 3:45 AM, "Christian G=C3=B6ttsche via Selinux" <
selinux@tycho.nsa.gov> wrote:

Since 1cd972f restorecon does not print a warning in recurse mode for child
files without a default label.
Change it back in verbose mode:

$ touch /run/test.pid
$ restorecon -R /run
$ restorecon -v -R /run
Warning no default label for /run/test.pid


This seems to revert what was an intentional change to avoid noise in
fixfiles check output. See the mailing list discussions that preceded and
followed the patch.


Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
---
 libselinux/src/selinux_restorecon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_
restorecon.c
index ced41152..6d0eabe0 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -614,7 +614,7 @@ static int restorecon_sb(const char *pathname, const
struct stat *sb,
                                                    sb->st_mode);

        if (rc < 0) {
-               if (errno =3D=3D ENOENT && flags->warnonnomatch)
+               if (errno =3D=3D ENOENT && (flags->verbose ||
flags->warnonnomatch))
                        selinux_log(SELINUX_INFO,
                                    "Warning no default label for %s\n",
                                    lookup_path);
--
2.14.1

--94eb2c07e8404cc07005590032c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_extra"><div class=3D"gmail_quote=
">On Sep 11, 2017 3:45 AM, &quot;Christian G=C3=B6ttsche via Selinux&quot; =
&lt;<a href=3D"mailto:selinux@tycho.nsa.gov">selinux@tycho.nsa.gov</a>&gt; =
wrote:<br type=3D"attribution"><blockquote class=3D"quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Since 1cd972f resto=
recon does not print a warning in recurse mode for child files without a de=
fault label.<br>
Change it back in verbose mode:<br>
<br>
$ touch /run/test.pid<br>
$ restorecon -R /run<br>
$ restorecon -v -R /run<br>
Warning no default label for /run/test.pid<br></blockquote></div></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">This seems to revert what w=
as an intentional change to avoid noise in fixfiles check output. See the m=
ailing list discussions that preceded and followed the patch.=C2=A0</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_extra"><div=
 class=3D"gmail_quote"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Signed-off-by: Christian G=C3=B6ttsche &lt;<a href=3D"mailto:cgzones@google=
mail.com">cgzones@googlemail.com</a>&gt;<br>
---<br>
=C2=A0libselinux/src/selinux_<wbr>restorecon.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/libselinux/src/selinux_<wbr>restorecon.c b/libselinux/src/seli=
nux_<wbr>restorecon.c<br>
index ced41152..6d0eabe0 100644<br>
--- a/libselinux/src/selinux_<wbr>restorecon.c<br>
+++ b/libselinux/src/selinux_<wbr>restorecon.c<br>
@@ -614,7 +614,7 @@ static int restorecon_sb(const char *pathname, const st=
ruct stat *sb,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sb-&gt;st_mode);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (errno =3D=3D EN=
OENT &amp;&amp; flags-&gt;warnonnomatch)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (errno =3D=3D EN=
OENT &amp;&amp; (flags-&gt;verbose || flags-&gt;warnonnomatch))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 selinux_log(SELINUX_INFO,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Warning no defau=
lt label for %s\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lookup_path);<br>
<font color=3D"#888888">--<br>
2.14.1<br>
<br>
<br>
<br>
</font></blockquote></div><br></div></div></div>

--94eb2c07e8404cc07005590032c2--
