Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4NIsXgA010659
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2005 14:54:33 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4NInuMj004017
	for <selinux@tycho.nsa.gov>; Mon, 23 May 2005 18:49:57 GMT
Date: Mon, 23 May 2005 16:32:39 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Roger Brunell <rog_brunell@yahoo.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Time estimate to create Debian enforceable policy
Message-ID: <20050523153239.GH8953@lkcl.net>
References: <20050523132611.20533.qmail@web60425.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050523132611.20533.qmail@web60425.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi roger,

slightly confused by your message.  there have been a couple of people
who have debian / selinux working, from russell and dan's .deb packages.

i spent nearly 5 months on the project - a lot of that was spent
trying to get KDE 3.4 (from cvs!) to work, including running the
alpha-qualitied kvm, with its support for udev.

the basic work's already been done, in there.

i would be rather concerned about the lack of SELinux experience
of your moderately smart person.  SElinux is _not_ for the
faint-hearted, from a development perspective.

... what _kind_ of policy?

are you talking about a radical departure from "strict" or
"targetted"?

i would strongly advise against that.

l.

On Mon, May 23, 2005 at 06:26:11AM -0700, Roger Brunell wrote:
> Folk;
>   I am looking for some SWAGs in [days|weeks|months]
> for:
> Given moderately smart person, w/:
>       20 years UNIX experience.
>       30 years programming exp.
>        1.5 years with Linux/Debian
>        4 weeks SELinux exp.
>       appropiate resources (SELinux running on system)
> 
> To create, test and verify a meaningful, workable and enforceable
>    policy for a <<elided>> (Mish-Mash of Debian parts)
>    system.
> 
>    
> 
> 
> Roger Brunell
> 
> Infosec Engineer (retired)
> "Born 20 years too early"
> 
> 
> 		
> __________________________________ 
> Yahoo! Mail Mobile 
> Take Yahoo! Mail with you! Check email on your mobile phone. 
> http://mobile.yahoo.com/learn/mail 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
