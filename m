Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8N3ekRe017649
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2011 23:40:46 -0400
Received: from mail-fx0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8N3eijQ015882
	for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2011 03:40:45 GMT
Received: by fxh2 with SMTP id 2so3725194fxh.12
        for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2011 20:40:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1316724421.2259.75.camel@vortex>
References: <1316723205.2259.63.camel@vortex>
	<CACLa4pv-+Fj1jiwf=+WrbXNZ2=NUmrejkhV2FAqETQTF1Lv-Xw@mail.gmail.com>
	<1316724421.2259.75.camel@vortex>
Date: Thu, 22 Sep 2011 20:40:44 -0700
Message-ID: <CAEWJHgBmwZPoKVN=4FyWKFnMMDLJLksX3vHUrubLeRb6W-b5Xg@mail.gmail.com>
Subject: Re: [PATCH] Indentation error for Python module seobject (fix typo)
From: Ethan Heidrick <ethanheidrick@gmail.com>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: Eric Paris <eparis@parisplace.org>, SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=0015173ff58ef7c00204ad939224
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0015173ff58ef7c00204ad939224
Content-Type: text/plain; charset=ISO-8859-1

Hello,

wasn't the semanage function fixed without the creating a object directory
earlier?  If i remember but the patch was directed at not adding a new
line.  I may be wrong.

thanks.

On Thu, Sep 22, 2011 at 1:47 PM, Guido Trentalancia
<guido@trentalancia.com>wrote:

> On Thu, 2011-09-22 at 16:45 -0400, Eric Paris wrote:
> > It's fixed in a patch on the queue branch titled:
> >
> >     policycoreutils: semanage: FIXME whitespace changes in seobject
> >
> > Since I believe that is the only line of that patch which actually
> > fixes a bug, I'll look at applying your patch to head soon.
>
> Yes, please. It breaks execution otherwise.
>
> > -Eric
>
> Thanks. Guido
>
> > On Thu, Sep 22, 2011 at 4:26 PM, Guido Trentalancia
> > <guido@trentalancia.com> wrote:
> > > Hello.
> > >
> > > I get an IndentationError from Python when running code which imports
> > > seobject.py (line 182).
> > >
> > > The following simple patch fixes the problem for current git:
> > >
> > > --- selinux-22092011/policycoreutils/semanage/seobject.py
> 2011-09-17 07:03:41.147162393 +0200
> > > +++
> selinux-22092011-fix-indentation-error-in-seobject-python/policycoreutils/semanage/seobject.py
>      2011-09-22 22:19:19.036640459 +0200
> > > @@ -182,7 +182,7 @@ class semanageRecords:
> > >
> > >                if not semanageRecords.transaction and store != "":
> > >                       semanage_select_store(handle, store,
> SEMANAGE_CON_DIRECT);
> > > -                     semanageRecords.store = store
> > > +                      semanageRecords.store = store
> > >
> > >                if not semanage_is_managed(handle):
> > >                       semanage_handle_destroy(handle)
> > >
> > > Thanks.
> > >
> > > Guido
> > >
> > >
> > > --
> > > This message was distributed to subscribers of the selinux mailing
> list.
> > > If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with
> > > the words "unsubscribe selinux" without quotes as the message.
> > >
> >
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

--0015173ff58ef7c00204ad939224
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>wasn&#39;t the semanage function fixed without the creating a=
 object directory earlier?=A0 If i remember but the patch was directed at n=
ot adding a new line.=A0 I may be wrong.<br><br>thanks.<br><br><div class=
=3D"gmail_quote">
On Thu, Sep 22, 2011 at 1:47 PM, Guido Trentalancia <span dir=3D"ltr">&lt;<=
a href=3D"mailto:guido@trentalancia.com">guido@trentalancia.com</a>&gt;</sp=
an> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">On Thu, 2011-09-22 at 16:45 -0400, Eric Paris wrote:<br>
&gt; It&#39;s fixed in a patch on the queue branch titled:<br>
&gt;<br>
&gt; =A0 =A0 policycoreutils: semanage: FIXME whitespace changes in seobjec=
t<br>
&gt;<br>
&gt; Since I believe that is the only line of that patch which actually<br>
&gt; fixes a bug, I&#39;ll look at applying your patch to head soon.<br>
<br>
</div>Yes, please. It breaks execution otherwise.<br>
<br>
&gt; -Eric<br>
<br>
Thanks. Guido<br>
<div><div></div><div class=3D"h5"><br>
&gt; On Thu, Sep 22, 2011 at 4:26 PM, Guido Trentalancia<br>
&gt; &lt;<a href=3D"mailto:guido@trentalancia.com">guido@trentalancia.com</=
a>&gt; wrote:<br>
&gt; &gt; Hello.<br>
&gt; &gt;<br>
&gt; &gt; I get an IndentationError from Python when running code which imp=
orts<br>
&gt; &gt; seobject.py (line 182).<br>
&gt; &gt;<br>
&gt; &gt; The following simple patch fixes the problem for current git:<br>
&gt; &gt;<br>
&gt; &gt; --- selinux-22092011/policycoreutils/semanage/seobject.py =A0 =A0=
 =A0 2011-09-17 07:03:41.147162393 +0200<br>
&gt; &gt; +++ selinux-22092011-fix-indentation-error-in-seobject-python/pol=
icycoreutils/semanage/seobject.py =A0 =A0 =A02011-09-22 22:19:<a href=3D"te=
l:19.036640459" value=3D"+19036640459">19.036640459</a> +0200<br>
&gt; &gt; @@ -182,7 +182,7 @@ class semanageRecords:<br>
&gt; &gt;<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if not semanageRecords.transaction=
 and store !=3D &quot;&quot;:<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 semanage_select_store=
(handle, store, SEMANAGE_CON_DIRECT);<br>
&gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 semanageRecords.store =
=3D store<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0semanageRecords.stor=
e =3D store<br>
&gt; &gt;<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if not semanage_is_managed(handle)=
:<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 semanage_handle_destr=
oy(handle)<br>
&gt; &gt;<br>
&gt; &gt; Thanks.<br>
&gt; &gt;<br>
&gt; &gt; Guido<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; This message was distributed to subscribers of the selinux mailin=
g list.<br>
&gt; &gt; If you no longer wish to subscribe, send mail to <a href=3D"mailt=
o:majordomo@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>
&gt; &gt; the words &quot;unsubscribe selinux&quot; without quotes as the m=
essage.<br>
&gt; &gt;<br>
&gt;<br>
<br>
<br>
<br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</div></div></blockquote></div><br>

--0015173ff58ef7c00204ad939224--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
