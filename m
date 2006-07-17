Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6HJ0LLX027402
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 15:00:21 -0400
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6HJ0L53012594
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 19:00:21 GMT
Message-ID: <44BBDE41.7080709@hp.com>
Date: Mon, 17 Jul 2006 15:00:17 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 0/7] Updated patchset w/James' comments
References: <20060717155224.060020000@hp.com> <200607171848.k6HImHUG020102@turing-police.cc.vt.edu>
In-Reply-To: <200607171848.k6HImHUG020102@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Valdis.Kletnieks@vt.edu wrote:
> On Mon, 17 Jul 2006 11:52:24 EDT, paul.moore@hp.com said:
> 
>>Some changes in the patchset based on James Morris' comments over the weekend, in
>>addition I rebased the patchset against 2.6.18-rc2.
> 
> Minor comment - can you start posting these with Subject: lines that
> say something like:
> 
> Subject: [Patch X/Y] NetLabel-VNN:
> 
> Where 'NN' gets incremented each time you post?  I almost got myself a
> patch set in my "to look at" queue that was half Friday's and half today's,
> and no good could have come from that. And yes, it's *ok* if Friday's was
> -v14 and today is -v15, if we're making progress towards merge-able code.. ;)
> 
> (Venkat - I'm cc'ing you as I've seen the same thing with MLSXFRM patchsets)...
> 

Sure.  Unless the patchset gets accepted it it's current form (a guy can
dream can't he?) I'll mark the next round as "NetLabel-v1".

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
