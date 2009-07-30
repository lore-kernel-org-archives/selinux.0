Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6UDWMr6025570
	for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2009 09:32:22 -0400
Received: from mail-ew0-f211.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n6UDXGgj014519
	for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2009 13:33:17 GMT
Received: by ewy7 with SMTP id 7so282383ewy.18
        for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2009 06:32:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1248956559.11627.105.camel@moss-pluto.epoch.ncsc.mil>
References: <f7d5075c0907290405x4d851cbnaf30980f8fadb308@mail.gmail.com>
	 <CIEOKAFOMGPNJIPMMMAHMELCCBAA.remmolt@zwartsenberg.eu>
	 <f7d5075c0907290626t1c772fd3l9f60c7a710c6152@mail.gmail.com>
	 <f7d5075c0907290704x9b2b426sb6c3bb928a11a98b@mail.gmail.com>
	 <1248882850.11627.64.camel@moss-pluto.epoch.ncsc.mil>
	 <f7d5075c0907292221m3f04a942xd6216033e923cab6@mail.gmail.com>
	 <1248956559.11627.105.camel@moss-pluto.epoch.ncsc.mil>
Date: Thu, 30 Jul 2009 18:02:08 +0430
Message-ID: <f7d5075c0907300632w49548c5an90f4e62aa978bb3e@mail.gmail.com>
Subject: Re: compiling errors!
From: mina elnino <potushka@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary=0016e64c2740948572046fec54da
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016e64c2740948572046fec54da
Content-Type: multipart/alternative; boundary=0016e64c2740948568046fec54d8

--0016e64c2740948568046fec54d8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

to build it:

$ make conf
$ make policy

the second make made an error (in the attached file).
and also it generated policy.conf

On Thu, Jul 30, 2009 at 4:52 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Thu, 2009-07-30 at 09:51 +0430, mina elnino wrote:
> > well, i have to say that i went through the steps in:
> >
> > http://danwalsh.livejournal.com/26428.html
> >
> > and at last i realized that this page is for the ones who want to make
> > policies from the source. now i have packages:
> >
> > $ ls ~/rpmbuild/RPMS/noarch/
> > selinux-policy-3.6.12-62.fc11.noarch.rpm
> > selinux-policy-doc-3.6.12-62.fc11.noarch.rpm
> > selinux-policy-minimum-3.6.12-62.fc11.noarch.rpm
> > selinux-policy-mls-3.6.12-62.fc11.noarch.rpm
> > selinux-policy-targeted-3.6.12-62.fc11.noarch.rpm
> >
> > none of them is the source policy package. i mean i need that old m4
> > macros, "*.te" files and "policy.conf" which could be installed by
> > "selinux-policy-targeted-source" or "selinux-policy-strict-source" in
> > fc4.
>
> If you want to just unpack the source tree along with any
> Fedora-specific patches applied, you can do:
> rpm -i selinux-policy*.src.rpm
> cd ~/rpmbuild/SPECS
> rpmbuild -bp selinux-policy.spec
> cd ../BUILD/serefpolicy*
> Then you can build it in the usual manner.
>
> You can also clone the upstream refpolicy repository if you want:
> git clone http://oss.tresys.com/git/refpolicy.git
> cd refpolicy
>
> Note however that Fedora policy is built modular rather than monolithic,
> so there is no policy.conf file per se.  But if you run make with the
> default build.conf, you'll end up with a policy.conf file.
>
> --
> Stephen Smalley
> National Security Agency
>
>

--0016e64c2740948568046fec54d8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

to build it:<br><br>$ make conf<br>$ make policy<br><br>the second make mad=
e an error (in the attached file).<br>and also it generated policy.conf<br>=
<br><div class=3D"gmail_quote">On Thu, Jul 30, 2009 at 4:52 PM, Stephen Sma=
lley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.n=
sa.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>On Thu, 2009-07-30 at 09:51 +0430, mina elnino wrote:<br>
&gt; well, i have to say that i went through the steps in:<br>
&gt;<br>
&gt; <a href=3D"http://danwalsh.livejournal.com/26428.html" target=3D"_blan=
k">http://danwalsh.livejournal.com/26428.html</a><br>
&gt;<br>
&gt; and at last i realized that this page is for the ones who want to make=
<br>
&gt; policies from the source. now i have packages:<br>
&gt;<br>
&gt; $ ls ~/rpmbuild/RPMS/noarch/<br>
&gt; selinux-policy-3.6.12-62.fc11.noarch.rpm<br>
&gt; selinux-policy-doc-3.6.12-62.fc11.noarch.rpm<br>
&gt; selinux-policy-minimum-3.6.12-62.fc11.noarch.rpm<br>
&gt; selinux-policy-mls-3.6.12-62.fc11.noarch.rpm<br>
&gt; selinux-policy-targeted-3.6.12-62.fc11.noarch.rpm<br>
&gt;<br>
&gt; none of them is the source policy package. i mean i need that old m4<b=
r>
&gt; macros, &quot;*.te&quot; files and &quot;policy.conf&quot; which could=
 be installed by<br>
&gt; &quot;selinux-policy-targeted-source&quot; or &quot;selinux-policy-str=
ict-source&quot; in<br>
&gt; fc4.<br>
<br>
</div>If you want to just unpack the source tree along with any<br>
Fedora-specific patches applied, you can do:<br>
rpm -i selinux-policy*.src.rpm<br>
cd ~/rpmbuild/SPECS<br>
rpmbuild -bp selinux-policy.spec<br>
cd ../BUILD/serefpolicy*<br>
Then you can build it in the usual manner.<br>
<br>
You can also clone the upstream refpolicy repository if you want:<br>
git clone <a href=3D"http://oss.tresys.com/git/refpolicy.git" target=3D"_bl=
ank">http://oss.tresys.com/git/refpolicy.git</a><br>
cd refpolicy<br>
<br>
Note however that Fedora policy is built modular rather than monolithic,<br=
>
so there is no policy.conf file per se. =A0But if you run make with the<br>
default build.conf, you&#39;ll end up with a policy.conf file.<br>
<font color=3D"#888888"><br>
--<br>
</font><div><div></div><div class=3D"h5">Stephen Smalley<br>
National Security Agency<br>
<br>
</div></div></blockquote></div><br>

--0016e64c2740948568046fec54d8--

--0016e64c2740948572046fec54da
Content-Type: application/octet-stream; name=result
Content-Disposition: attachment; filename=result
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fxriwkr40

bTQ6cG9saWN5L21vZHVsZXMvc2VydmljZXMvcmF6b3IudGU6OTogV2FybmluZzogZXhjZXNzIGFy
Z3VtZW50cyB0byBidWlsdGluIGBpZmRlZicgaWdub3JlZApwb2xpY3kvbW9kdWxlcy9zZXJ2aWNl
cy9oYWwudGUiOjExOkVSUk9SICdzeW50YXggZXJyb3InIGF0IHRva2VuICd0eXBlYXR0cmlidXRl
JyBvbiBsaW5lIDEwMzUzMDM6CiNsaW5lIDExCgl0eXBlYXR0cmlidXRlIGhhbGRfdCBkYWVtb247
CmNoZWNrcG9saWN5OiAgZXJyb3IocykgZW5jb3VudGVyZWQgd2hpbGUgcGFyc2luZyBjb25maWd1
cmF0aW9uCm1ha2U6ICoqKiBbcG9saWN5LjI0XSBFcnJvciAxCg==
--0016e64c2740948572046fec54da--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
