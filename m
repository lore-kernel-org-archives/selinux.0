MIME-Version: 1.0
In-Reply-To: <1347640163.11029.61.camel@moss-pluto.epoch.ncsc.mil>
References: <CAFftDdr2YZiyFWfiyABAD_p81Usfz8SFeqaWBR7Uz40mJMFHhg@mail.gmail.com>
	<1347627083.11029.12.camel@moss-pluto.epoch.ncsc.mil>
	<33006C99F5A5194A9B7A7715DFA3E3836519B104@ALA-MBA.corp.ad.wrs.com>
	<1347640163.11029.61.camel@moss-pluto.epoch.ncsc.mil>
Date: Fri, 14 Sep 2012 11:10:46 -0700
Message-ID: <CAFftDdrZ=jQKRnN1HK-8qVefsgvYPdGBxSFo0rQuvUgc4cP+4Q@mail.gmail.com>
Subject: Re: Update to docs
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Radzykewycz, T (Radzy)" <radzy@windriver.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "Craig, Robert P." <rpcraig@tycho.ncsc.mil>
Content-Type: multipart/alternative; boundary=f46d043c812cce996a04c9ad57bf
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d043c812cce996a04c9ad57bf
Content-Type: text/plain; charset=ISO-8859-1

Yeah it is a bit unwieldy, currently I use the include mechanism to include
stuff in a device/sepolicy folder. Right now, the only thing I have
modified in the base policy that I don't have upstream is commenting out
inits transition rule to shell domain on exec of shell_exec.

It would be really nice to do something like seapp_contexts but for the
selinux policies.

Bill


On Fri, Sep 14, 2012 at 9:29 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2012-09-14 at 16:19 +0000, Radzykewycz, T (Radzy) wrote:
> > There have been a couple times when I wanted to remove a rule from the
> > system policy for a specific BSP.  So I guess I would vote for
> > override if I need to choose one or the other.  But would it be
> > reasonable to allow both overrides and concatenates ?  That would be
> > my preference.
>
> Maybe we could provide two variables definitions in the makefiles, one
> for policy files that should replace/override and one for policy files
> that should concatenate/union with the base policy files?
>
> --
> Stephen Smalley
> National Security Agency
>
>


-- 
Respectfully,

William C Roberts

--f46d043c812cce996a04c9ad57bf
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Yeah it is a bit unwieldy, currently I use the include mechanism to include=
 stuff in a device/sepolicy folder. Right now, the only thing I have modifi=
ed in the base policy that I don&#39;t have upstream is commenting out init=
s transition rule to shell domain on exec of shell_exec.<div>
<br></div><div>It would be really nice to do something like seapp_contexts =
but for the selinux policies.</div><div><br></div><div>Bill</div><div><br><=
div><br><div class=3D"gmail_quote">On Fri, Sep 14, 2012 at 9:29 AM, Stephen=
 Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=
=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Fri, 2012-09-14 at 16:1=
9 +0000, Radzykewycz, T (Radzy) wrote:<br>
&gt; There have been a couple times when I wanted to remove a rule from the=
<br>
&gt; system policy for a specific BSP. =A0So I guess I would vote for<br>
&gt; override if I need to choose one or the other. =A0But would it be<br>
&gt; reasonable to allow both overrides and concatenates ? =A0That would be=
<br>
&gt; my preference.<br>
<br>
</div>Maybe we could provide two variables definitions in the makefiles, on=
e<br>
for policy files that should replace/override and one for policy files<br>
that should concatenate/union with the base policy files?<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
Respectfully,<br><br>William C Roberts<br><br><br>
</div></div>

--f46d043c812cce996a04c9ad57bf--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
