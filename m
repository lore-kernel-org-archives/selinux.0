Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5P99urT028733
	for <selinux@tycho.nsa.gov>; Fri, 25 Jun 2004 05:09:57 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5P99TVL024093
	for <selinux@tycho.nsa.gov>; Fri, 25 Jun 2004 09:09:43 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Magnus Therning <magnus-work@therning.org>
Subject: Re: SELinux on Debian (Sid), second try
Date: Fri, 25 Jun 2004 19:08:56 +1000
Cc: selinux@tycho.nsa.gov
References: <20040624163900.GB3290@philips.com>
In-Reply-To: <20040624163900.GB3290@philips.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406251908.56334.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 25 Jun 2004 02:39, Magnus Therning <magnus-work@therning.org> wrote:
> Should they be installed in some specific order (i.e. SELinux packages
> before the others, or the other way around)?
>
> Does it matter when I install the kernel with SELinux support?

Install everything apart from selinux-policy-default and then boot the SE 
Linux kernel.  Then install selinux-policy-default last and reboot.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
