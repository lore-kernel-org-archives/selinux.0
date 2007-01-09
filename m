Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0A9qmBO011984
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2007 04:52:49 -0500
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0A9rZuY018299
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2007 09:53:36 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: James Antill <jantill@redhat.com>
Subject: Re: [RFC] Support for bzip compressed modules
Date: Wed, 10 Jan 2007 09:33:40 +1100
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
References: <45A2AADC.1090907@mentalrootkit.com> <1168327098.22423.93.camel@code.and.org>
In-Reply-To: <1168327098.22423.93.camel@code.and.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200701100933.45159.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 09 January 2007 18:18, James Antill <jantill@redhat.com> wrote:
>  I assume the only reason you went with bzip2 over gzip is the "have to
> init yourself in the set_mem case"? I've done that before[1], so I can
> help you get that bit done if you want ... this will drop
> CPU/memory/dependency requirements (although expecting all Linux to have
> libbz now isn't a big deal, IMO).

Given that the vast majority of new machines now are AMD64 part of the CPU 
requirement will be due to bzip2 and gzip not being optimised for AMD64.  
gzip has i386 assembler optimisation but no AMD64 assembler and runs more 
slowly on AMD64 because of it (my tests show that on RHEL4 the i386 copy of 
gzip outperforms the AMD64 version on Opteron machines).

If you compare the AMD64 compiled version of gzip (IE the library) with bzip2 
the difference in CPU time is a lot smaller than it is when comparing the 
i386 versions.

Of course it probably wouldn't be difficult for someone to write some AMD64 
assembler code for gzip or bzip2 to change things.


In regard to the following, I think that the 15 seconds for uncompressed 
operation is the problem not the 1-3 seconds that are added.  Is there any 
chance of optimising the other operations of semodule?  If we could get a 10% 
improvement in the base functionality then "semodule -b" with compression 
would be expected to give the same performance as currently, if we could get 
a 20% improvement then "semodule -i" would give the current performance too.  
Then if you got an AMD64 assembler optimised gzip library the performance 
would be even better.

On Tuesday 09 January 2007 07:34, Karl MacMillan 
<kmacmillan@mentalrootkit.com> wrote:
> Uncompressed
> ------------
>
> [root@localhost modules]# time semodule -b
> /usr/share/selinux/strict/base.pp
>
> real    0m15.849s
> user    0m14.791s
> sys     0m0.930s
>
> [root@localhost nobz-modules]# time semodule -i *.pp
>
> real    0m15.447s
> user    0m14.287s
> sys     0m0.997s
>
> Compressed
> ----------
>
> [root@localhost modules]# time semodule -b /root/base.pp.bz2
>
> real    0m16.117s
> user    0m14.729s
> sys     0m1.022s
>
> [root@localhost modules]# time semodule -i /root/modules/*.bz2
>
> real    0m18.529s
> user    0m17.110s
> sys     0m1.314s

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
