Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0BIn6ra011567
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2007 13:49:06 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0BInuSL026051
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2007 18:49:56 GMT
Subject: Re: [RFC] Support for bzip compressed modules
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: russell@coker.com.au
Cc: James Antill <jantill@redhat.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200701100933.45159.russell@coker.com.au>
References: <45A2AADC.1090907@mentalrootkit.com>
	 <1168327098.22423.93.camel@code.and.org>
	 <200701100933.45159.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 11 Jan 2007 13:48:36 -0500
Message-Id: <1168541316.7048.46.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-01-10 at 09:33 +1100, Russell Coker wrote:
> On Tuesday 09 January 2007 18:18, James Antill <jantill@redhat.com> wrote:
> >  I assume the only reason you went with bzip2 over gzip is the "have to
> > init yourself in the set_mem case"? I've done that before[1], so I can
> > help you get that bit done if you want ... this will drop
> > CPU/memory/dependency requirements (although expecting all Linux to have
> > libbz now isn't a big deal, IMO).
> 
> Given that the vast majority of new machines now are AMD64 part of the CPU 
> requirement will be due to bzip2 and gzip not being optimised for AMD64.  
> gzip has i386 assembler optimisation but no AMD64 assembler and runs more 
> slowly on AMD64 because of it (my tests show that on RHEL4 the i386 copy of 
> gzip outperforms the AMD64 version on Opteron machines).
> 
> If you compare the AMD64 compiled version of gzip (IE the library) with bzip2 
> the difference in CPU time is a lot smaller than it is when comparing the 
> i386 versions.
> 
> Of course it probably wouldn't be difficult for someone to write some AMD64 
> assembler code for gzip or bzip2 to change things.
> 

Ok.

> 
> In regard to the following, I think that the 15 seconds for uncompressed 
> operation is the problem not the 1-3 seconds that are added.  Is there any 
> chance of optimising the other operations of semodule?  If we could get a 10% 
> improvement in the base functionality then "semodule -b" with compression 
> would be expected to give the same performance as currently, if we could get 
> a 20% improvement then "semodule -i" would give the current performance too.  

Hopefully these will get faster over time - there has been very little
performance work done to that code.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
