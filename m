MIME-Version: 1.0
In-Reply-To: <1340194736.30096.31.camel@moss-pluto.epoch.ncsc.mil>
References: <CAFftDdr+nvC3e1bJ62cdB-TWcDeA36QfmrGi3OqTb+oPJ-tqjg@mail.gmail.com>
	<1340194736.30096.31.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 20 Jun 2012 09:33:05 -0700
Message-ID: <CAFftDdqOocQfJF4dYGCOxh4kD1RRcW3Y9w=Vb_+iPrC6bEQQxw@mail.gmail.com>
Subject: Re: [PATCH] ion fix
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=e89a8ff24b3b2037b204c2e9f463
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8ff24b3b2037b204c2e9f463
Content-Type: text/plain; charset=ISO-8859-1

For right now yes, that is the only thing I have seen requiring access by
search is by no means exhaustive.

On Wed, Jun 20, 2012 at 5:18 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Tue, 2012-06-19 at 19:43 -0700, William Roberts wrote:
> >
> >
> > Attached is a patch file that fixes Media Server denial when
> > accessing /dev/ion
> >
> >
> > Since it is for all ICS devices, I put it in external/sepolicy.
> >
> >
> > http://lwn.net/Articles/480055/
>
> Thanks, applied.  Are you sure only mediaserver requires access to it
> though?
>
> --
> Stephen Smalley
> National Security Agency
>
>


-- 
Respectfully,

William C Roberts

--e89a8ff24b3b2037b204c2e9f463
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

For right now yes, that is the only thing I have seen requiring access by s=
earch is by no means exhaustive.=A0<br><br><div class=3D"gmail_quote">On We=
d, Jun 20, 2012 at 5:18 AM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=
=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</=
span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On T=
ue, 2012-06-19 at 19:43 -0700, William Roberts wrote:<br>
&gt;<br>
&gt;<br>
&gt; Attached is a patch file that fixes Media Server denial when<br>
&gt; accessing /dev/ion<br>
&gt;<br>
&gt;<br>
&gt; Since it is for all ICS devices, I put it in external/sepolicy.<br>
&gt;<br>
&gt;<br>
&gt; <a href=3D"http://lwn.net/Articles/480055/" target=3D"_blank">http://l=
wn.net/Articles/480055/</a><br>
<br>
</div></div>Thanks, applied. =A0Are you sure only mediaserver requires acce=
ss to it<br>
though?<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r>Respectfully,<br><br>William C Roberts<br><br><br>

--e89a8ff24b3b2037b204c2e9f463--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
