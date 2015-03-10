Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2AGr9P0019454
 for <selinux@tycho.nsa.gov>; Tue, 10 Mar 2015 12:53:09 -0400
Received: by oigh136 with SMTP id h136so2749853oig.1
 for <selinux@tycho.nsa.gov>; Tue, 10 Mar 2015 09:53:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1426005851-5474-1-git-send-email-sds@tycho.nsa.gov>
References: <1426005851-5474-1-git-send-email-sds@tycho.nsa.gov>
Date: Tue, 10 Mar 2015 09:53:06 -0700
Message-ID: <CABXk95AZkVykATRTJJVgy1oywvSz2PKJBvD6SZx4VyZRPQ+wng@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Fix precedence between number and filesystem
 tokens.
From: Jeffrey Vander Stoep <jeffv@google.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11c30d1421129a0510f1fc52
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c30d1421129a0510f1fc52
Content-Type: text/plain; charset=UTF-8

Acked-By: Jeff Vander Stoep <jeffv@google.com>

On Tue, Mar 10, 2015 at 9:44 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> When the FILESYSTEM token was added to support filesystem names that
> start with a digit (e.g. 9p), it was given higher precedence than
> NUMBER and therefore all values specified in hex (with 0x prefix)
> in policy will incorrectly match FILESYSTEM and yield a syntax error.
> This breaks use of iomem ranges in Xen policy and will break ioctl
> command ranges in a future SELinux policy version.  Switch the
> precedence.  This does mean that you cannot currently have a filesystem
> with a name that happens to be 0x followed by a hexval but hopefully
> that isn't an issue.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  checkpolicy/policy_scan.l | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> index 3a73962..648e1d6 100644
> --- a/checkpolicy/policy_scan.l
> +++ b/checkpolicy/policy_scan.l
> @@ -242,8 +242,8 @@ LOW                         { return(LOW); }
>  "/"({alnum}|[_\.\-/])*         { return(PATH); }
>  \"({alnum}|[_\.\-\+\~\: ])+\"  { return(FILENAME); }
>  {letter}({alnum}|[_\-])*([\.]?({alnum}|[_\-]))*        {
> return(IDENTIFIER); }
> -{alnum}*{letter}{alnum}*        { return(FILESYSTEM); }
>  {digit}+|0x{hexval}+            { return(NUMBER); }
> +{alnum}*{letter}{alnum}*        { return(FILESYSTEM); }
>  {digit}{1,3}(\.{digit}{1,3}){3}    { return(IPV4_ADDR); }
>  {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
>  {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
> --
> 1.9.3
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>

--001a11c30d1421129a0510f1fc52
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Acked-By: Jeff Vander Stoep &lt;<a href=3D"mailto:jeffv@go=
ogle.com">jeffv@google.com</a>&gt;<br></div><div class=3D"gmail_extra"><br>=
<div class=3D"gmail_quote">On Tue, Mar 10, 2015 at 9:44 AM, Stephen Smalley=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blan=
k">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">When the FILESYSTEM token was added to support filesystem names that<br>
start with a digit (e.g. 9p), it was given higher precedence than<br>
NUMBER and therefore all values specified in hex (with 0x prefix)<br>
in policy will incorrectly match FILESYSTEM and yield a syntax error.<br>
This breaks use of iomem ranges in Xen policy and will break ioctl<br>
command ranges in a future SELinux policy version.=C2=A0 Switch the<br>
precedence.=C2=A0 This does mean that you cannot currently have a filesyste=
m<br>
with a name that happens to be 0x followed by a hexval but hopefully<br>
that isn&#39;t an issue.<br>
<br>
Signed-off-by: Stephen Smalley &lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds=
@tycho.nsa.gov</a>&gt;<br>
---<br>
=C2=A0checkpolicy/policy_scan.l | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l<br>
index 3a73962..648e1d6 100644<br>
--- a/checkpolicy/policy_scan.l<br>
+++ b/checkpolicy/policy_scan.l<br>
@@ -242,8 +242,8 @@ LOW=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ return(LOW); }<br>
=C2=A0&quot;/&quot;({alnum}|[_\.\-/])*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ r=
eturn(PATH); }<br>
=C2=A0\&quot;({alnum}|[_\.\-\+\~\: ])+\&quot;=C2=A0 { return(FILENAME); }<b=
r>
=C2=A0{letter}({alnum}|[_\-])*([\.]?({alnum}|[_\-]))*=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 { return(IDENTIFIER); }<br>
-{alnum}*{letter}{alnum}*=C2=A0 =C2=A0 =C2=A0 =C2=A0 { return(FILESYSTEM); =
}<br>
=C2=A0{digit}+|0x{hexval}+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { retur=
n(NUMBER); }<br>
+{alnum}*{letter}{alnum}*=C2=A0 =C2=A0 =C2=A0 =C2=A0 { return(FILESYSTEM); =
}<br>
=C2=A0{digit}{1,3}(\.{digit}{1,3}){3}=C2=A0 =C2=A0 { return(IPV4_ADDR); }<b=
r>
=C2=A0{hexval}{0,4}&quot;:&quot;{hexval}{0,4}&quot;:&quot;({hexval}|[:.])*=
=C2=A0 { return(IPV6_ADDR); }<br>
=C2=A0{digit}+(\.({alnum}|[_.])*)?=C2=A0 =C2=A0 { return(VERSION_IDENTIFIER=
); }<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.9.3<br>
<br>
_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</font></span></blockquote></div><br></div>

--001a11c30d1421129a0510f1fc52--
