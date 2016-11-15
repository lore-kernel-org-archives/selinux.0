MIME-Version: 1.0
In-Reply-To: <1479248467-24209-1-git-send-email-sds@tycho.nsa.gov>
References: <1479248467-24209-1-git-send-email-sds@tycho.nsa.gov>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Tue, 15 Nov 2016 23:37:27 +0100
Message-ID: <CAJfZ7=moGMZ7za5Y8e+cbdzmnvdJYkApTAG1Kh_hcC37OBLN=w@mail.gmail.com>
Subject: Re: [PATCH] libsepol: cil_lexer: make warnings non-fatal for building
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a113a2e04f6da1105415e99a5
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113a2e04f6da1105415e99a5
Content-Type: text/plain; charset=UTF-8

On Tue, Nov 15, 2016 at 11:21 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> The flex skeleton often triggers compiler warnings; make these
> non-fatal for building.  We already do likewise for checkpolicy.
>

For information, I am using flex 2.6.1 on my system and the generated code
triggers -Wsign-compare warnings. I looked at the flex git repository and
found some patches which fix these warnings in 2.6.2 (
https://github.com/westes/flex/commits/1da19feba7c957e0f0af0c3eeadc29e8c82b0ca3).
When I backported these patches to flex 2.6.1, the generated code no longer
triggered any compiler warning.

Anyway your patch looks good to me.

Nicolas

--001a113a2e04f6da1105415e99a5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
ue, Nov 15, 2016 at 11:21 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=
=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The flex =
skeleton often triggers compiler warnings; make these<br>
non-fatal for building.=C2=A0 We already do likewise for checkpolicy.<span =
class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
</font></span></blockquote></div><br></div><div class=3D"gmail_extra">For i=
nformation, I am using flex 2.6.1 on my system and the generated code trigg=
ers -Wsign-compare warnings. I looked at the flex git repository and found =
some patches which fix these warnings in 2.6.2 (<a href=3D"https://github.c=
om/westes/flex/commits/1da19feba7c957e0f0af0c3eeadc29e8c82b0ca3">https://gi=
thub.com/westes/flex/commits/1da19feba7c957e0f0af0c3eeadc29e8c82b0ca3</a>).=
 When I backported these patches to flex 2.6.1, the generated code no longe=
r triggered any compiler warning.<br></div><div class=3D"gmail_extra"><br><=
/div><div class=3D"gmail_extra">Anyway your patch looks good to me.</div><d=
iv class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Nicolas</div>=
</div>

--001a113a2e04f6da1105415e99a5--
