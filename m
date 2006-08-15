Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7FKnV9b007080
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 16:49:31 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7FKn8Yh024078
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 20:49:08 GMT
Date: Tue, 15 Aug 2006 15:49:14 -0500
From: Cory Olmo <colmo@TrustedCS.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: [RFC Patch 1/3] Context Mounts and Unsupported Contexts: kernel
Message-Id: <20060815154914.3ee6b06b.colmo@TrustedCS.com>
In-Reply-To: <Pine.LNX.4.64.0608151521300.32340@d.namei>
References: <Pine.LNX.4.64.0608151521300.32340@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 15 Aug 2006 15:21:48 -0400
James Morris <jmorris@namei.org> wrote:

> On Tue, 15 Aug 2006, Cory Olmo wrote:
> 
> > This patch modifies selinux_sb_copy_data() so that it will only take
> an 
> > option after seeing a ',' if it hasn't seen a quote or if the quotes
> are 
> > matched. 
> 
> 
> Why?

Sorry the wording was poor on this one.  The goal is to allow the context 
portion of the option data to contain commas.  To do that I went with 
quoting the context.  In order for the quoted context to be taken as a 
single option, selinux_sb_copy_data() needed to know when it had seen an 
opening quote and be able to hold off on taking the option until it had 
seen the closing quote.  

This patch modifies selinux_sb_copy_data() to mark a flag value when it runs 
across a '"'.  This flag value is consulted each time a comma is 
encountered.  If the flag indicates that the current option has an embedded 
quote it will move on to the next character.  If the flag indicates that 
there is either a matched set of quotes or no quotes at all then the option 
can be taken.  If the option happens to be an selinux option then the new 
routine take_selinux_option() is called.  take_selinux_option() will copy the 
option to the previously allocated selinux data page.  While it is doing the 
copying it will skip any quotes present in the option so the data page contains 
only the raw unquoted context.  The previously used comma separator between 
options in the selinux data page is also replaced with a '|' character which 
allows try_context_mount() to properly extract whole context option strings 
as well.

> 
> 
> -- 
> James Morris
> <jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
