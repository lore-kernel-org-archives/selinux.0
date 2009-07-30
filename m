Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6U5LhMa019011
	for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2009 01:21:43 -0400
Received: from mail-ew0-f211.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n6U5LHX3017405
	for <selinux@tycho.nsa.gov>; Thu, 30 Jul 2009 05:21:17 GMT
Received: by ewy7 with SMTP id 7so18567ewy.18
        for <selinux@tycho.nsa.gov>; Wed, 29 Jul 2009 22:21:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1248882850.11627.64.camel@moss-pluto.epoch.ncsc.mil>
References: <f7d5075c0907290405x4d851cbnaf30980f8fadb308@mail.gmail.com>
	 <CIEOKAFOMGPNJIPMMMAHMELCCBAA.remmolt@zwartsenberg.eu>
	 <f7d5075c0907290626t1c772fd3l9f60c7a710c6152@mail.gmail.com>
	 <f7d5075c0907290704x9b2b426sb6c3bb928a11a98b@mail.gmail.com>
	 <1248882850.11627.64.camel@moss-pluto.epoch.ncsc.mil>
Date: Thu, 30 Jul 2009 09:51:38 +0430
Message-ID: <f7d5075c0907292221m3f04a942xd6216033e923cab6@mail.gmail.com>
Subject: Re: compiling errors!
From: mina elnino <potushka@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0016364d2ab5645646046fe57a39
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016364d2ab5645646046fe57a39
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

well, i have to say that i went through the steps in:

http://danwalsh.livejournal.com/26428.html

and at last i realized that this page is for the ones who want to make
policies from the source. now i have packages:

$ ls ~/rpmbuild/RPMS/noarch/
selinux-policy-3.6.12-62.fc11.noarch.rpm
selinux-policy-doc-3.6.12-62.fc11.noarch.rpm
selinux-policy-minimum-3.6.12-62.fc11.noarch.rpm
selinux-policy-mls-3.6.12-62.fc11.noarch.rpm
selinux-policy-targeted-3.6.12-62.fc11.noarch.rpm

none of them is the source policy package. i mean i need that old m4 macros,
"*.te" files and "policy.conf" which could be installed by
"selinux-policy-targeted-source" or "selinux-policy-strict-source" in fc4.

best regards.

On Wed, Jul 29, 2009 at 8:24 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Wed, 2009-07-29 at 18:34 +0430, mina elnino wrote:
> > thank you. it got solved by installing "ustr-devel".
> > now i should have my source policy files. so according to what you
> > said, i used:
> >
> > $ yumdownloader --source selinux-policy
> >
> > then i had my "src.rpm" package. but i dont know how to install it.
> > the reason is that i am not so familiar with fedora. i have used
> > ubuntu and never worked with rpm packages.
> >
> > i used "Package Installer" but it didn't work! "Backend will not
> > install a src rpm file" was the message. i am not sure if i should
> > have my "policy.conf" file in /etc/selinux/targeted/src/. and what's
> > more, where is the strict type of selinux??
>
> Stay on list, please.
>
> You can just rpm -i the .src.rpm file, and that will expand it under
> ~/rpmbuild, where you can follow the instructions in Dan Walsh's blog
> that I pointed you to earlier.
>
> targeted and strict policies have been merged together; you can map
> users to confined roles via semanage login or system-config-selinux.
>
> --
> Stephen Smalley
> National Security Agency
>
>

--0016364d2ab5645646046fe57a39
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

well, i have to say that i went through the steps in:<br><br><a href=3D"htt=
p://danwalsh.livejournal.com/26428.html">http://danwalsh.livejournal.com/26=
428.html</a><br><br>and at last i realized that this page is for the ones w=
ho want to make policies from the source. now i have packages:<br>
<br>$ ls ~/rpmbuild/RPMS/noarch/<br>selinux-policy-3.6.12-62.fc11.noarch.rp=
m<br>selinux-policy-doc-3.6.12-62.fc11.noarch.rpm<br>selinux-policy-minimum=
-3.6.12-62.fc11.noarch.rpm<br>selinux-policy-mls-3.6.12-62.fc11.noarch.rpm<=
br>
selinux-policy-targeted-3.6.12-62.fc11.noarch.rpm<br><br>none of them is th=
e source policy package. i mean i need that old m4 macros, &quot;*.te&quot;=
 files and &quot;policy.conf&quot; which could be installed by &quot;selinu=
x-policy-targeted-source&quot; or &quot;selinux-policy-strict-source&quot; =
in fc4.<br>
<br>best regards.<br><br><div class=3D"gmail_quote">On Wed, Jul 29, 2009 at=
 8:24 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho=
.nsa.gov">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">On Wed, 2009-07-29 at 18:34 +0430, mina elnino wrote:<br>
&gt; thank you. it got solved by installing &quot;ustr-devel&quot;.<br>
&gt; now i should have my source policy files. so according to what you<br>
&gt; said, i used:<br>
&gt;<br>
&gt; $ yumdownloader --source selinux-policy<br>
&gt;<br>
&gt; then i had my &quot;src.rpm&quot; package. but i dont know how to inst=
all it.<br>
&gt; the reason is that i am not so familiar with fedora. i have used<br>
&gt; ubuntu and never worked with rpm packages.<br>
&gt;<br>
&gt; i used &quot;Package Installer&quot; but it didn&#39;t work! &quot;Bac=
kend will not<br>
&gt; install a src rpm file&quot; was the message. i am not sure if i shoul=
d<br>
&gt; have my &quot;policy.conf&quot; file in /etc/selinux/targeted/src/. an=
d what&#39;s<br>
&gt; more, where is the strict type of selinux??<br>
<br>
</div>Stay on list, please.<br>
<br>
You can just rpm -i the .src.rpm file, and that will expand it under<br>
~/rpmbuild, where you can follow the instructions in Dan Walsh&#39;s blog<b=
r>
that I pointed you to earlier.<br>
<br>
targeted and strict policies have been merged together; you can map<br>
users to confined roles via semanage login or system-config-selinux.<br>
<div><div></div><div class=3D"h5"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</div></div></blockquote></div><br>

--0016364d2ab5645646046fe57a39--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
