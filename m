MIME-Version: 1.0
In-Reply-To: <1340714335.29157.6.camel@moss-pluto.epoch.ncsc.mil>
References: <CAFftDdo-uftuEXjnpPX=SCfNgSM+hD00p-dP4Jg=5L1TwbRqpg@mail.gmail.com>
	<1340714140.29157.5.camel@moss-pluto.epoch.ncsc.mil>
	<1340714335.29157.6.camel@moss-pluto.epoch.ncsc.mil>
Date: Tue, 26 Jun 2012 07:29:02 -0700
Message-ID: <CAFftDdoR3SshOR1ZTDJPiEHu3i90scpsTNbcbsThfhRf_rSn6w@mail.gmail.com>
Subject: Re: SE Android Galaxy Nexus recovery image
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=e89a8ff2439f81209004c360eb94
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8ff2439f81209004c360eb94
Content-Type: text/plain; charset=ISO-8859-1

yeah i never used an aosp recovery until today. ive always used
clockworkmod.

i syncd today and am on master for maguro device.
On Jun 26, 2012 5:39 AM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:

> On Tue, 2012-06-26 at 08:35 -0400, Stephen Smalley wrote:
> > On Mon, 2012-06-25 at 13:02 -0700, William Roberts wrote:
> > > The recovery image is not working and their appears to be no bin...
> > >
> > >
> > > $ adb logcat
> > > - exec '/system/bin/sh' failed: No such file or directory (2) -
> > >
> > >
> > > Is anyone else getting this?
> > >
> > >
> > > I am looking into it now, but I probably wont have time for a week.
> >
> > Wait, why would you expect that to work from recovery?
> > out/target/product/<device>/recovery/root shows what is available in the
> > recovery image, and bin/sh isn't part of that.
> >
> > That doesn't work for me on Nexus S either, but I don't think it ever
> > has (or is SE Android related).
>
> I think the AOSP recovery is pretty minimal; maybe you are used to using
> Clockwork or similar recoveries instead?
>
> --
> Stephen Smalley
> National Security Agency
>
>

--e89a8ff2439f81209004c360eb94
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>yeah i never used an aosp recovery until today. ive always used clockwor=
kmod. </p>
<p>i syncd today and am on master for maguro device.</p>
<div class=3D"gmail_quote">On Jun 26, 2012 5:39 AM, &quot;Stephen Smalley&q=
uot; &lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wro=
te:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
On Tue, 2012-06-26 at 08:35 -0400, Stephen Smalley wrote:<br>
&gt; On Mon, 2012-06-25 at 13:02 -0700, William Roberts wrote:<br>
&gt; &gt; The recovery image is not working and their appears to be no bin.=
..<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; $ adb logcat<br>
&gt; &gt; - exec &#39;/system/bin/sh&#39; failed: No such file or directory=
 (2) -<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Is anyone else getting this?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; I am looking into it now, but I probably wont have time for a wee=
k.<br>
&gt;<br>
&gt; Wait, why would you expect that to work from recovery?<br>
&gt; out/target/product/&lt;device&gt;/recovery/root shows what is availabl=
e in the<br>
&gt; recovery image, and bin/sh isn&#39;t part of that.<br>
&gt;<br>
&gt; That doesn&#39;t work for me on Nexus S either, but I don&#39;t think =
it ever<br>
&gt; has (or is SE Android related).<br>
<br>
I think the AOSP recovery is pretty minimal; maybe you are used to using<br=
>
Clockwork or similar recoveries instead?<br>
<br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</blockquote></div>

--e89a8ff2439f81209004c360eb94--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
