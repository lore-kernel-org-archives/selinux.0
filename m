Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7GDwNGR031096
	for <selinux@tycho.nsa.gov>; Wed, 16 Aug 2006 09:58:23 -0400
Received: from mail8.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7GDw8jK000700
	for <selinux@tycho.nsa.gov>; Wed, 16 Aug 2006 13:58:09 GMT
Date: Wed, 16 Aug 2006 09:58:17 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Cory Olmo <colmo@TrustedCS.com>
cc: selinux@tycho.nsa.gov
Subject: Re: [RFC Patch 1/3] Context Mounts and Unsupported Contexts: kernel
In-Reply-To: <20060815154914.3ee6b06b.colmo@TrustedCS.com>
Message-ID: <Pine.LNX.4.64.0608160956550.7885@d.namei>
References: <Pine.LNX.4.64.0608151521300.32340@d.namei>
 <20060815154914.3ee6b06b.colmo@TrustedCS.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 15 Aug 2006, Cory Olmo wrote:

> > Why?
> 
> Sorry the wording was poor on this one.  The goal is to allow the context 
> portion of the option data to contain commas.  To do that I went with 
> quoting the context.  In order for the quoted context to be taken as a 
> single option, selinux_sb_copy_data() needed to know when it had seen an 
> opening quote and be able to hold off on taking the option until it had 
> seen the closing quote.  

Thanks for the explanation.

Patches which are destined for upstream need, clear, concise descriptions 
which can be understood by general kernel developers.  I suggest also 
adding examples of the contexts to your description.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
