Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8PAoYrT023189
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 06:50:34 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8PAoXAk018974
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 10:50:33 GMT
Date: Sat, 25 Sep 2004 12:01:43 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Remove unrestricted_admin
Message-ID: <20040925110142.GA19543@lkcl.net>
References: <200409211526.37810.russell@coker.com.au> <200409250513.29870.russell@coker.com.au> <20040924222253.GB15746@lkcl.net> <200409252039.01196.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200409252039.01196.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Sep 25, 2004 at 08:39:01PM +1000, Russell Coker wrote:

> > > How do you suggest that we address those needs then?
> >
> >  write a small program that does the job, add it to fsadm_t?
> >  [or is that too obvious an answer]
> 
> So you are saying we should write special programs to copy block devices to 
> other block devices, to/from DVD, copying raw partition tables, and all the 
> other things that administrators usually do?  

 hah, i walked into that one :)

 btw i _have_ written a policy for cdrecord, if anyone's interested.

 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
