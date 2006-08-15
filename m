Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7FJLq88004855
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 15:21:56 -0400
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7FJLdFK021336
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 19:21:39 GMT
Date: Tue, 15 Aug 2006 15:21:48 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Cory Olmo <colmo@TrustedCS.com>
cc: selinux@tycho.nsa.gov
Subject: Re: [RFC Patch 1/3] Context Mounts and Unsupported Contexts: kernel
In-Reply-To: <20060815105615.82a6a474.colmo@TrustedCS.com>
Message-ID: <Pine.LNX.4.64.0608151521300.32340@d.namei>
References: <20060815105615.82a6a474.colmo@TrustedCS.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 15 Aug 2006, Cory Olmo wrote:

> This patch modifies selinux_sb_copy_data() so that it will only take an 
> option after seeing a ',' if it hasn't seen a quote or if the quotes are 
> matched. 


Why?


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
