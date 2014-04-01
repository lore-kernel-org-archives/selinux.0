Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s31Cg7G4004028
 for <selinux@tycho.nsa.gov>; Tue, 1 Apr 2014 08:42:07 -0400
Message-ID: <533AB41A.7000403@redhat.com>
Date: Tue, 01 Apr 2014 08:42:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: =?EUC-KR?B?v8C067y6?= <ds.oh@lge.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Plz ask for help :)
References: <002301cf4cc0$4138b160$c3aa1420$@oh@lge.com>	<533967A3.70201@redhat.com>
 <002901cf4d4b$dfb10500$9f130f00$@oh@lge.com>
In-Reply-To: <002901cf4d4b$dfb10500$9f130f00$@oh@lge.com>
Content-Type: multipart/alternative;
 boundary="------------000700030601020004010500"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------000700030601020004010500
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx1.redhat.com id s31Cg4t7020291

You need to subscribe to the SELinux upstream list
<selinux@tycho.nsa.gov> for kernel questions.

http://www.nsa.gov/research/selinux/subscribe.shtml

On 03/31/2014 09:44 PM, =BF=C0=B4=EB=BC=BA wrote:
>
> Hi all,
>
> My name is Daesung and i am Korean.
>
> I am studying selinux and i have difficulty doing it.
>
> So i send email to you.
>
> Now, i am trying selinux porting on embedded Linux.
>
> Kernel version is 3.10.19-32.
>
> and configuration about selinux is as in the following:
>
> CONFIG_AUDIT=3Dy
>
> CONFIG_AUDIT_GENERIC=3Dy
>
> CONFIG_NETWORK_SECMARK=3Dy
>
> CONFIG_EXT2_FS_SECURITY=3Dy
>
> CONFIG_EXT3_FS_SECURITY=3Dy
>
> CONFIG_EXT4_FS_SECURITY=3Dy
>
> CONFIG_JFS_SECURITY=3Dy
>
> CONFIG_REISERFS_FS_SECURITY=3Dy
>
> CONFIG_JFFS2_FS_SECURITY=3Dy
>
> CONFIG_SECURITY=3Dy
>
> CONFIG_SECURITY_NETWORK=3Dy
>
> CONFIG_SECURITY_SELINUX=3Dy
>
> CONFIG_SECURITY_NETWORK_XFRM=3Dy
>
> CONFIG_NETLABEL=3Dy
>
> CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
>
> CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=3D1
>
> CONFIG_SECURITY_SELINUX_DISABLE=3Dy
>
> CONFIG_SECURITY_SELINUX_DEVELOP=3Dy
>
> CONFIG_SECURITY_SELINUX_AVC_STATS=3Dy
>
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=3D1
>
> CONFIG_SECURITY_SELINUX_ENABLE_SECMARK_DEFAULT=3Dy
>
> CONFIG_SECURITY_FILE_CAPABILITIES=3Dy
>
> CONFIG_DEFAULT_SECURITY_SELINUX=3Dy
>
> CONFIG_DEFAULT_SECURITY=3D"selinux"
>
> CONFIG_EXT2_FS_XATTR=3Dy
>
> CONFIG_EXT3_FS_XATTR=3Dy
>
> CONFIG_EXT4_FS_XATTR=3Dy
>
> CONFIG_REISERFS_FS_XATTR=3Dy
>
> But, selinux_complete_init function of security/selinux/hook.c is not
> called.
>
> And if i run =A1=B0ls -Z=A1=B0 command, security context is not printed.
>
> $ ls -Z
>
> ? apparmor ? capability.c
>
> selinux_init function is called. but selinux_complete_init function is
> not called and security context is not printed.
>
> *what should i try ? please help me.*
>
> Best Regards.
>
> Daesung.
>


--------------000700030601020004010500
Content-Type: text/html; charset=EUC-KR
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx1.redhat.com id s31Cg4t7020291

<html>
  <head>
    <meta content=3D"text/html; charset=3DEUC-KR" http-equiv=3D"Content-T=
ype">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    You need to subscribe to the SELinux upstream list
    <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:selinux@tycho.nsa.g=
ov">&lt;selinux@tycho.nsa.gov&gt;</a> for kernel questions.<br>
    <br>
    <a class=3D"moz-txt-link-freetext" href=3D"http://www.nsa.gov/researc=
h/selinux/subscribe.shtml">http://www.nsa.gov/research/selinux/subscribe.=
shtml</a><br>
    <br>
    <div class=3D"moz-cite-prefix">On 03/31/2014 09:44 PM, =BF=C0=B4=EB=BC=
