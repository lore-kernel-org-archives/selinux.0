From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>
Subject: Re: 2.6.0-test3
Date: Fri, 22 Aug 2003 12:04:56 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <1061468940.1665.16.camel@kusturica> <200308212337.59952.russell@coker.com.au> <20030821172554.GD4481@vnl.com>
In-Reply-To: <20030821172554.GD4481@vnl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308221204.56942.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 22 Aug 2003 03:25, Dale Amon wrote:
> On Thu, Aug 21, 2003 at 11:37:59PM +1000, Russell Coker wrote:
> > This new version of SE Linux does not use the sys_security system call,
> > and therefore any application compiled for the old SE Linux which uses
> > that call (such as avc_toggle) will fail.
>
> Ouch. I'm just in the process of setting up a 2.6.0 test system
> to check out the "mainstream" selinux.
>
> Are there compilable apps on the NSA sight that will work with
> a vanilla 2.6.0-test3?

Yes, they have a complete release with patched applications.

However those of us who use different versions of the relevant applications, 
or who use alternate programs will have some coding to do.  Also the process 
of upgrading from old SE Linux to new SE Linux will be slightly more 
difficult than doing a fresh install of SE Linux...  :(

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
