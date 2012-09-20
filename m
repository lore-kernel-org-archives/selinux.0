MIME-Version: 1.0
In-Reply-To: <1348149606.13835.21.camel@moss-pluto.epoch.ncsc.mil>
References: <CAKi3PupyLSM2UktjTaS8U-WKmiRSpRdSJApn2vRETfEx83qNfg@mail.gmail.com>
	<1347988424.31966.56.camel@moss-pluto.epoch.ncsc.mil>
	<CAKi3Puqw0r=d31S+8N5_=JDN4_bK3TH2EODogOfAxTFxvDsdpg@mail.gmail.com>
	<1348145727.13835.5.camel@moss-pluto.epoch.ncsc.mil>
	<CAKi3PuokYYQxCwf+SGga7UuguXBR14ZSneFMOfFQ-g0qX5btMA@mail.gmail.com>
	<1348149606.13835.21.camel@moss-pluto.epoch.ncsc.mil>
Date: Thu, 20 Sep 2012 16:10:21 +0200
Message-ID: <CAKi3Puo9rREhxm_CTEYaRJtZJKf2XdK=EO0-jjDE+cQ12g-Zrg@mail.gmail.com>
Subject: Re: seandroid 4.1.1
From: Alexandra Test <testalexandrainstitute@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001636c5b33c11edbc04ca22afa4
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001636c5b33c11edbc04ca22afa4
Content-Type: text/plain; charset=ISO-8859-1

effectively I have a problem with dmesg
is it possible I don't have the package installed?
this is the output....
adb shell su 0 dmsg
Usage: su [options] [LOGIN]

Options:
  -c, --command COMMAND         pass COMMAND to the invoked shell
  -h, --help                    display this help message and exit
  -, -l, --login                make the shell a login shell
  -s, --shell SHELL             use SHELL instead of the default in passwd
  -v, --version                 display version number and exit
  -V                            display version code and exit. this is
                                used almost exclusively by Superuser.apk
root@alexandra:~/new/external/sepolicy# adb shell su 0 dmesg
Usage: su [options] [LOGIN]

Options:
  -c, --command COMMAND         pass COMMAND to the invoked shell
  -h, --help                    display this help message and exit
  ...

what is wrong?


On Thu, Sep 20, 2012 at 4:00 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Thu, 2012-09-20 at 15:57 +0200, Alexandra Test wrote:
> > I don't have any denials.
> > If I change in enforcing mode with the wifi still connected, the wifi
> > works.
> > But if, in the enforcing mode, I disconnect it and try to reconnect
> > it, it doesn't : he says "obtaining IP address", "connecting", "saved"
> > at the end without being connected...
>
> No avc: or SELinux: messages in dmesg output when it fails?
>
> I suppose it could be hidden by a dontaudit rule.  You could try
> stripping those from your policy and see if you get anything.
>
> --
> Stephen Smalley
> National Security Agency
>
>

--001636c5b33c11edbc04ca22afa4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

effectively I have a problem with dmesg<br>is it possible I don&#39;t have =
the package installed? <br>this is the output....<br><div style=3D"margin-l=
eft:80px">adb shell su 0 dmsg<br>Usage: su [options] [LOGIN]<br><br>Options=
:<br>
=A0 -c, --command COMMAND=A0=A0=A0=A0=A0=A0=A0=A0 pass COMMAND to the invok=
ed shell<br>=A0 -h, --help=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 display this help message and exit<br>=A0 -, -l, --login=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 make the shell a login shell<br>=A0 -s=
, --shell SHELL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 use SHELL instead of th=
e default in passwd<br>
=A0 -v, --version=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 display v=
ersion number and exit<br>=A0 -V=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 display version code and exit. this=
 is<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 used almost exclusively by Superuser.apk<br>roo=
t@alexandra:~/new/external/sepolicy# adb shell su 0 dmesg <br>
Usage: su [options] [LOGIN]<br><br>Options:<br>=A0 -c, --command COMMAND=A0=
=A0=A0=A0=A0=A0=A0=A0 pass COMMAND to the invoked shell<br>=A0 -h, --help=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 display this help=
 message and exit<br>=A0 ...<br><br></div>what is wrong?<br>
<div style=3D"margin-left:80px"><br></div><br><div class=3D"gmail_quote">On=
 Thu, Sep 20, 2012 at 4:00 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;<=
/span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Thu, 2012-09-20 at 15:5=
7 +0200, Alexandra Test wrote:<br>
&gt; I don&#39;t have any denials.<br>
&gt; If I change in enforcing mode with the wifi still connected, the wifi<=
br>
&gt; works.<br>
&gt; But if, in the enforcing mode, I disconnect it and try to reconnect<br=
>
&gt; it, it doesn&#39;t : he says &quot;obtaining IP address&quot;, &quot;c=
onnecting&quot;, &quot;saved&quot;<br>
&gt; at the end without being connected...<br>
<br>
</div>No avc: or SELinux: messages in dmesg output when it fails?<br>
<br>
I suppose it could be hidden by a dontaudit rule. =A0You could try<br>
stripping those from your policy and see if you get anything.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</div></div></blockquote></div><br>

--001636c5b33c11edbc04ca22afa4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
