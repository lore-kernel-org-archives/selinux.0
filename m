Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA14987
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 08:37:22 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA04612
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 13:35:56 GMT
Received: from angusbay.vnl.com ([194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id NAA04608
	for <selinux@tycho.nsa.gov>; Mon, 25 Mar 2002 13:35:55 GMT
Date: Mon, 25 Mar 2002 13:49:40 +0000
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Mix and Match 2: relabel problems
Message-ID: <20020325134940.GF3317@vnl.com>
References: <20020324154541.GA31389@vnl.com> <20020325011447.7E56B2398F@lyta.coker.com.au> <20020325015725.GA1555@vnl.com> <20020325111320.CC3632AB@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020325111320.CC3632AB@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Mar 25, 2002 at 12:13:19PM +0100, Russell Coker wrote:
> OK.  I've just put a new version of my selinux base packages online.  I've 
> added new policy and made some changes to the devfsd shared object (which 
> also requires a new version of the devfsd package for Debian so I've put it 
> in the same directory).

Got it, updated my merged set, and it seems to work now. I have to wait
for a kernel build to finish up (more beta testing for HVR) before I
can reboot and get a new list of avc error messages though :-)



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
