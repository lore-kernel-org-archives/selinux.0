Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5RJsW0S015905
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2003 15:54:32 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5RJsV5e011499
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2003 19:54:31 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [144.51.25.14])
        by jazzband.ncsc.mil  with ESMTP id h5RJsV92011496 for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2003 19:54:31 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [127.0.0.1])
	by moss-sooners.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5RJsUn3012520
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2003 15:54:31 -0400
Received: (from hdholm@localhost)
	by moss-sooners.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h5RJsUsm012518
	for selinux@tycho.nsa.gov; Fri, 27 Jun 2003 15:54:30 -0400
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5RJik0S015845
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2003 15:44:47 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5RJhwss017060
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2003 19:43:58 GMT
Received: from MOZART.PatioEnclosuresInc.com (mail.patioenclosuresinc.com [206.183.7.174])
	by jazzswing.ncsc.mil  with ESMTP id h5RJhvhY017057
	for <selinux@tycho.nsa.gov>; Fri, 27 Jun 2003 19:43:58 GMT
Message-ID: <B4E788FBFCD6844F96A017F337797AE167B624@mozart.patioenclosuresinc.com>
From: "Rottura, Steven" <SRottura@patioenclosuresinc.com>
To: "'Howard Holm'" <hdholm@epoch.ncsc.mil>
Cc: selinux-team@epoch.ncsc.mil, selinux@tycho.nsa.gov
Subject: biometric codecs / hardware signed blackbox-capable interconnecti
	ve system-resources
Date: Fri, 27 Jun 2003 15:39:03 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks, I didn't want to get in anybody's hair 9-]   

-----Original Message-----
From: Howard Holm [mailto:hdholm@epoch.ncsc.mil]
Sent: Friday, June 27, 2003 3:40 PM
To: Rottura, Steven
Subject: Re: (no subject)


I really encourage you to post your questions with an applicable title
(e.g., Biometrics) to the selinux list.  I think the wider SELinux
community should probably be thinking about issues like that.  At the
moment there are no specific features of SELinux designed to accomodate
biometric hardware, although I suspect such additions might be useful
and relatively uncomplicated.  I'm sure others on the SELinux list would
have insight and opinions.

On Fri, 2003-06-27 at 15:24, Rottura, Steven wrote:
> Sorry, I quoted as a reply & that is the only reason that the blocked term
> was in the text, the original message, FYI, without the text, is below, in
> case it's worth asking;
> 
> -----Original Message-----
> From: Howard Holm [mailto:hdholm@epoch.ncsc.mil]
> Sent: Friday, June 27, 2003 3:25 PM
> To: Rottura, Steven
> Cc: selinux-team@epoch.ncsc.mil
> Subject: RE: abusive dnsbl's
> 
> 
> As of this morning, the list filters have been set to block further
> discussion of <...>  The below message was trapped as a result of
> its subject and quoting the entire off-topic thread.  Your message has
> not been forwarded to the SELinux list.  Please resend your message
> without the off-topic material and an appropriate subject.
> 
> The SELinux list is maintained at taxpayer expense to discuss SELinux,
> and discussion of other topics must be kept to a minimum.
> 
> I appologize for the inconvenience.
> 
> --
> Howard Holm <hdholm@epoch.ncsc.mil>
> Secure Systems Research Office
> National Security Agency
> 
> On Fri, 2003-06-27 at 15:03, Rottura, Steven wrote:
> > Room for a future question?
> > 	Does SELinux ever consider biometric or other specialized hardware
> > interfacing (i know it's just a patch for linux, but aren't there
> > specialized devices it should intrinsically be built to deal with) /
> > specialized hardware for partitioning and protecting each user /
> > application's priveledge (realtime, on the fly)?  
> > 	Question two is pointed at the future, I am wondering if users and
> > processes will be isolated using hardware for 'virtual machines' or the
> > like; allowing IO between 'virtual machines' so that everything is
> > absolutely defined and everything is absolutely owned by each item.  I
> > suppose some of that is already happening, but I was considering whether
> > hardware facilitated allocation of devices | resources with integrated
> > permissions, all signed of course, per user and process; might be out
> there
> > already for public consumption
-- 
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
