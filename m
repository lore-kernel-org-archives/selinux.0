Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA12921
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 15:59:44 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA11115
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 19:58:01 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id TAA11111
	for <selinux@tycho.nsa.gov>; Fri, 19 Apr 2002 19:58:00 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: initrc question and initrc+proftpd patch
Date: Fri, 19 Apr 2002 21:59:27 +0200
References: <20020419143800.B18906@lemuria.org> <20020419130224.B2E2544E9E@lyta.coker.com.au> <20020419185205.A11916@lemuria.org>
In-Reply-To: <20020419185205.A11916@lemuria.org>
MIME-Version: 1.0
Message-Id: <20020419195927.9D95F1EE37@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 19 Apr 2002 18:52, Tom wrote:
> On Fri, Apr 19, 2002 at 03:02:24PM +0200, Russell Coker wrote:
> > > But please tell me if there's a reason why it's not there, and I'm dumb
> > > and/or compromising the system's security. In order for this to work
> > > on debian, I also added to file_contexts:
> > >
> > > /etc/init.d(|/.*)               system_u:object_r:initrc_exec_t
> >
> > I tried that once, but decided it was a bad idea and changed it back.
>
> Why was it a bad idea? Even without the auto transition, these files
> are, IMHO, special enough and should have a domain. For example, you
> may want to restrict run_init to only being able to execute
> initrc_exec_t files.

I first tried having a transition from init_t to the relevant domain via a 
hacked run_init that didn't require a password if the source context was 
system_u:system_r:init_t.  Then I decided that was a bad idea and make the 
/etc/init.d files be of initrc_exec_t to trigger an automatic domain 
transition, then I did the following:
/etc/init.d/rc                 system_u:object_r:initrc_exec_t
/etc/init.d/rcS                        system_u:object_r:initrc_exec_t

> > > The weird part is that SOME of the program.te files have a
> > > domain_auto_trans line which serves essentially the same purpose. Does
> >
> > Which ones are you referring to?
>
> snort is one example I know by heart. I dig the utils, such as
> ifconfig, but some daemons have this, too.

Which daemons?

I'll change them...

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
