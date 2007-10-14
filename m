Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9EATYRr008013
	for <selinux@tycho.nsa.gov>; Sun, 14 Oct 2007 06:29:34 -0400
Received: from rv-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9EATWMP001073
	for <selinux@tycho.nsa.gov>; Sun, 14 Oct 2007 10:29:33 GMT
Received: by rv-out-0910.google.com with SMTP id k15so1076559rvb
        for <selinux@tycho.nsa.gov>; Sun, 14 Oct 2007 03:29:28 -0700 (PDT)
Message-ID: <f71a82820710140329l7bffc054vbc61d11aae572341@mail.gmail.com>
Date: Sun, 14 Oct 2007 19:29:27 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: [Refpolicy PATCH] (just a m4macro description miss?)
In-Reply-To: <1191854900.13098.30.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1191761602.3169.4.camel@notepc.intrajp-yokosuka.co.jp>
	 <1191854900.13098.30.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At second thought, I recommend to fix this one.
Because only this one has one space in the interfaces
in all layers.
We will be collided by any trouble unless not fix it now.


2007/10/8, Christopher J. PeBenito <cpebenito@tresys.com>:
> On Sun, 2007-10-07 at 21:53 +0900, shintaro_fujiwara wrote:
> > Index: policy/modules/services/ucspitcp.if
> > ===================================================================
> > --- policy/modules/services/ucspitcp.if (revision 2446)
> > +++ policy/modules/services/ucspitcp.if (working copy)
> > @@ -20,7 +20,7 @@
> >  ##     </summary>
> >  ## </param>
> >  #
> > -interface(`ucspitcp_service_domain', `
> > +interface(`ucspitcp_service_domain',`
> >       gen_require(`
> >               type ucspitcp_t;
> >               role system_r;
> >
>
> This change shouldn't affect anything.  What incorrect behavior does
> this fix?
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