=BA wrote:<br>
    </div>
    <blockquote cite=3D"mid:002901cf4d4b$dfb10500$9f130f00$@oh@lge.com"
      type=3D"cite">
      <meta http-equiv=3D"Content-Type" content=3D"text/html;
        charset=3DEUC-KR">
      <meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:=B1=BC=B8=B2;
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:"=B8=BC=C0=BA =B0=ED=B5=F1";
	panose-1:2 11 5 3 2 0 0 2 0 4;}
@font-face
	{font-family:"\@=B1=BC=B8=B2";
	panose-1:2 11 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"\@=B8=BC=C0=BA =B0=ED=B5=F1";
	panose-1:2 11 5 3 2 0 0 2 0 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-autospace:none;
	word-break:break-hangul;
	font-size:10.0pt;
	font-family:"=B8=BC=C0=BA =B0=ED=B5=F1";
	color:black;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"=B8=BC=C0=BA =B0=ED=B5=F1";
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"=B8=BC=C0=BA =B0=ED=B5=F1";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:3.0cm 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
      <div class=3D"WordSection1">
        <p class=3D"MsoNormal"><span lang=3D"EN-US">Hi all,<o:p></o:p></s=
pan></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">My name is Daesung an=
d i
            am Korean.<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">I am studying selinux
            and i have difficulty doing it.<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">So i send email to yo=
u.<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></sp=
an></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">Now, i am trying seli=
nux
            porting on embedded Linux.<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">Kernel version is
            3.10.19-32.<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">and configuration abo=
ut
            selinux is as in the following:<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></sp=
an></p>
        <table class=3D"MsoTableGrid"
          style=3D"border-collapse:collapse;border:none" border=3D"1"
          cellpadding=3D"0" cellspacing=3D"0">
          <tbody>
            <tr>
              <td style=3D"width:477.9pt;border:solid windowtext
                1.0pt;padding:0cm 5.4pt 0cm 5.4pt" valign=3D"top"
                width=3D"637">
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_AUDIT=3D=
y<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_AUDIT_=
GENERIC=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_NETWOR=
K_SECMARK=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_EXT2_F=
S_SECURITY=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_EXT3_F=
S_SECURITY=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_EXT4_F=
S_SECURITY=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_JFS_SE=
CURITY=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_REISER=
FS_FS_SECURITY=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_JFFS2_=
FS_SECURITY=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_SECURI=
TY=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_SECURI=
TY_NETWORK=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_SECURI=
TY_SELINUX=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_SECURI=
TY_NETWORK_XFRM=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_NETLAB=
EL=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_SECURI=
TY_SELINUX_BOOTPARAM=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_SECURI=
TY_SELINUX_BOOTPARAM_VALUE=3D1<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_SECURI=
TY_SELINUX_DISABLE=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_SECURI=
TY_SELINUX_DEVELOP=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_SECURI=
TY_SELINUX_AVC_STATS=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_SECURI=
TY_SELINUX_CHECKREQPROT_VALUE=3D1<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_SECURI=
TY_SELINUX_ENABLE_SECMARK_DEFAULT=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_SECURI=
TY_FILE_CAPABILITIES=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_DEFAUL=
T_SECURITY_SELINUX=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_DEFAUL=
T_SECURITY=3D"selinux"<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_EXT2_F=
S_XATTR=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_EXT3_F=
S_XATTR=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_EXT4_F=
S_XATTR=3Dy<o:p></o:p></span></p>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">CONFIG_REISER=
FS_FS_XATTR=3Dy<o:p></o:p></span></p>
              </td>
            </tr>
          </tbody>
        </table>
        <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></sp=
an></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">But,
            selinux_complete_init function of security/selinux/hook.c is
            not called.<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">And if i run =A1=B0ls=
 -Z=A1=B0
            command, security context is not printed.<o:p></o:p></span></=
p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">$ ls -Z<o:p></o:p></s=
pan></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">? apparmor&nbsp;&nbsp=
;&nbsp; ?
            capability.c<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></sp=
an></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">selinux_init function=
 is
            called. but selinux_complete_init function is not called and
            security context is not printed.<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></sp=
an></p>
        <p class=3D"MsoNormal"><b><span lang=3D"EN-US">what should i try =
?
              please help me.<o:p></o:p></span></b></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></sp=
an></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">Best Regards.<o:p></o=
:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">Daesung.</span><span
            style=3D"color:windowtext" lang=3D"EN-US"><o:p></o:p></span><=
/p>
        <p class=3D"MsoNormal"><span style=3D"color:#1F497D" lang=3D"EN-U=
S"><o:p>&nbsp;</o:p></span></p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------000700030601020004010500--
