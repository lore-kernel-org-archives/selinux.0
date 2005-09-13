Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8D93hNs020959
	for <selinux@tycho.nsa.gov>; Tue, 13 Sep 2005 05:03:44 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8D90sXB007024
	for <selinux@tycho.nsa.gov>; Tue, 13 Sep 2005 09:00:55 GMT
Received: from lkcl.net (unknown [87.82.14.2])
	by free.hands.com (Postfix) with ESMTP id AE2ACC0D3
	for <selinux@tycho.nsa.gov>; Tue, 13 Sep 2005 10:00:46 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1EF6eo-0003PW-P5
	for selinux@tycho.nsa.gov; Tue, 13 Sep 2005 10:00:50 +0100
Date: Tue, 13 Sep 2005 10:00:50 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: [jeroen@wolffelaar.nl: Re: ftp.debian.org: libselinux1 needs to be priority "important" or "required"]
Message-ID: <20050913090050.GT9179@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

whoopeeee.

it's been a year, now, but raising all these bugreports actually
seems to be working.

----- Forwarded message from Jeroen van Wolffelaar <jeroen@wolffelaar.nl> -----

Envelope-to: lkcl@localhost
Delivery-date: Tue, 13 Sep 2005 09:49:16 +0100
X-Sieve: CMU Sieve 2.2
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
	251749-done@bugs.debian.org
Subject: Re: ftp.debian.org: libselinux1 needs to be priority "important" or "required"
From: Jeroen van Wolffelaar <jeroen@wolffelaar.nl>
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: jeroen@wolffelaar.nl

On Sun, May 30, 2004 at 04:54:42PM +0000, Luke Kenneth Casson Leighton wrote:
> hello, hello,
> 
> please see:
> 
> http://groups.google.com/groups?dq=&hl=en&lr=&ie=UTF-8&threadm=21wcZ-2QH-23%40gated-at.bofh.it&prev=/groups%3Fhl%3Den%26lr%3D%26ie%3DUTF-8%26group%3Dlinux.debian.devel
> 
> or equivalent for details.
> 
> the issue is that libselinux1 is presently on "override" by
> ftp.debian.org to "optional" from its priority of "required".
> 
> it's really crucial that libselinux1 be given a priority of
> "required".

Done yesterday on request of the maintainer.

Thanks,
--Jeroen

-- 
Jeroen van Wolffelaar
jeroen@wolffelaar.nl
http://jeroen.A-Eskwadraat.nl

----- End forwarded message -----

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
