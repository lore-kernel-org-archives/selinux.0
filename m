Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7I9uprT019111
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 05:56:51 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7I9u9ho004789
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 09:56:10 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: idea - running setfiles out of inetd!
Date: Wed, 18 Aug 2004 19:56:46 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>,
   Linux Hotplug Dev List <linux-hotplug-devel@lists.sourceforge.net>
References: <20040817194712.GV18321@lkcl.net>
In-Reply-To: <20040817194712.GV18321@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408181956.46017.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 18 Aug 2004 05:47, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> i'd like to canvas people's opinions of running
> "setfiles -q -s /etc/selinux/contexts/file_contexts" from inetd

Bad idea, anyone can call it.

> the alternative is, in the case of udev, to merge the functionality
> of udevd and udevsend, such that the file context cacheing can
> be taken advantage of.

What if udev spawns "setfiles -q -s" and then sends the file names down the 
pipe to it only closing the pipe after a certain time period of no new nodes?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
