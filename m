Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9N1h6Wt007031
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 21:43:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9N1h5IE019615
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 01:43:05 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9N1h31J019606 for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2003 01:43:05 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joubert Berger <joubert@berger-family.org>,
   Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: init patch for loading policy
Date: Thu, 23 Oct 2003 11:42:52 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <200310200148.15852.russell@coker.com.au> <3F957200.9040201@redhat.com> <1066861893.7534.10.camel@localhost.localdomain>
In-Reply-To: <1066861893.7534.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310231142.52699.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 23 Oct 2003 08:31, Joubert Berger wrote:
> Could you not hard code enough of a policy in the kernel to get init(8)
> up and running?  Then let init run a script that loads the complete
> policy and then runs /etc/rc.d/rc.sysinit or just have rc.sysinit load
> it as it's first step.

This would demand that the kernel be hard coded for init to run in init_t, for 
it's executable to be init_exec_t, and policy to allow init to execute 
load_policy.

This wouldn't necessarily be a good thing, there have already been discussions 
of SE policies that don't have init_t, such policies would conflict with 
hard-coding of the nature which you suggest.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
