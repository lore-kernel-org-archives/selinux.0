Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4TL9arT015704
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 17:09:36 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4TL9Zo9001812
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 21:09:35 GMT
Received: from smtp804.mail.ukl.yahoo.com (smtp804.mail.ukl.yahoo.com [217.12.12.141])
        by jazzband.ncsc.mil  with SMTP id i4TL9YIn001809 for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 21:09:34 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 29 May 2004 21:09:28 -0000
Received: from highfield ([192.168.0.223]:32778 helo=lkcl.net)
	by lkcl.net with esmtp (Exim 4.34 #1)
	id 1BUAQp-0000ku-3U
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 20:27:51 +0000
Date: Sat, 29 May 2004 15:26:49 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Chris Babcock <cbabcock@luthresearch.com>
Cc: mayerf@tresys.com, "'SELinux List'" <selinux@tycho.nsa.gov>
Subject: Re: FW: XP as a base for NetTop
Message-ID: <20040529152649.GA2569@lkcl.net>
References: <004901c44366$a0f3bd70$9a0c010a@columbia.tresys.com> <1985.68.6.187.64.1085615340.squirrel@mxlx1.surveysavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1985.68.6.187.64.1085615340.squirrel@mxlx1.surveysavvy.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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

NT's security model uses DCE/RPC applications to compartmentalise
pretty much everything.

the creation of new processes therefore takes a stunningly long time
(relatively speaking) due to having to go in and out of another
application in order to vet the user's access rights.

the advantage is that process creation can in theory be vetted
and controlled by a remote and centralised NT "primary domain
controller", with the obvious implications:

1) you always have to have a connection to \\yourpdc\PIPE\NETLOGON

2) process creation could be severely delayed if that connection is
   disrupted.

consequently, to avoid any significant delays, threading is highly
recommended in NT "services".

i presume that it is possible to cache security contexts and then
make a rapid switch to them?

makes me wonder why they didn't do the same sort of thing for processes.

oh well.

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
