From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: 2.6.0-test3
Date: Fri, 22 Aug 2003 15:04:31 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <1061468940.1665.16.camel@kusturica> <200308221204.56942.russell@coker.com.au> <20030822045320.GD15441@snoopy.apana.org.au>
In-Reply-To: <20030822045320.GD15441@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308221504.31692.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 22 Aug 2003 14:53, Brian May wrote:
> On Fri, Aug 22, 2003 at 12:04:56PM +1000, Russell Coker wrote:
> > However those of us who use different versions of the relevant
> > applications, or who use alternate programs will have some coding to do. 
> > Also the process of upgrading from old SE Linux to new SE Linux will be
> > slightly more difficult than doing a fresh install of SE Linux...  :(
>
> What is required to upgrade?
>
> I assume the biggest problem will be the file labels?

Firstly you have to install a kernel with the new SE Linux support and boot 
it.  Then you have to install the utilities that match the new kernel (after 
which you can't go back).  Then you install the policy, label the file 
systems, and reboot.  Then you do another relabel after the reboot for any 
files that were created by shutdown (presuming that nothing went wrong and 
you have a bootable system that allows you to login).

Much the same as installing SE Linux on a non-SE machine.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
