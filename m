Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2GD09Tx012537
 for <selinux@tycho.nsa.gov>; Mon, 16 Mar 2015 09:00:09 -0400
Message-ID: <5506D3D4.90005@redhat.com>
Date: Mon, 16 Mar 2015 14:00:04 +0100
From: Miroslav Grepl <mgrepl@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_Boundary-2884-1426510811-0001-2"
To: Daniel J Walsh <dwalsh@redhat.com>,
 Andrew Holway <andrew.holway@native-instruments.de>, selinux@tycho.nsa.gov
Subject: Re: Saltstack and ipa-install on Centos7 failing
References: <55031D59.2040909@native-instruments.de>
 <55034D57.7040608@redhat.com>
In-Reply-To: <55034D57.7040608@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Boundary-2884-1426510811-0001-2
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 03/13/2015 09:49 PM, Daniel J Walsh wrote:
> What label is on the script?  unconfined_t is a user type init_t is an 
> executable being run from init.
Yes, what is a label for /usr/sbin/ipa-server-install on your system?

You should see it running as init_t on Centos7. We have 
unconfined_service_t on RHEL7.1.


> On 03/13/2015 01:24 PM, Andrew Holway wrote:
>> Hallo,
>>
>> Could someone please lend a hand with this issue?
>>
>> https://www.redhat.com/archives/freeipa-users/2015-March/msg00345.html
>>
>> When I run ipa-server-install from Saltstack it is breaking. I imagine
>> this is because the script is being run in an unexpected domain
>> (init_t rather than unconfined_t).
>>
>> Thanks,
>>
>> Andrew
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to 
> Selinux-request@tycho.nsa.gov.
> >
> >
>
>
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


--=_Boundary-2884-1426510811-0001-2
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
X-Mime-Autoconverted: from 8bit to quoted-printable by mime827

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">On 03/13/2015 09:49 PM, Daniel J Wals=
h
      wrote:<br>
    </div>
    <blockquote cite=3D"mid:55034D57.7040608@redhat.com" type=3D"cite">
      <meta content=3D"text/html; charset=3Dwindows-1252"
        http-equiv=3D"Content-Type">
      What label is on the script?=A0 unconfined_t is a user type init_t
      is an executable being run from init.<br>
    </blockquote>
    Yes, what is a label for <span class=3D"">/usr/sbin/ipa-server-insta=
ll
      on your system?</span><br>
    <br>
    You should see it running as init_t on Centos7. We have
    unconfined_service_t on RHEL7.1.<br>
    <br>
    <br>
    <blockquote cite=3D"mid:55034D57.7040608@redhat.com" type=3D"cite"> =
On
      03/13/2015 01:24 PM, Andrew Holway wrote:<br>
      <blockquote type=3D"cite">Hallo,<br>
        <br>
        Could someone please lend a hand with this issue?<br>
        <br>
        <a moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext"
href=3D"https://www.redhat.com/archives/freeipa-users/2015-March/msg0034=
5.html">https://www.redhat.com/archives/freeipa-users/2015-March/msg0034=
5.html</a><br>
        <br>
        When I run ipa-server-install from Saltstack it is breaking. I
        imagine<br>
        this is because the script is being run in an unexpected domain<=
br>
        (init_t rather than unconfined_t).<br>
        <br>
        Thanks,<br>
        <br>
        Andrew<br>
      </blockquote>
      <span style=3D"white-space: pre;">&gt;
        _______________________________________________<br>
        &gt; Selinux mailing list<br>
        &gt; <a moz-do-not-send=3D"true" class=3D"moz-txt-link-abbreviat=
ed"
          href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a=
><br>
        &gt; To unsubscribe, send email to <a moz-do-not-send=3D"true"
          class=3D"moz-txt-link-abbreviated"
          href=3D"mailto:Selinux-leave@tycho.nsa.gov">Selinux-leave@tych=
o.nsa.gov</a>.<br>
        &gt; To get help, send an email containing "help" to <a
          moz-do-not-send=3D"true" class=3D"moz-txt-link-abbreviated"
          href=3D"mailto:Selinux-request@tycho.nsa.gov">Selinux-request@=
tycho.nsa.gov</a>.<br>
        &gt;<br>
        &gt;</span><br>
      <br>
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

--=_Boundary-2884-1426510811-0001-2--
