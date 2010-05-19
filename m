MIME-Version: 1.0
In-Reply-To: <AANLkTim5wboweoEZfwAIar73Jvskjh4riiAriRzYhA8U@mail.gmail.com>
References: <AANLkTinBSFB6IQCU2BEbYIu1NY_fGSVDwD0BNLZJXC7x@mail.gmail.com>
	<1274212729.8879.171.camel@moss-pluto.epoch.ncsc.mil> <AANLkTim5wboweoEZfwAIar73Jvskjh4riiAriRzYhA8U@mail.gmail.com>
From: waqar afridi <afridi.waqar@gmail.com>
Date: Wed, 19 May 2010 08:39:28 +0500
Message-ID: <AANLkTilrrlLlQJz8dCTVMKipSpIHOpgTFap9owDMlHAF@mail.gmail.com>
Subject: Re: Need Help with security: ebitmap: map size 0 does not match my
	size 64 (high bit was 4)
To: Shaz <shazalive@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=00c09f88d18eb18f6a0486ea35b8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00c09f88d18eb18f6a0486ea35b8
Content-Type: text/plain; charset=ISO-8859-1

Well the Actual reason due to which this problem aroused was due to less
amount of memory (we are using Openmoko software stack on Neo FreeRunner),
Creating the swap space and KILLALLing xinit helped*.* There was nothing
wrong with modules...


On Wed, May 19, 2010 at 1:09 AM, Shaz <shazalive@gmail.com> wrote:

> On Wed, May 19, 2010 at 12:58 AM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > On Mon, 2010-05-17 at 12:24 +0500, waqar afridi wrote:
> >> Hello All
> >>
> >> I am trying to port trisys reference policy on my Openmoko Software
> >> Stack, When ever I try to load it I get the Following error
> >>
> >>
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>
> >> root@om-gta02 ~/refpolicy $ make load
> >> Loading configured modules.
> >> /usr/sbin/semodule -s refpolicy
> >> -b /usr/share/selinux/refpolicy/base.pp
> > <snip>
> >> security: ebitmap: map size 0 does not match my size 64 (high bit was
> >> 4)
> >> libsepol.sepol_module_package_read: invalid module in module package
> >> (at section 0)
> >> libsemanage.semanage_load_module: Error while reading from module
> >> file /etc/selinux/refpolicy/modules/tmp/modules/unconfined.pp.
> >> /usr/sbin/semodule:  Failed!
> >>
> >>
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>
> >> Reference Policy Version: 2008 04 02
> >>
> >> semodule from: policycoreutils-2.0.55
> >>
> >> Any Suggestion what could be the Problem???
> >
> > I haven't seen that error previously.  It implies that the unconfined.pp
> > module was incorrectly compiled or somehow corrupted.
> >
> > Is it reproducible with a more modern selinux userspace and refpolicy?
> > http://userspace.selinuxproject.org/trac/wiki/Releases
> > http://oss.tresys.com/projects/refpolicy/wiki/DownloadRelease
>
> We got it solved ... some variables were not set properly during
> compilation. Tomorrow we start testing.
>
>
> --
> Shaz
>



-- 
Waqar Afridi

Android Developer
SERG IM|Sciences
waqarafridi.wordpress.com
http://imsciences.edu.pk/serg/?page_id=376

--00c09f88d18eb18f6a0486ea35b8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Well the Actual reason due to which this problem aroused w=
as due to less amount of memory (we are using Openmoko software stack on Ne=
o FreeRunner), Creating the swap space and KILLALLing xinit helped<b>.</b> =
There was nothing wrong with modules...<br>

<span class=3D"Apple-style-span" style=3D"border-collapse: separate; color:=
 rgb(0, 0, 0); font-family: &#39;Times New Roman&#39;; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; line-hei=
ght: normal; orphans: 2; text-indent: 0px; text-transform: none; white-spac=
e: normal; widows: 2; word-spacing: 0px; font-size: medium;"><span class=3D=
"Apple-style-span" style=3D"font-family: arial,sans-serif; font-size: 13px;=
"></span></span><br>

<br><div class=3D"gmail_quote">On Wed, May 19, 2010 at 1:09 AM, Shaz <span =
dir=3D"ltr">&lt;<a href=3D"mailto:shazalive@gmail.com">shazalive@gmail.com<=
/a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:=
 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left=
: 1ex;">

<div><div></div><div class=3D"h5">On Wed, May 19, 2010 at 12:58 AM, Stephen=
 Smalley &lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;=
 wrote:<br>
&gt; On Mon, 2010-05-17 at 12:24 +0500, waqar afridi wrote:<br>
&gt;&gt; Hello All<br>
&gt;&gt;<br>
&gt;&gt; I am trying to port trisys reference policy on my Openmoko Softwar=
e<br>
&gt;&gt; Stack, When ever I try to load it I get the Following error<br>
&gt;&gt;<br>
&gt;&gt; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++<br>
&gt;&gt;<br>
&gt;&gt; root@om-gta02 ~/refpolicy $ make load<br>
&gt;&gt; Loading configured modules.<br>
&gt;&gt; /usr/sbin/semodule -s refpolicy<br>
&gt;&gt; -b /usr/share/selinux/refpolicy/base.pp<br>
&gt; &lt;snip&gt;<br>
&gt;&gt; security: ebitmap: map size 0 does not match my size 64 (high bit =
was<br>
&gt;&gt; 4)<br>
&gt;&gt; libsepol.sepol_module_package_read: invalid module in module packa=
ge<br>
&gt;&gt; (at section 0)<br>
&gt;&gt; libsemanage.semanage_load_module: Error while reading from module<=
br>
&gt;&gt; file /etc/selinux/refpolicy/modules/tmp/modules/unconfined.pp.<br>
&gt;&gt; /usr/sbin/semodule: =A0Failed!<br>
&gt;&gt;<br>
&gt;&gt; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++<br>
&gt;&gt;<br>
&gt;&gt; Reference Policy Version: 2008 04 02<br>
&gt;&gt;<br>
&gt;&gt; semodule from: policycoreutils-2.0.55<br>
&gt;&gt;<br>
&gt;&gt; Any Suggestion what could be the Problem???<br>
&gt;<br>
&gt; I haven&#39;t seen that error previously. =A0It implies that the uncon=
fined.pp<br>
&gt; module was incorrectly compiled or somehow corrupted.<br>
&gt;<br>
&gt; Is it reproducible with a more modern selinux userspace and refpolicy?=
<br>
&gt; <a href=3D"http://userspace.selinuxproject.org/trac/wiki/Releases" tar=
get=3D"_blank">http://userspace.selinuxproject.org/trac/wiki/Releases</a><b=
r>
&gt; <a href=3D"http://oss.tresys.com/projects/refpolicy/wiki/DownloadRelea=
se" target=3D"_blank">http://oss.tresys.com/projects/refpolicy/wiki/Downloa=
dRelease</a><br>
<br>
</div></div>We got it solved ... some variables were not set properly durin=
g<br>
compilation. Tomorrow we start testing.<br>
<br>
<br>
--<br>
<font color=3D"#888888">Shaz<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Waqar Afridi<br>=
<br>Android Developer<br>SERG IM|Sciences<br><a href=3D"http://waqarafridi.=
wordpress.com">waqarafridi.wordpress.com</a><br><a href=3D"http://imscience=
s.edu.pk/serg/?page_id=3D376">http://imsciences.edu.pk/serg/?page_id=3D376<=
/a><br>


</div>

--00c09f88d18eb18f6a0486ea35b8--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
