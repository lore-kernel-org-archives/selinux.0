Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i719dOrT006011
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 05:39:24 -0400 (EDT)
Received: from smtp808.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i719dM0x018756
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 09:39:23 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp808.mail.ukl.yahoo.com with SMTP; 1 Aug 2004 09:39:08 -0000
Date: Sun, 1 Aug 2004 10:50:06 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Nikolay <Nikolay@alexandrov.ws>
Cc: selinux@tycho.nsa.gov
Subject: Re: Some ideas and info.
Message-ID: <20040801095006.GA7384@lkcl.net>
References: <200408010121.i711LUHs013906@mummy.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408010121.i711LUHs013906@mummy.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hello nikolay, from one random selinux user to another, welcome to
the nsa's selinux list.

okay.  selinux was designed to add fine grained auditing and "mandatory"
access control because of concerns over the use in US government
departments of an over-20-year-old security model - i.e. ordinary
non-selinux-enhanced linux.

i presume that the nsa's expertise was best spent focussing on this
specific "lack", given that other research projects were concentrating
on things like PAX, MPPE support etc. (e.g. the http://adamantix.org stuff)

so yes, it'd be great to have additional security measures in place.

i think you'll find that gentoo (hardened) have made use of as many
as they can find.

however the people on _this_ list specifically focus on selinux -
perhaps on its own, perhaps in combination with other security measures
(like gentoo hardened do).

so, with that in mind, can i please ask you a favour?

can i "steer" you in the direction of adamantix.org, because i would
_really_ like to see debian have all of the adamantix.org stuff minus
the RSBAC stuff plus selinux stuff.

it's a bit unfortunate that a lot of this stuff requires a total
recompile of all packages, which is probably why gentoo has it a
bit easier.

l.


On Sun, Aug 01, 2004 at 04:20:54AM -0000, Nikolay wrote:

> Hi. I was wondering if you've thought about implementing non-exec pages and
> stack randomization?
> In case that the user hasn't got the PaX patches it's nice to be protected
> at least a little more isn't it ? I think that at least basic
> implementations of such mechanisms is needed and would help in improving the
> security level.
> I could implement such ideas, if you'd like ofcourse.
> 
> (Sorry for my poor english (it's not my native language. I also intend to
> write often here, I like the ideas of your project and I would be glad to
> help you.)
> Best regards,
> Nikolay
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
