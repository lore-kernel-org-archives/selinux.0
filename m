Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i37GDLRb010642
	for <selinux@tycho.nsa.gov>; Wed, 7 Apr 2004 12:13:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i37GBLUZ022629
	for <selinux@tycho.nsa.gov>; Wed, 7 Apr 2004 16:11:21 GMT
Received: from mutemail.com (mutemail.com [24.244.170.124])
	by jazzswing.ncsc.mil  with SMTP id i37GBKmT022614
	for <selinux@tycho.nsa.gov>; Wed, 7 Apr 2004 16:11:21 GMT
Date: Wed, 07 Apr 2004 09:13:01 -0700
From: Bill McCarty <bmccarty@pt-net.net>
To: Peter Gervai <grin@tolna.net>
cc: selinux@tycho.nsa.gov
Subject: Re: Problems finding working kernel/user land combination
Message-ID: <146445517.1081329181@[192.168.0.3]>
In-Reply-To: <20040407075519.GX539@narya.grin.hu>
References: <401FF280.8070301@treblig.org>
 <88042458.1081270777@[192.168.0.3]> <20040407075519.GX539@narya.grin.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks, Pete. I think that the upgrades you mention are the root of the 
problem. I have finally ended up with a working configuration. The last 
ditch stand was needing policy.15 rather than policy.16. But, my procedure 
is still way messy. I plan to start over. If I come up with something clear 
that works, I'll share <g>.

Cheers,

--On Wednesday, April 07, 2004 9:55 AM +0200 Peter Gervai <grin@tolna.net> 
wrote:

> Use sid and add to apt/sources.list to the bottom:
> deb http://www.coker.com.au/newselinux ./
>
> Check whether every essentials (ssh, login, pam) are selinux versions and
> not the plain ones. Sometimes they're a little behind, and debian standard
> versions rush in and "upgrade" 'em. :)

---------------------------------------------------
Bill McCarty, Ph.D.
Professor of Information Technology
Azusa Pacific University



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
