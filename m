Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KBqirT003068
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 07:52:44 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7KBq34v001976
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 11:52:03 GMT
Subject: Re: distro.tun
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200408201459.47366.russell@coker.com.au>
References: <200408192333.25072.russell@coker.com.au>
	 <200408201459.47366.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1093002687.16585.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 20 Aug 2004 07:51:27 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-08-20 at 00:59, Russell Coker wrote:
> On Thu, 19 Aug 2004 23:33, Russell Coker <russell@coker.com.au> wrote:
> > The attached patch makes the distro tunable macros define to their same
> > values.  This is useful because distributions have many files named after
> > the distribution and sometimes the file needs a different label to other
> > files in the same directory.
> >
> > Of course we could have names like (r)edhat in file names, but I think that
> > this is the most convenient solution which will cause the least confusion.
> 
> My previous patch was bogus, I should know better than to send a patch 
> untested late at night even if it's trivial.
> 
> It put m4 into an infinite loop.
> 
> Now we can do a macro definition such as the following:
> define(redhat, `redhat')
> 
> But this means that if you pass "redhat" without the `' M4 quotes to a macro 
> it can still go into an infinite loop.  To get this to work with 
> full_user_role(redhat) we need to change most instances of "$1" to "`$1'" in 
> the macros files.
> 
> By using "redhat", "debian", "gentoo", and "suse" as flag macros we are 
> essentially making them reserved words.  I think that the most practical 
> solution to this problem is to use "USING_REDHAT" etc as the flag macros.  
> The chance of someone wanting a user role named USING_REDHAT_r is quite low, 
> while the incidence of people wanting a redhat_r role is much higher.

distro_redhat, distro_debian, distro_gentoo, distro_suse.  No need to
shout.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
