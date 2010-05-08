MIME-Version: 1.0
In-Reply-To: <1273239813.20596.9.camel@moss-pluto.epoch.ncsc.mil>
References: <y2n78aaeffc1005052324g38e6173pc71674e3a523e670@mail.gmail.com>
	<1273239813.20596.9.camel@moss-pluto.epoch.ncsc.mil>
From: waqar afridi <afridi.waqar@gmail.com>
Date: Sat, 8 May 2010 10:09:34 +0500
Message-ID: <t2n78aaeffc1005072209od9813ea9l30fd15650d9540d5@mail.gmail.com>
Subject: Re: Broken pipe Error
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=000feaee5d4ba962d304860e2f08
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--000feaee5d4ba962d304860e2f08
Content-Type: text/plain; charset=ISO-8859-1

Yup, M4 is Installed but I have cross-compiled it now, I wasn't able to
cross-compile it independently but It worked with cross-compiling the whole
user-space, I dont know why?

On Fri, May 7, 2010 at 6:43 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Thu, 2010-05-06 at 11:24 +0500, waqar afridi wrote:
> > Hello All
> >
> > I am trying to Cross compile checkmodules for arm architecture but
> > whenever I do, I get the Following Error
> >
> > #make checkmodule
> >
> > bison -y -d policy_parse.y
> > make: *** [y.tab.c] Broken pipe
> >
> > btw I have also tried yacc but results were the Same, Any Idea?
> >
> > Thanx in Advance...
>
> Do you have GNU m4 installed?
>
> --
> Stephen Smalley
> National Security Agency
>
>


-- 
Waqar Afridi

Android Developer
SERG IM|Sciences
waqarafridi.wordpress.com
http://imsciences.edu.pk/serg/?page_id=376

--000feaee5d4ba962d304860e2f08
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yup, M4 is Installed but I have cross-compiled it now, I w=
asn&#39;t able to cross-compile it independently but It worked with cross-c=
ompiling the whole user-space, I dont know why?<br><br><div class=3D"gmail_=
quote">

On Fri, May 7, 2010 at 6:43 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">

<div><div></div><div class=3D"h5">On Thu, 2010-05-06 at 11:24 +0500, waqar =
afridi wrote:<br>
&gt; Hello All<br>
&gt;<br>
&gt; I am trying to Cross compile checkmodules for arm architecture but<br>
&gt; whenever I do, I get the Following Error<br>
&gt;<br>
&gt; #make checkmodule<br>
&gt;<br>
&gt; bison -y -d policy_parse.y<br>
&gt; make: *** [y.tab.c] Broken pipe<br>
&gt;<br>
&gt; btw I have also tried yacc but results were the Same, Any Idea?<br>
&gt;<br>
&gt; Thanx in Advance...<br>
<br>
</div></div>Do you have GNU m4 installed?<br>
<font color=3D"#888888"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Waqar Afridi<br>=
<br>Android Developer<br>SERG IM|Sciences<br><a href=3D"http://waqarafridi.=
wordpress.com">waqarafridi.wordpress.com</a><br><a href=3D"http://imscience=
s.edu.pk/serg/?page_id=3D376">http://imsciences.edu.pk/serg/?page_id=3D376<=
/a><br>


</div>

--000feaee5d4ba962d304860e2f08--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
