Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA05217
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 08:37:51 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA06377
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 12:36:14 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id MAA06373 for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 12:36:13 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Swollen su_macros.te file
Date: Tue, 13 Aug 2002 14:37:37 +0200
Cc: selinux@tycho.nsa.gov
References: <20020813113027.63095.qmail@web40015.mail.yahoo.com>
In-Reply-To: <20020813113027.63095.qmail@web40015.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020813123738.760622BA@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 13 Aug 2002 13:30, Brad Chapman wrote:
> > > > So how do you cause the situation where your programs are running in
> > > > the su domain and causing the errors to be logged?
> > >
> > >         I don't know. Does it have anything to do with the
> > > domain_auto_trans() m4 macro, or does it have to do with the use of su
> > > at all?
> >
> > Show me the error messages from your system logs that caused you to add
> > all those rules.  They will contain the name of the program which was
> > denied access.
>
>          TBH, I never retained any. But I can tell you that any and every
> program not already covered caused errors. For example, programs like
> rpm, lilo, kwrite, kedit, XFree86, quake3.x86, devfsd, insmod, depmod,
> smbd, nmbd, etc would all generate errors, all from the scontext of
> Brad:sysadm_r:sysadm_su_t (I made myself a sysadm as an experiment. Maybe
> that's the problem?)

Firstly, you should not be running quake etc as sysadm_t.  Running programs 
that are known to be a security risk (such as games) with administrative 
privs is a bad idea.

>          BTW, should I try your policy now, or wait until this is fixed,
> then try your policy?

Either should work.  But if you want to try my policy then do it now.


Russell Coker

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
