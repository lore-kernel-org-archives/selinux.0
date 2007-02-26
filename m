Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1QG3rmL008705
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 11:03:53 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1QG4UdB001385
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 16:05:14 GMT
Subject: Re: Updates to squid policy and corenet policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45DB23A7.1040507@redhat.com>
References: <45DB23A7.1040507@redhat.com>
Content-Type: text/plain
Date: Mon, 26 Feb 2007 16:04:48 +0000
Message-Id: <1172505888.19655.21.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 11:36 -0500, Daniel J Walsh wrote:
> Add policy to handle  /usr/lib/squid/cachemgr\.cgi  
> 
> Additional squid ports.
> 
> Also changed corenetworks to handle hi_reserved_port_t for name_bind only.

Please separate out the corenetwork parts that aren't related to squid
changes.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
