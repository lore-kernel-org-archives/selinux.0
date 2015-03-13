Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2DKnWOP012438
 for <selinux@tycho.nsa.gov>; Fri, 13 Mar 2015 16:49:32 -0400
Message-ID: <55034D57.7040608@redhat.com>
Date: Fri, 13 Mar 2015 16:49:27 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_Boundary-8852-1426279767-0001-2"
To: Andrew Holway <andrew.holway@native-instruments.de>, selinux@tycho.nsa.gov
Subject: Re: Saltstack and ipa-install on Centos7 failing
References: <55031D59.2040909@native-instruments.de>
In-Reply-To: <55031D59.2040909@native-instruments.de>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Boundary-8852-1426279767-0001-2
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

What label is on the script?  unconfined_t is a user type init_t is an
executable being run from init.
On 03/13/2015 01:24 PM, Andrew Holway wrote:
> Hallo,
>
> Could someone please lend a hand with this issue?
>
> https://www.redhat.com/archives/freeipa-users/2015-March/msg00345.html
>
> When I run ipa-server-install from Saltstack it is breaking. I imagine
> this is because the script is being run in an unexpected domain
> (init_t rather than unconfined_t).
>
> Thanks,
>
> Andrew
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.
>
>



--=_Boundary-8852-1426279767-0001-2
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
X-Mime-Autoconverted: from 8bit to quoted-printable by mime827

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    What label is on the script?=A0 unconfined_t is a user type init_t i=
s
    an executable being run from init.<br>
    On 03/13/2015 01:24 PM, Andrew Holway wrote:<br>
    <blockquote type=3D"cite">Hallo,<br>
      <br>
      Could someone please lend a hand with this issue?<br>
      <br>
<a class=3D"moz-txt-link-freetext" href=3D"https://www.redhat.com/archiv=
es/freeipa-users/2015-March/msg00345.html">https://www.redhat.com/archiv=
es/freeipa-users/2015-March/msg00345.html</a><br>
      <br>
      When I run ipa-server-install from Saltstack it is breaking. I
      imagine<br>
      this is because the script is being run in an unexpected domain<br=
>
      (init_t rather than unconfined_t).<br>
      <br>
      Thanks,<br>
      <br>
      Andrew<br>
    </blockquote>
    <span style=3D"white-space: pre;">&gt;
      _______________________________________________<br>
      &gt; Selinux mailing list<br>
      &gt; <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Selinux@=
tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
      &gt; To unsubscribe, send email to <a class=3D"moz-txt-link-abbrev=
iated" href=3D"mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.n=
sa.gov</a>.<br>
      &gt; To get help, send an email containing "help" to
      <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Selinux-reque=
st@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
      &gt;<br>
      &gt;</span><br>
    <br>
    <br>
  </body>
</html>

--=_Boundary-8852-1426279767-0001-2--
