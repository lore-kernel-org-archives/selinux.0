Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m82Cl3B1031654
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2008 08:47:03 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m82CkR2m010863
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2008 12:46:28 GMT
Subject: Re: [refpolicy] checkpolicy: error(s) encountered while parsing
	configuration
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Justin Mattock <justinmattock@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
In-Reply-To: <dd18b0c30808311634k683b139fm9f17810a66a81074@mail.gmail.com>
References: <dd18b0c30808311634k683b139fm9f17810a66a81074@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 02 Sep 2008 08:45:58 -0400
Message-Id: <1220359558.28287.0.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2008-08-31 at 19:34 -0400, Justin Mattock wrote:
> when loading the latest refpolicy I'm seing a
> policy/modules/kernel/kernel.te":237:ERROR 'syntax error' at token 'corenet_raw_
> corenet_raw_send_multicast_node(kernel_t)
> 
> not sure if this is checkpolicy or refpolicy

I can't reproduce this.  Can you send a modules.conf along with build
settings?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
