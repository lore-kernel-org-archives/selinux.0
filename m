Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAPJerIi026908
	for <selinux@tycho.nsa.gov>; Thu, 25 Nov 2004 14:40:53 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAPJer4B028129
	for <selinux@tycho.nsa.gov>; Thu, 25 Nov 2004 19:40:54 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: can_network patch.
Date: Fri, 26 Nov 2004 06:40:43 +1100
Cc: Daniel J Walsh <dwalsh@redhat.com>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>
References: <41741A2C.8040408@redhat.com> <41A3917F.30104@redhat.com> <1101240468.19785.298.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1101240468.19785.298.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200411260640.49790.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 24 November 2004 07:07, Stephen Smalley <sds@epoch.ncsc.mil> 
wrote:
> If no one agrees with me about preserving can_network() semantics, then
> I can be overruled.  But I thought that Russell had voiced a similar
> concern earlier.

I still think that can_network() should keep it's traditional functionality.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
