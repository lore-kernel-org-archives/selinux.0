Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h97KGiWt014573
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 16:16:44 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h97KGg0p005051
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 20:16:42 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h97KGfr7005046
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 20:16:41 GMT
Subject: Re: [PATCH] Warnings and 64bit
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thorsten Kukuk <kukuk@suse.de>
Cc: Joerg Hoh <joerg@devone.org>, selinux@tycho.nsa.gov,
   James Morris <jmorris@redhat.com>
In-Reply-To: <20031007192903.GA22645@suse.de>
References: <20031004231832.GE3573@hydra.joerghoh.de>
	 <1065467759.3919.121.camel@moss-spartans.epoch.ncsc.mil>
	 <20031007192903.GA22645@suse.de>
Content-Type: text/plain
Message-Id: <1065557794.3919.326.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 07 Oct 2003 16:16:34 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-07 at 15:29, Thorsten Kukuk wrote:
> Maybe in theory, but in practice you will get a lot of compiler
> warnings on 64it archs like AMD64:
> 
> policy_parse.y: In function `define_cexpr':
> policy_parse.y:2644: warning: cast from pointer to integer of different size
> policy_parse.y:2645: warning: cast from pointer to integer of different size
> policy_parse.y:2648: warning: cast from pointer to integer of different size
> policy_parse.y:2649: warning: cast from pointer to integer of different size
> 
> while it may be the case, that in this case we know that nothing can
> happen, in 95% of all cases where I saw this warnings the code was
> really broken and needs to be fixed.
> 
> So we should make sure that we don't get this warnings, they show
> there can be something go wrong.

Ok, we can look into addressing these warnings, but I don't think that
the approach taken by this patch is what we want.  It changes __u32
fields in struct constraint_expr into uintptr_t fields, but these fields
are only used to store integers and need to be fixed size so that the
policy binary representation doesn't change on 64bit. 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
