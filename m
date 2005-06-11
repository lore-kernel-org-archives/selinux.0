Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5B0uAgA024316
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 20:56:10 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5B0m31O011374
	for <selinux@tycho.nsa.gov>; Sat, 11 Jun 2005 00:48:03 GMT
Received: from [192.168.1.102] (c-24-61-202-223.hsd1.ma.comcast.net [24.61.202.223])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j5B0mUdf014447
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 20:48:31 -0400 (EDT)
Subject: Re: Nested Booleans
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
In-Reply-To: <1118450294.31022.4.camel@localhost.localdomain>
References: <1118450294.31022.4.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 20:49:07 -0400
Message-Id: <1118450947.31022.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-06-10 at 20:38 -0400, Ivan Gyurdiev wrote:
> Why is it not possible to nest booleans - this is always causing
> problems for me. For example, right now I can't compile my policy, 
> because it contains code like this:

On second thought this is poorly structured, and doesn't make
sense - will fix. However, I still think that it would be nice
if I could nest booleans.. or put apostrophes in comments
without fear.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
