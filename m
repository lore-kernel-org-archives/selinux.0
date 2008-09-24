Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8O11u7j020098
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2008 21:01:56 -0400
Received: from tundra.namei.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8O10xAY019816
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2008 01:00:59 GMT
Date: Wed, 24 Sep 2008 11:01:33 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
cc: Paul Howarth <paul@city-fan.org>,
        Mike Sweetser - Adhost <mikesw@adhost.com>, selinux@tycho.nsa.gov
Subject: Re: How to find SELinux policy type?
In-Reply-To: <48D98CCE.4050301@ak.jp.nec.com>
Message-ID: <alpine.LRH.1.10.0809241101020.32714@tundra.namei.org>
References: <alpine.LRH.1.10.0809240910240.32319@tundra.namei.org> <17838240D9A5544AAA5FF95F8D52031604BE24FD@ad-exh01.adhost.lan> <20080924012131.76c5e84f@metropolis.intra.city-fan.org> <48D98CCE.4050301@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 24 Sep 2008, KaiGai Kohei wrote:

> selinux_getpolicytype() is available to obtain the current policy type.
> (It paerses /etc/selinux/config.)

That's what I was looking for, thanks.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
