Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8SIjsrT009826
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 14:45:54 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8SIipuK002376
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 18:44:52 GMT
Subject: Re: sendmail and cron policy
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200409250545.20316.russell@coker.com.au>
References: <200409250545.20316.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1096397093.30810.91.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 28 Sep 2004 14:44:53 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Fri, 2004-09-24 at 15:45, Russell Coker wrote:
> The attached patch allows sysadm cron jobs to run setfiles without AVC 
> messages, and also allows sendmail to be run from sysadm_t without AVC 
> messages.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
