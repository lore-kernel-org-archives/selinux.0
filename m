Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA11309
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 16:31:40 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA09194
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 20:31:18 GMT
Received: from zok.sgi.com (zok.SGI.COM [204.94.215.101])
	by jazzswing.ncsc.mil  with ESMTP id UAA09190
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 20:31:17 GMT
Received: from relay1.corp.sgi.com (spindle.corp.sgi.com [198.29.75.13])
	by zok.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with ESMTP id g5JJXHfA023752
	for <@external-mail-relay.sgi.com:selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 12:33:17 -0700
Received: from stantz.corp.sgi.com (stantz.corp.sgi.com [130.62.4.42]) by relay1.corp.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA69229 for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 13:31:37 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by stantz.corp.sgi.com (Postfix) with ESMTP id 4774BCC
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 13:31:17 -0700 (PDT)
Subject: Re: RH 7.3 and NSA Secure Linux
From: Florin Andrei <florin@sgi.com>
To: selinux@tycho.nsa.gov
In-Reply-To: <1023274046.2138.7.camel@jsmith.org>
References: <NEBBICLICOEMMGDNHPIOGEENDHAA.dnuttall@dnlt.com>
	<1023274046.2138.7.camel@jsmith.org>
Content-Type: text/plain
Date: 19 Jun 2002 13:31:17 -0700
Message-Id: <1024518677.12304.20.camel@stantz.corp.sgi.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2002-06-05 at 03:47, Justin Smith wrote:
> 
> In addition, 7.3 doesn't initialize USB devices automatically. One must
> add the lines 
> 
> alias usb-controller uhci
> alias usbcore uhci
> post-install uhci modprobe printer
> post-install printer modprobe joydev
> post-install joydev modprobe hid
> 
> by hand to /etc/modules.conf

That's weird. For me, USB worked out of the box with a fresh install.

-- 
Florin Andrei

"You can get excited about just any subject if you study it enough.
It's the deep knowledge that makes a topic interesting." - Larry McVoy


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
