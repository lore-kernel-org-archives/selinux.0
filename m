Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA4HsgWt007228
	for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2003 12:54:42 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA4HsDC9024131
	for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2003 17:54:20 GMT
Date: Tue, 4 Nov 2003 17:54:31 +0000
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Dale Amon <amon@vnl.com>, Russell Coker <russell@coker.com.au>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: default policy package
Message-ID: <20031104175431.GG15714@vnl.com>
References: <20031103114353.GC13273@vnl.com> <200311040115.57564.russell@coker.com.au> <20031103152731.GC29928@vnl.com> <1067876122.21113.70.camel@moss-spartans.epoch.ncsc.mil> <20031103173710.GF29928@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031103173710.GF29928@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Nov 03, 2003 at 05:37:10PM +0000, Dale Amon wrote:
> On Mon, Nov 03, 2003 at 11:15:23AM -0500, Stephen Smalley wrote:
> > On Mon, 2003-11-03 at 10:27, Dale Amon wrote:
> > > Here's one that might interest Steve: load_policy can 
> > > totally lock up a small memory machine if the binary 
> > > policy is large.
> > 
> > What was the memory size and the policy size?  load_policy follows

I got a chance to rebuild one today. This should be nearly the
same size as the one I tested the other day, certainly within
a few percent.

-rw-r--r--    1 root     root      2943339 Nov  4 17:04 policy.15

The memory size was 16M, as I noted yesterday.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
