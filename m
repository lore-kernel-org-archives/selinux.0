Date: Fri, 22 Aug 2003 14:06:36 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Brian May <bam@snoopy.apana.org.au>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: 2.6.0-test3
Message-ID: <20030822130636.GA12548@vnl.com>
References: <1061468940.1665.16.camel@kusturica> <200308221204.56942.russell@coker.com.au> <20030822045320.GD15441@snoopy.apana.org.au> <200308221544.31147.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200308221544.31147.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Aug 22, 2003 at 03:44:31PM +1000, Russell Coker wrote:
> On Fri, 22 Aug 2003 14:53, Brian May wrote:
> > On Fri, Aug 22, 2003 at 12:04:56PM +1000, Russell Coker wrote:
> > > However those of us who use different versions of the relevant
> > > applications, or who use alternate programs will have some coding to do. 
> > > Also the process of upgrading from old SE Linux to new SE Linux will be
> > > slightly more difficult than doing a fresh install of SE Linux...  :(
> >
> > What is required to upgrade?
> >
> > I assume the biggest problem will be the file labels?
> 
> Steve tells me that it is not possible to create appropriate XATTR's without 
> having an in-kernel handler for them.  So unless some code is ported from 
> 2.6.0 or the new SE Linux version for 2.4.21 to the old 2.4.21 then it will 
> not be possible to migrate them.
> 
> Only /home should be a problem here, the rest can usually be regenerated from 
> file_contexts anyway.

Hmmm... I'm having problems with your default file. Note that I've got a
2.4.22rc2 kernel. The dependency kills it. I presume this means I have to
drop back to your orig file and do it all manually?

dpkg --install selinux-policy-default_1.1-1_all.deb 
Selecting previously deselected package selinux-policy-default.
dpkg: regarding selinux-policy-default_1.1-1_all.deb containing selinux-policy-default, pre-dependency problem:
 selinux-policy-default pre-depends on selinux (>= 2003081307-2)
dpkg: error processing selinux-policy-default_1.1-1_all.deb (--install):
 pre-dependency problem - not installing selinux-policy-default


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
