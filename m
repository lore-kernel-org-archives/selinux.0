Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7891lHa004613
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2003 05:01:47 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7890VOD025827
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2003 09:00:31 GMT
Received: from zeno.lemuria.org ([81.161.139.225])
	by jazzswing.ncsc.mil  with ESMTP id h7890UKO025824
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2003 09:00:31 GMT
Date: Fri, 8 Aug 2003 11:01:58 +0200
From: Tom <tom@lemuria.org>
To: David Eaves <deaves@plansys.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Fw: [ISN] IBM earns Linux certification
Message-ID: <20030808090158.GC8977@lemuria.org>
References: <01d001c35d11$ca9deb00$6418a8c0@PSIMONT2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01d001c35d11$ca9deb00$6418a8c0@PSIMONT2>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Aug 07, 2003 at 11:29:08AM -0700, David Eaves wrote:
> Yes it's true the the door got a little wider for Linux. But first of all,
> EAL2, and EAL3 are barely adequate for e-commerce in general, and not for a
> level of threat posed to military systems in time of war, by a highly

In real life, however, most e-commerce systems wouldn't even get
EAL1 if they tried.


> EAL4 is required even for relatively ordinary protection between information
> enclaves. The CC system goes up to EAL7, which requires formal proofs of
> linkage between security targets, protection profiles, and the design and
> implementation of the products in question. The outlook even for SE-linux is

EAL7 is very much a pipe dream. I don't see how any system could ever
reach it. Definitely no existing system, you'd have to start from
scratch, with EAL7 as your main target.


> that nobody will be able to access it who is not supposed to. The Windows
> product lines already have EAL4+ (what the plus means I don't know) versus

The plus usually means they also satisfy one or more requirements of
the higher level.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
