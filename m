Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA15431
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 10:04:23 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA27995
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 15:03:17 GMT
Received: from angusbay.vnl.com ([194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id PAA27991 for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 15:03:16 GMT
Date: Mon, 25 Mar 2002 15:16:41 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Mix and Match 2: relabel problems
Message-ID: <20020325151641.GK3317@vnl.com>
References: <20020324154541.GA31389@vnl.com> <20020325011447.7E56B2398F@lyta.coker.com.au> <20020325015725.GA1555@vnl.com> <20020325111320.CC3632AB@lyta.coker.com.au> <20020325134940.GF3317@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020325134940.GF3317@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 25, 2002 at 01:49:40PM +0000, Dale Amon wrote:
> On Mon, Mar 25, 2002 at 12:13:19PM +0100, Russell Coker wrote:
> > OK.  I've just put a new version of my selinux base packages online.  I've 
> > added new policy and made some changes to the devfsd shared object (which 
> > also requires a new version of the devfsd package for Debian so I've put it 
> > in the same directory).

Okay, booted and looks good... other than my own crop of avc warnings. Only
about a page full though :-)

 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
