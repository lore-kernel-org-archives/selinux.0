MIME-Version: 1.0
In-Reply-To: <1342728541.5158.6.camel@moss-pluto.epoch.ncsc.mil>
References: <1342305889-7675-1-git-send-email-jinlin.xu@sta.samsung.com>
	<1342305889-7675-2-git-send-email-jinlin.xu@sta.samsung.com>
	<1342728541.5158.6.camel@moss-pluto.epoch.ncsc.mil>
Date: Thu, 19 Jul 2012 15:25:51 -0700
Message-ID: <CAO-4OdFyumm5CJoyMxYKm18MGHncWAX2i3DgKGXGwD7VeaFrOg@mail.gmail.com>
Subject: Re: [PATCH 1/1] add sepolicy.genfs_contexts file for device-specific labels
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com,
        jinlin <jinlin.xu@sta.samsung.com>
Content-Type: multipart/alternative; boundary=f46d0401240b1cbca604c53643c5
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d0401240b1cbca604c53643c5
Content-Type: text/plain; charset=ISO-8859-1

I am sorry for the missing information. The patch is for
/device/samsung/maguro in seandroid-4.0.4 branch. I think currently you
have applied the patches in master branch.
But could you please also apply them in seandroid-4.0.4 branch? Thanks.

On Thu, Jul 19, 2012 at 1:09 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Sat, 2012-07-14 at 15:44 -0700, jinlin wrote:
> > ---
> >  sepolicy.genfs_contexts |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >  create mode 100644 sepolicy.genfs_contexts
>
> For which project(s)?  device/samsung/maguro?  Put it in the subject
> line.
>
> >
> > diff --git a/sepolicy.genfs_contexts b/sepolicy.genfs_contexts
> > new file mode 100644
> > index 0000000..4a4f32a
> > --- /dev/null
> > +++ b/sepolicy.genfs_contexts
> > @@ -0,0 +1 @@
> > +include(`device/samsung/tuna/sepolicy.genfs_contexts')
>
> --
> Stephen Smalley
> National Security Agency
>
>


-- 
-----------------------------------
Haiqing Jiang, PH.D student

Computer Science Department, North Carolina State University

--f46d0401240b1cbca604c53643c5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I am sorry for the missing information. The patch is for /device/samsung/ma=
guro in seandroid-4.0.4 branch. I think currently you have applied the patc=
hes in master branch.=A0<div>But could you please also apply them in seandr=
oid-4.0.4 branch? Thanks.=A0<br>
<br><div class=3D"gmail_quote">On Thu, Jul 19, 2012 at 1:09 PM, Stephen Sma=
lley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_=
blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
<div class=3D"im">On Sat, 2012-07-14 at 15:44 -0700, jinlin wrote:<br>
&gt; ---<br>
&gt; =A0sepolicy.genfs_contexts | =A0 =A01 +<br>
&gt; =A01 files changed, 1 insertions(+), 0 deletions(-)<br>
&gt; =A0create mode 100644 sepolicy.genfs_contexts<br>
<br>
</div>For which project(s)? =A0device/samsung/maguro? =A0Put it in the subj=
ect<br>
line.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; diff --git a/sepolicy.genfs_contexts b/sepolicy.genfs_contexts<br>
&gt; new file mode 100644<br>
&gt; index 0000000..4a4f32a<br>
&gt; --- /dev/null<br>
&gt; +++ b/sepolicy.genfs_contexts<br>
&gt; @@ -0,0 +1 @@<br>
&gt; +include(`device/samsung/tuna/sepolicy.genfs_contexts&#39;)<br>
<br>
--<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">Stephen Smalley<=
br>
National Security Agency<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div>-----------------------------------</div>Haiqing Jiang, PH.D student=
<div><br></div><div>Computer Science Department, North Carolina State Unive=
rsity<br>
<div><br></div></div><br>
</div>

--f46d0401240b1cbca604c53643c5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
