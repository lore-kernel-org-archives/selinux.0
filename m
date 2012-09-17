MIME-Version: 1.0
In-Reply-To: <CAFftDdrSzB2Os0YbOZyHWSCoy64SGaaV9-jCTFLw5Ozn3KGSsw@mail.gmail.com>
References: <CAFftDdrSzB2Os0YbOZyHWSCoy64SGaaV9-jCTFLw5Ozn3KGSsw@mail.gmail.com>
Date: Mon, 17 Sep 2012 19:22:38 -0400
Message-ID: <CADQgGG1735_t8q=mA4hhGDPjkziviHE64hAJf2r0pMgjeiji=Q@mail.gmail.com>
Subject: Re: signature clause in mac_permisions
From: Robert Craig <robertpcraig@gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=20cf30207fc4a0a65304c9ee0c16
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf30207fc4a0a65304c9ee0c16
Content-Type: text/plain; charset=ISO-8859-1

Just run the setool host tool. To build just 'make setool' and then to run
just 'setool'. The help usage statement will guide you.

On Mon, Sep 17, 2012 at 2:34 PM, William Roberts
<bill.c.roberts@gmail.com>wrote:

> How did you guys generate the hex encoded x509 string for a
> signature clause in mac_permissions.xml?
>
> Did you use the Android "dumpkey.jar"?
>
> I have the signed apk's, the keystore used to sign them, .pem files which
> have all the pub keys in them and a p12 and p8 file.
>
> Which one should I use?
>
> --
> Respectfully,
>
> William C Roberts
>
>
>

--20cf30207fc4a0a65304c9ee0c16
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Just run the setool host tool. To build just &#39;make setool&#39; and then=
 to run just &#39;setool&#39;. The help usage statement will guide you.<br>=
<br><div class=3D"gmail_quote">On Mon, Sep 17, 2012 at 2:34 PM, William Rob=
erts <span dir=3D"ltr">&lt;<a href=3D"mailto:bill.c.roberts@gmail.com" targ=
et=3D"_blank">bill.c.roberts@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">How did you guys=A0generate=A0the hex encode=
d x509 string for a signature=A0clause in mac_permissions.xml?<br clear=3D"=
all"><div>
<br></div><div>Did you use the Android &quot;dumpkey.jar&quot;?</div><div><=
br></div><div>I have the signed apk&#39;s, the keystore used to sign them, =
.pem files which have all the pub keys in them and a p12 and p8 file.</div>

<div><br></div><div>Which one should I use?</div><span class=3D"HOEnZb"><fo=
nt color=3D"#888888"><div><br></div>-- <br>Respectfully,<br><br>William C R=
oberts<br><br><br>
</font></span></blockquote></div><br>

--20cf30207fc4a0a65304c9ee0c16--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
