Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB2IxORb017343
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 13:59:24 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB2Iwhp5025790
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 18:58:43 GMT
Received: from unicorn.lemuria.org (c152152.adsl.hansenet.de [213.39.152.152])
	by jazzswing.ncsc.mil  with ESMTP id hB2Iwgt0025779
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 18:58:43 GMT
Date: Tue, 2 Dec 2003 19:52:19 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: policy under version control
Message-ID: <20031202195219.G18433@lemuria.org>
References: <20031129132619.GE26960@lukas.schuldei.com> <1070291615.12270.120.camel@moss-spartans.epoch.ncsc.mil> <20031201202813.I16359@lemuria.org> <200312021430.51186.russell@coker.com.au> <20031202080830.E17580@lemuria.org> <1070377124.16958.13.camel@nexus.verbum.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1070377124.16958.13.camel@nexus.verbum.private>; from walters@verbum.org on Tue, Dec 02, 2003 at 09:58:45AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Dec 02, 2003 at 09:58:45AM -0500, Colin Walters wrote:
> if you're curious.

I am :)


> You shouldn't think in terms of changes to individual files with arch. 
> All changesets in arch are atomic modifications to an entire tree.  
> So you don't really explicitly define what files are identical or
> whatever; instead, if you don't modify them, they simply aren't included
> in your changesets.
> 
> Also, instead of thinking of the distributed nature as a "network-aware
> symlink", I think the most important thing is that it's a truly global
> namespace of changesets (composed mostly of just simple patches), which
> have archives which map to URLs.

Thanks, you explain this much better than I could. Someone else said
off-list that he'd be interested. I think I'll just give it a shot and
try to set up an arch repository on nox.lemuria.org this week.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
