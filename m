Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8MKl4Fk001365
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2011 16:47:04 -0400
Received: from cp-out8.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8MKl21V029212
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2011 20:47:03 GMT
Message-ID: <1316724421.2259.75.camel@vortex>
Subject: Re: [PATCH] Indentation error for Python module seobject (fix typo)
From: Guido Trentalancia <guido@trentalancia.com>
To: Eric Paris <eparis@parisplace.org>
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Thu, 22 Sep 2011 22:47:01 +0200
In-Reply-To: <CACLa4pv-+Fj1jiwf=+WrbXNZ2=NUmrejkhV2FAqETQTF1Lv-Xw@mail.gmail.com>
References: <1316723205.2259.63.camel@vortex>
	 <CACLa4pv-+Fj1jiwf=+WrbXNZ2=NUmrejkhV2FAqETQTF1Lv-Xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-09-22 at 16:45 -0400, Eric Paris wrote:
> It's fixed in a patch on the queue branch titled:
> 
>     policycoreutils: semanage: FIXME whitespace changes in seobject
> 
> Since I believe that is the only line of that patch which actually
> fixes a bug, I'll look at applying your patch to head soon.

Yes, please. It breaks execution otherwise.

> -Eric

Thanks. Guido

> On Thu, Sep 22, 2011 at 4:26 PM, Guido Trentalancia
> <guido@trentalancia.com> wrote:
> > Hello.
> >
> > I get an IndentationError from Python when running code which imports
> > seobject.py (line 182).
> >
> > The following simple patch fixes the problem for current git:
> >
> > --- selinux-22092011/policycoreutils/semanage/seobject.py       2011-09-17 07:03:41.147162393 +0200
> > +++ selinux-22092011-fix-indentation-error-in-seobject-python/policycoreutils/semanage/seobject.py      2011-09-22 22:19:19.036640459 +0200
> > @@ -182,7 +182,7 @@ class semanageRecords:
> >
> >                if not semanageRecords.transaction and store != "":
> >                       semanage_select_store(handle, store, SEMANAGE_CON_DIRECT);
> > -                     semanageRecords.store = store
> > +                      semanageRecords.store = store
> >
> >                if not semanage_is_managed(handle):
> >                       semanage_handle_destroy(handle)
> >
> > Thanks.
> >
> > Guido
> >
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> >
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
