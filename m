From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: 2.6.0-test3
Date: Fri, 22 Aug 2003 15:44:31 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <1061468940.1665.16.camel@kusturica> <200308221204.56942.russell@coker.com.au> <20030822045320.GD15441@snoopy.apana.org.au>
In-Reply-To: <20030822045320.GD15441@snoopy.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308221544.31147.russell@coker.com.au>
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

Steve tells me that it is not possible to create appropriate XATTR's without 
having an in-kernel handler for them.  So unless some code is ported from 
2.6.0 or the new SE Linux version for 2.4.21 to the old 2.4.21 then it will 
not be possible to migrate them.

Only /home should be a problem here, the rest can usually be regenerated from 
file_contexts anyway.


Russell Coker


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
