Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA13758
	for <selinux@tycho.nsa.gov>; Sun, 24 Mar 2002 20:45:08 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id BAA14519
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 01:43:44 GMT
Received: from angusbay.vnl.com ([194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id BAA14515
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 01:43:43 GMT
Date: Mon, 25 Mar 2002 01:57:25 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Mix and Match 2: relabel problems
Message-ID: <20020325015725.GA1555@vnl.com>
References: <20020324154541.GA31389@vnl.com> <20020325011447.7E56B2398F@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020325011447.7E56B2398F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 25, 2002 at 01:31:51AM +0100, Russell Coker wrote:
> The -2 release wasn't complete, it had some entries in file_contexts without 
> a matching .te file.  You can comment out those entries, use the slapd.te 
> file I mailed here, or wait for a -3 release (soon I hope).

Hmmm, can't seem to find it with a grep of the mailq. Guess
I'll have to wait or do the comment thing.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
