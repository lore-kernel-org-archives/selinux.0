MIME-Version: 1.0
In-Reply-To: <1348083729.11612.4.camel@moss-pluto.epoch.ncsc.mil>
References: <CAFftDdrK8sR=HuHxryryzDjfFOSz_GBsLusPrdsGqXe79YVsYA@mail.gmail.com>
	<1347975644.29192.15.camel@moss-pluto.epoch.ncsc.mil>
	<1348083729.11612.4.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 19 Sep 2012 13:08:22 -0700
Message-ID: <CAFftDdrPxi=ac+JAmG34QR8YBcKKLj=ZOs9xGhPD9L1_tGtyig@mail.gmail.com>
Subject: Re: clean up in android.c
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7b66fb05928fa704ca139103
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b66fb05928fa704ca139103
Content-Type: text/plain; charset=ISO-8859-1

Looks reasonable to me.

On Wed, Sep 19, 2012 at 12:42 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Tue, 2012-09-18 at 09:40 -0400, Stephen Smalley wrote:
> > I think the setcon and setfilecon2 code could be further unified so that
> > the entire logic for matching an entry is encapsulated in a single
> > helper function that takes a bool argument indicating whether it is
> > looking for a domain or type entry.
>
> So the attached patch does the first part above - unify the seapp
> context lookup logic from setcon and setfilecon2, without making any
> changes to how the username mapping is performed.
>
> > We might also want to reconsider how we map the app usernames to a
> > string for seapp_contexts.  I just remapped the new format to the app_
> > prefix so that there would be no breakage going from ICS to JB, but it
> > is a bit misleading.
> >
> > I also think we might want to revisit how we compute the level.
> > Rather than only setting a single category, we might want to compute a
> > category pair based on the UID to increase the number of possible unique
> > levels and avoid any risk that we will run out of unique levels for a
> > large number of installed apps.  For comparison, libvirt assigns a
> > randomly selected category pair for virtual machines and I heard
> > recently that OpenShift is mapping UIDs to category pairs.
> >
>
> --
> Stephen Smalley
> National Security Agency
>



-- 
Respectfully,

William C Roberts

--047d7b66fb05928fa704ca139103
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Looks reasonable to me.<br><br><div class=3D"gmail_quote">On Wed, Sep 19, 2=
012 at 12:42 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sd=
s@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">
<div class=3D"im">On Tue, 2012-09-18 at 09:40 -0400, Stephen Smalley wrote:=
<br>
&gt; I think the setcon and setfilecon2 code could be further unified so th=
at<br>
&gt; the entire logic for matching an entry is encapsulated in a single<br>
&gt; helper function that takes a bool argument indicating whether it is<br=
>
&gt; looking for a domain or type entry.<br>
<br>
</div>So the attached patch does the first part above - unify the seapp<br>
context lookup logic from setcon and setfilecon2, without making any<br>
changes to how the username mapping is performed.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; We might also want to reconsider how we map the app usernames to a<br>
&gt; string for seapp_contexts. =A0I just remapped the new format to the ap=
p_<br>
&gt; prefix so that there would be no breakage going from ICS to JB, but it=
<br>
&gt; is a bit misleading.<br>
&gt;<br>
&gt; I also think we might want to revisit how we compute the level.<br>
&gt; Rather than only setting a single category, we might want to compute a=
<br>
&gt; category pair based on the UID to increase the number of possible uniq=
ue<br>
&gt; levels and avoid any risk that we will run out of unique levels for a<=
br>
&gt; large number of installed apps. =A0For comparison, libvirt assigns a<b=
r>
&gt; randomly selected category pair for virtual machines and I heard<br>
&gt; recently that OpenShift is mapping UIDs to category pairs.<br>
&gt;<br>
<br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
Respectfully,<br><br>William C Roberts<br><br><br>

--047d7b66fb05928fa704ca139103--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
