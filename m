Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4HCF3lq000402
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2010 08:15:03 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o4HCENcr014987
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2010 12:14:23 GMT
Subject: Re: [refpolicy] A strange usecase
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Shaz <shazalive@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>, refpolicy@oss1.tresys.com
In-Reply-To: <AANLkTims07JUhAD9T2KvEGHZauBW6etkgCUQFKTAD1OP@mail.gmail.com>
References: <AANLkTims07JUhAD9T2KvEGHZauBW6etkgCUQFKTAD1OP@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 17 May 2010 08:15:02 -0400
Message-ID: <1274098502.2093.2.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-05-17 at 16:42 +0500, Shaz wrote:
> How can we "make sure a guest user can only see traffic counters of
> eth0 but not eth1"

It is not possible.  That info comes out of the /proc/net/dev proc file.
All interfaces are in the same file, so you can either see all of the
interfaces or none of the interfaces.  This can be controlled by
allowing or denying access to proc_net_t files.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
