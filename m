Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA25264
	for <selinux@tycho.nsa.gov>; Sun, 11 Aug 2002 17:28:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA03901
	for <selinux@tycho.nsa.gov>; Sun, 11 Aug 2002 21:27:56 GMT
Received: from web40004.mail.yahoo.com (web40004.mail.yahoo.com [66.218.78.22])
	by jazzswing.ncsc.mil  with SMTP id VAA03897
	for <selinux@tycho.nsa.gov>; Sun, 11 Aug 2002 21:27:55 GMT
Message-ID: <20020811212852.27792.qmail@web40004.mail.yahoo.com>
Date: Sun, 11 Aug 2002 14:28:52 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Swollen su_macros.te file
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20020811212159.9371B339@lyta.coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mr. Russell,

--- Russell Coker <russell@coker.com.au> wrote:
> On Sun, 11 Aug 2002 22:57, Brad Chapman wrote:
> >
> >         It is labeled as shell_exec_t.
> 
> Check that you have the domain_auto_trans() macro correctly functioning for 
> transitioning to the user_t domain from user_su_t on execute of shell_exec_t.
> 
> Inside the domain_auto_trans macro put the following line for debugging 
> purposes:
> #DOMAIN_AUTO_TRANS($1, $2, $3)
> 
> Then you'll be able to easily check that the correct rule is going in. 

       ACK.

> >         I know that, but how long will it take me to remove all of the
> > errors that I KNOW will pop up, because of basic differences in locations
> > and such? I use Red Hat 6.2, BTW.
> 
> The easy way to solve these problems is to find out why things aren't working

> as they should and fix it.
> 
> The hard way is to continually hack in extra rules for domains that shouldn't

> have them so that eventually every domain can do almost everything, and you 
> lose most of the security you wanted to gain from SE Linux in the first
> place.
> 
> The NSA people wrote their original policy for Red Hat.  In my changes I have

> been careful to try and avoid doing things that are likely to break it for 
> Red Hat users.  Steve is presumably still testing his policy on Red Hat 
> before commiting it to the CVS.
> 
> Getting it to work on Red Hat should not be THAT difficult.

        All right. I'll try it out and report back any major problems I have.

> 
> -- 
> I do not get viruses because I do not use MS software.
> If you use Outlook then please do not put my email address in your
> address-book so that WHEN you get a virus it won't use my address in the
> From field.


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
