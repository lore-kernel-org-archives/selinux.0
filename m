Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w6BGZa6W021650
 for <selinux@tycho.nsa.gov>; Wed, 11 Jul 2018 12:35:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9B0FA40122BF
 for <selinux@tycho.nsa.gov>; Wed, 11 Jul 2018 16:34:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.18.25.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D1887C52
 for <selinux@tycho.nsa.gov>; Wed, 11 Jul 2018 16:34:55 +0000 (UTC)
Reply-To: dwalsh@redhat.com
To: selinux@tycho.nsa.gov
References: <8DB55F909F852648AD052B95F8C1001E4943C416@APSWP0835.ms.ds.uhc.com>
From: Daniel Walsh <dwalsh@redhat.com>
Message-ID: <dec06212-3bc0-ca2e-5a34-16abf489d933@redhat.com>
Date: Wed, 11 Jul 2018 12:34:55 -0400
MIME-Version: 1.0
In-Reply-To: <8DB55F909F852648AD052B95F8C1001E4943C416@APSWP0835.ms.ds.uhc.com>
Content-Type: multipart/alternative;
 boundary="------------2B1FC3B90A5DDAF250005AF5"
Subject: Re: blocking / mount using containers
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------2B1FC3B90A5DDAF250005AF5
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable

On 07/10/2018 10:00 AM, Mclain, Warren wrote:
>
> I am trying to find a solution for blocking the mounting of / from=20
> containers. This is a major security hole for Docker and all of those=20
> types of applications.
>
> I found the mount_anyfile =A0Boolean but nothing that digs into that to=
=20
> show how to disable specific mountings.
>
> Looking for any information that would help the container community in=20
> general.
>
This seems mighty arbitrary. I would think you would want to block lots=20
of directories from being mounted into the container in addition to /,=20
/home, /var, /etc? for example.

What tool are you using, and what access to you want to grant to your use=
rs?

> thanks
>
> ___________________________________
>
> Warren McLain
>
> Enterprise Engineering Services
>
> IEI Foundation Engineering - Compute, Optum Technology
>
> =A0warren_mclain@optum.com Office: 763-744-3107
>
>
> This e-mail, including attachments, may include confidential and/or
> proprietary information, and may be used only by the person or entity
> to which it is addressed. If the reader of this e-mail is not the inten=
ded
> recipient or his or her authorized agent, the reader is hereby notified
> that any dissemination, distribution or copying of this e-mail is
> prohibited. If you have received this e-mail in error, please notify th=
e
> sender by replying to this message and delete this e-mail immediately.
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.



--------------2B1FC3B90A5DDAF250005AF5
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html;
      charset=3Dwindows-1252">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div class=3D"moz-cite-prefix">On 07/10/2018 10:00 AM, Mclain, Warren
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
cite=3D"mid:8DB55F909F852648AD052B95F8C1001E4943C416@APSWP0835.ms.ds.uhc.=
com">
      <meta http-equiv=3D"Content-Type" content=3D"text/html;
        charset=3Dwindows-1252">
      <meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
      <div class=3D"WordSection1">
        <p class=3D"MsoNormal">I am trying to find a solution for blockin=
g
          the mounting of / from containers. This is a major security
          hole for Docker and all of those types of applications.<o:p></o=
:p></p>
        <p class=3D"MsoNormal"><o:p>=A0</o:p></p>
        <p class=3D"MsoNormal">I found the mount_anyfile =A0Boolean but
          nothing that digs into that to show how to disable specific
          mountings.<o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>=A0</o:p></p>
        <p class=3D"MsoNormal">Looking for any information that would hel=
p
          the container community in general.<o:p></o:p></p>
      </div>
    </blockquote>
    This seems mighty arbitrary. I would think you would want to block
    lots of directories from being mounted into the container in
    addition to /, /home, /var, /etc? for example.<br>
    <br>
    What tool are you using, and what access to you want to grant to
    your users?<br>
    <br>
    <blockquote type=3D"cite"
cite=3D"mid:8DB55F909F852648AD052B95F8C1001E4943C416@APSWP0835.ms.ds.uhc.=
com">
      <div class=3D"WordSection1">
        <p class=3D"MsoNormal"><o:p>=A0</o:p></p>
        <p class=3D"MsoNormal">thanks<o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>=A0</o:p></p>
        <p class=3D"MsoNormal">___________________________________<o:p></=
o:p></p>
        <p class=3D"MsoNormal">Warren McLain<o:p></o:p></p>
        <p class=3D"MsoNormal">Enterprise Engineering Services<o:p></o:p>=
</p>
        <p class=3D"MsoNormal">IEI Foundation Engineering - Compute, Optu=
m
          Technology <o:p>
          </o:p></p>
        <p class=3D"MsoNormal">=A0<a class=3D"moz-txt-link-abbreviated" h=
ref=3D"mailto:warren_mclain@optum.com">warren_mclain@optum.com</a> Office=
:
          763-744-3107<o:p></o:p></p>
        <p class=3D"MsoNormal"><o:p>=A0</o:p></p>
      </div>
      <p><br>
        This e-mail, including attachments, may include confidential
        and/or<br>
        proprietary information, and may be used only by the person or
        entity<br>
        to which it is addressed. If the reader of this e-mail is not
        the intended<br>
        recipient or his or her authorized agent, the reader is hereby
        notified<br>
        that any dissemination, distribution or copying of this e-mail
        is<br>
        prohibited. If you have received this e-mail in error, please
        notify the<br>
        sender by replying to this message and delete this e-mail
        immediately.</p>
      <!--'"--><br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">_______________________________________________
Selinux mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Selinux@tycho.nsa.go=
v">Selinux@tycho.nsa.gov</a>
To unsubscribe, send email to <a class=3D"moz-txt-link-abbreviated" href=3D=
"mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a class=3D"moz-txt-link-=
abbreviated" href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-reques=
t@tycho.nsa.gov</a>.</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------2B1FC3B90A5DDAF250005AF5--
