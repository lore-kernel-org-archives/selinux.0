Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6CCxZrT001632
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 08:59:35 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6CCxYPJ008254
	for <selinux@tycho.nsa.gov>; Mon, 12 Jul 2004 12:59:34 GMT
Subject: Re: device_type vs file_type
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200407111900.33374.russell@coker.com.au>
References: <200407111900.33374.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1089637167.22449.49.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 12 Jul 2004 08:59:27 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-07-11 at 05:00, Russell Coker wrote:
> The attached patch removes the file_type attribute from the types for device 
> nodes.
> 
> In most cases rules using file_type are not intended to catch the types for 
> device nodes as well so this should make things simpler.

Likely requires an audit of all uses of file_type in the policy, e.g.
setfiles assumes file_type includes device node types as well.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
