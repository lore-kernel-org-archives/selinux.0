Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA04860
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 07:30:35 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA03634
	for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 11:28:57 GMT
Received: from web40015.mail.yahoo.com (web40015.mail.yahoo.com [66.218.78.55])
        by jazzband.ncsc.mil  with SMTP id LAA03630 for <selinux@tycho.nsa.gov>; Tue, 13 Aug 2002 11:28:57 GMT
Message-ID: <20020813113027.63095.qmail@web40015.mail.yahoo.com>
Date: Tue, 13 Aug 2002 04:30:27 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Swollen su_macros.te file
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20020813054330.B512B8746@lyta.coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mr. Russell,

--- Russell Coker <russell@coker.com.au> wrote:
> On Tue, 13 Aug 2002 02:26, Brad Chapman wrote:
> > Mr. Russell,
> 
> Mr. Brad,
> What's with the "Mr" prefix to all email?

       Politeness. Being polite to a person over e-mail gets you listened to ;)

> 
> > --- Russell Coker <russell@coker.com.au> wrote:
> > > On Mon, 12 Aug 2002 15:21, Brad Chapman wrote:
> > > >         The context REMAINS THE SAME! Even when I use 'su -l' !!!
> > > >
> > > >         What does this mean?
> > >
> > > This means that su is operating correctly on your system.
> >
> >         Um.... OK. Could you explain that?
> 
> The point of the su domain is that the su program runs in it's own domain 
> with access to authenticate the user and then transitions back to the 
> original domain that it was run from.  So you run su from user_t, and then 
> after the su you're in user_t again.

          Aahhhh - OK, I understand.

> 
> > > So how do you cause the situation where your programs are running in the
> > > su domain and causing the errors to be logged?
> >
> >         I don't know. Does it have anything to do with the
> > domain_auto_trans() m4 macro, or does it have to do with the use of su at
> > all?
> 
> Show me the error messages from your system logs that caused you to add all 
> those rules.  They will contain the name of the program which was denied 
> access.

         TBH, I never retained any. But I can tell you that any and every
program not already covered caused errors. For example, programs like
rpm, lilo, kwrite, kedit, XFree86, quake3.x86, devfsd, insmod, depmod,
smbd, nmbd, etc would all generate errors, all from the scontext of
Brad:sysadm_r:sysadm_su_t (I made myself a sysadm as an experiment. Maybe
that's the problem?)

         BTW, should I try your policy now, or wait until this is fixed,
then try your policy?

Brad


=====
Brad Chapman

Permanent e-mails: kakadu_croc@yahoo.com
		   jabiru_croc@yahoo.com
		   tanami_croc@devel.lbsd.net

__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
