Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4R8BBRb002009
	for <selinux@tycho.nsa.gov>; Thu, 27 May 2004 04:11:11 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4R88far005191
	for <selinux@tycho.nsa.gov>; Thu, 27 May 2004 08:08:41 GMT
Received: from smtp804.mail.ukl.yahoo.com (smtp804.mail.ukl.yahoo.com [217.12.12.141])
	by jazzswing.ncsc.mil  with SMTP id i4R88eQu005188
	for <selinux@tycho.nsa.gov>; Thu, 27 May 2004 08:08:40 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 27 May 2004 08:10:44 -0000
Date: Thu, 27 May 2004 08:07:50 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Chris Babcock <cbabcock@luthresearch.com>
Cc: mayerf@tresys.com, "'SELinux List'" <selinux@tycho.nsa.gov>
Subject: Re: FW: XP as a base for NetTop
Message-ID: <20040527080750.GA13687@lkcl.net>
References: <004901c44366$a0f3bd70$9a0c010a@columbia.tresys.com> <1985.68.6.187.64.1085615340.squirrel@mxlx1.surveysavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1985.68.6.187.64.1085615340.squirrel@mxlx1.surveysavvy.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


"The goal is to build on National Security Agency (NSA) research using
 virtual machines to provide separation of security domains on one
 desktop.

 The effort uses VMware 3.02, which has already been evaluated by the
 NSA. There are also plans to add support for Microsoft's Virtual Machine
 Monitor. "



vmware, as you are no doubt aware, runs an entirely separate x86
virtual machine (for which they have licensed phoenix bios).

so it's completely compartmentalised and you do not need to add
in any security into the host OS other than banning it from
network access.

this is a _goooood_ thing: with the focus on speed and functionality
(e.g the screen driver redirection layer being removed from
nt 3.51 for the nt 4.0 release) NT has gone downhill to the
quality and security of windows 3.1 - but for worse, because
of the hundred fold increase in code to audit.


another hint is that they are focussing on network access so
presumably that means writing a special / modified VMware network
driver.


... anyway, what's this got to do with SE/Linux? :)

no.

you don't think they're seriously considering running SE/Linux
in those vmware sessions do you?



On Wed, May 26, 2004 at 04:49:00PM -0700, Chris Babcock wrote:
> > Stephen Smalley wrote:
> >> Looks like Microsoft is indeed pushing an XP-based NetTop
> >> called Trusted Multi-Net/Typhon XP, e.g.:
> >>
> >> http://www.computerweekly.com/Article123730.htm
> >>
> > http://download.microsoft.com/download/4/f/8/4f89f896-f020-46d1-adc0-08a18c8432d
> > 5/Trusted%20Multi-Net%20for%20SSE%202003.ppt
> >
> 
> Interesting.
> 
> The slides indicate that in their system threads are able to change what
> context they run in.
> 
> It makes me wonder if they have some magic to prevent threads from
> poluting shared data (unlikely), or if it is just a hack to avoid process
> vs. thread design issues on windows.
> 
> -Chris
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
