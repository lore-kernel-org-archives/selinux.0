Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7M7npOb018421
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 03:49:51 -0400 (EDT)
Received: from mail.enyo.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7M7dquD008911
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 07:39:53 GMT
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by albireo.enyo.de with esmtp id 1E76uN-0002oB-S7
	for selinux@tycho.nsa.gov; Mon, 22 Aug 2005 09:39:51 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.52)
	id 1E76uI-0002eZ-4V
	for selinux@tycho.nsa.gov; Mon, 22 Aug 2005 09:39:46 +0200
From: Florian Weimer <fw@deneb.enyo.de>
To: selinux@tycho.nsa.gov
Subject: Re: libselinux does not compile on ia64
References: <877jez41lm.fsf@glaurung.internal.golden-gryphon.com>
Date: Mon, 22 Aug 2005 09:39:46 +0200
In-Reply-To: <877jez41lm.fsf@glaurung.internal.golden-gryphon.com> (Manoj
	Srivastava's message of "Sat, 06 Aug 2005 08:49:25 -0500")
Message-ID: <87br3qs9ml.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Manoj Srivastava:

> 	The latest libselinux fails to compile on IA64 with the
>  following error:
>  cc -Wall -I../include -D_GNU_SOURCE    setupns.c  -L../src -lselinux  -o setupn
>  setupns.c:17: error: syntax error before "clone"
>  setupns.c:22: warning: return type defaults to `int'
>
>         Apparently, there is no clone on IA64.

There are no _syscallN macros on IA64 and probably others.  Ulrich
Drepper kindly informed me that you should use the syscall function
instead.  I don't know how I missed it while preparing the patch.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
