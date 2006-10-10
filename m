Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9AIBjO6024403
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 14:11:45 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k9AIB4lj001921
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 18:11:05 GMT
Subject: Re: [RFC 2/2] Reference policy: Restrict NetLabel to same MLS
	label connections by default
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: paul.moore@hp.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20061010172155.078810000@hp.com>
References: <20061010171524.936739000@hp.com>
	 <20061010172155.078810000@hp.com>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 14:12:06 -0400
Message-Id: <1160503926.20774.83.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-10 at 13:15 -0400, paul.moore@hp.com wrote:
> plain text document attachment (netlabel-refpolicy_mlsconstraints)
> This patch adjusts the {tcp,udp}_socket recvfrom permissions to only allow
> same MLS label connections.

Looks ok to me.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
