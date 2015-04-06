Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t36ItaQR025542
 for <selinux@tycho.nsa.gov>; Mon, 6 Apr 2015 14:55:36 -0400
Message-ID: <5522D6A2.7090804@redhat.com>
Date: Mon, 06 Apr 2015 14:55:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_Boundary-2884-1428346503-0001-2"
To: Aleksey Chudov <aleksey.chudov@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Reset SELinux booleans
References: <CA+g23Tsk7Lfh0eQ+FfayCT-pox7Y5FC9n_GNpTVvE83DttRbYw@mail.gmail.com>
In-Reply-To: <CA+g23Tsk7Lfh0eQ+FfayCT-pox7Y5FC9n_GNpTVvE83DttRbYw@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Boundary-2884-1428346503-0001-2
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit


semanage booleans -D

Should do what you want

On 03/23/2015 06:55 AM, Aleksey Chudov wrote:
> Hi,
>
> After some experiments I'm trying to reset booleans to the boot-time
> defaults. Just deleting
> /etc/selinux/targeted/modules/active/booleans.local and executing
> semodule -B does not help.
>
> According to man booleans(8) the load_policy program can reset
> booleans to the boot-time defaults via the -b option. But executing
> load_policy -b produces the following warning on CentOS 7:
>
> # load_policy -b
> load_policy:  Warning! The -b option is no longer supported, booleans
> are always preserved across reloads.  Continuing...
>
> Currently I'm setting up servers including SELinux policy using
> configuration management system. File
> /etc/selinux/targeted/modules/active/booleans.local is managed
> automatically. But if someone manually executes setsebool to set some
> boolean this boolean becomes unmanageable till the next reboot and
> itcould be a very long time in the case of a production server.
>
> Is there some way to reset booleans to the boot-time defaults?
>
>
> Regards,
> Aleksey
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


--=_Boundary-2884-1428346503-0001-2
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
X-Mime-Autoconverted: from 8bit to quoted-printable by mime827

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <br>
    semanage booleans -D<br>
    <br>
    Should do what you want<br>
    <br>
    <div class=3D"moz-cite-prefix">On 03/23/2015 06:55 AM, Aleksey Chudo=
v
      wrote:<br>
    </div>
    <blockquote
cite=3D"mid:CA+g23Tsk7Lfh0eQ+FfayCT-pox7Y5FC9n_GNpTVvE83DttRbYw@mail.gma=
il.com"
      type=3D"cite">
      <div dir=3D"ltr">Hi,<br>
        <br>
        After some experiments I'm trying to reset booleans to the
        boot-time defaults. Just deleting
        /etc/selinux/targeted/modules/active/booleans.local and
        executing semodule -B does not help.<br>
        <br>
        According to man booleans(8) the load_policy program can reset
        booleans to the boot-time defaults via the -b option. But
        executing load_policy -b produces the following warning on
        CentOS 7:<br>
        <br>
        # load_policy -b<br>
        load_policy:=A0 Warning! The -b option is no longer supported,
        booleans are always preserved across reloads.=A0 Continuing...<b=
r>
        <span lang=3D"en"><span><br>
          </span></span>Currently I'm setting up servers including
        SELinux policy using configuration management system. File
        /etc/selinux/targeted/modules/active/booleans.local is managed
        automatically. But if someone manually executes setsebool to set
        some boolean this boolean becomes unmanageable till the next
        reboot and it<span lang=3D"en"><span> could be</span> <span>a
            very long time</span> <span>in the case of</span> <span>a
            production server</span></span>.<br>
        <div><br>
          <span lang=3D"en"><span>Is there</span> <span>some</span> <spa=
n>way
              to </span></span>reset booleans to the boot-time
          defaults?<br>
          <br>
        </div>
        <div><br>
        </div>
        Regards,<br>
        Aleksey<br>
      </div>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">_______________________________________________
Selinux mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Selinux@tycho.nsa.g=
ov">Selinux@tycho.nsa.gov</a>
To unsubscribe, send email to <a class=3D"moz-txt-link-abbreviated" href=
=3D"mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.
To get help, send an email containing "help" to <a class=3D"moz-txt-link=
-abbreviated" href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-requ=
est@tycho.nsa.gov</a>.</pre>
    </blockquote>
    <br>
  </body>
</html>

--=_Boundary-2884-1428346503-0001-2--
