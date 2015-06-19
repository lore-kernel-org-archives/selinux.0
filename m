Message-ID: <55847E54.1010802@redhat.com>
Date: Fri, 19 Jun 2015 16:40:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_Boundary-9904-1434746685-0001-2"
To: Andrew Holway <andrew.holway@otternetworks.de>,
 James Carter <jwcart2@tycho.nsa.gov>
Subject: Re: NFS
References: <CAEcA1_vvB2vUzPEssY=8v3emMfDhfksxYVS_B_rDk=HXoZapoA@mail.gmail.com>
 <55846D8E.5010904@tycho.nsa.gov>
 <CAEcA1_s34A+K3AtLkHAqjQF-hbt8t8TRDbrephf=f8S3Qx_5yg@mail.gmail.com>
In-Reply-To: <CAEcA1_s34A+K3AtLkHAqjQF-hbt8t8TRDbrephf=f8S3Qx_5yg@mail.gmail.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Boundary-9904-1434746685-0001-2
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
X-Mime-Autoconverted: from 8bit to quoted-printable by mime827



On 06/19/2015 04:19 PM, Andrew Holway wrote:
>
>
>     The v3 work was experimental and there was no real way to upstream
>     it in a compatible way.
>
>     Dave Quigley worked with the IETF on SELinux labeled NFS support
>     for NFS 4.2 and it has been available since Fedora 20. This allows
>     each file to have their own SELinux label on the server, but
>     enforcement is only handled by the client.
>
>  
> Does it work? :)
>
Yes as long as your client and server support the protocol.  Currently I
know Fedora and RHEL7 do.
>  
>
>
>     -- 
>     James Carter <jwcart2@tycho.nsa.gov>
>     National Security Agency
>     _______________________________________________
>     Selinux mailing list
>     Selinux@tycho.nsa.gov
>     To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>     To get help, send an email containing "help" to
>     Selinux-request@tycho.nsa.gov.
>
>
>
> -- 
> Otter Networks UG
> http://otternetworks.de
> fon: +49 30 54 88 5197
> Gotenstra=DFe 17
> 10829 Berlin
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.=
nsa.gov.


--=_Boundary-9904-1434746685-0001-2
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
    <br>
    <div class=3D"moz-cite-prefix">On 06/19/2015 04:19 PM, Andrew Holway
      wrote:<br>
    </div>
    <blockquote
cite=3D"mid:CAEcA1_s34A+K3AtLkHAqjQF-hbt8t8TRDbrephf=3Df8S3Qx_5yg@mail.g=
mail.com"
      type=3D"cite">
      <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
        .8ex;border-left:1px #ccc solid;padding-left:1ex">
        <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
        </blockquote>
        The v3 work was experimental and there was no real way to
        upstream it in a compatible way.<br>
        <br>
        Dave Quigley worked with the IETF on SELinux labeled NFS support
        for NFS 4.2 and it has been available since Fedora 20. This
        allows each file to have their own SELinux label on the server,
        but enforcement is only handled by the client.<br>
        <br>
      </blockquote>
      <div>=A0</div>
      <div>Does it work? :)</div>
      <div><br>
      </div>
    </blockquote>
    Yes as long as your client and server support the protocol.=A0
    Currently I know Fedora and RHEL7 do.<br>
    <blockquote
cite=3D"mid:CAEcA1_s34A+K3AtLkHAqjQF-hbt8t8TRDbrephf=3Df8S3Qx_5yg@mail.g=
mail.com"
      type=3D"cite">
      <div>=A0</div>
      <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
        .8ex;border-left:1px #ccc solid;padding-left:1ex">
        <br>
        -- <br>
        James Carter &lt;<a moz-do-not-send=3D"true">jwcart2@tycho.nsa.g=
ov</a>&gt;<br>
        National Security Agency<br>
        _______________________________________________<br>
        Selinux mailing list<br>
        <a moz-do-not-send=3D"true">Selinux@tycho.nsa.gov</a><br>
        To unsubscribe, send email to <a moz-do-not-send=3D"true">Selinu=
x-leave@tycho.nsa.gov</a>.<br>
        To get help, send an email containing "help" to <a
          moz-do-not-send=3D"true">Selinux-request@tycho.nsa.gov</a>.<br=
>
      </blockquote>
      <br>
      <br>
      -- <br>
      <div dir=3D"ltr">Otter Networks UG<br>
        <a moz-do-not-send=3D"true" href=3D"http://otternetworks.de"
          target=3D"_blank">http://otternetworks.de</a><br>
        fon: +49 30 54 88 5197<br>
        Gotenstra=DFe 17<br>
        10829 Berlin</div>
      <br>
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

--=_Boundary-9904-1434746685-0001-2--
