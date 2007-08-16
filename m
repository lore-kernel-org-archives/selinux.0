Subject: Re: [PATCH] selinuxfs to globally disable dontaudit rules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <46C4A5DA.7030709@manicmethod.com>
References: <1186696737.20393.10.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0708091525410.30691@us.intercode.com.au>
	 <46BBAE00.7050600@manicmethod.com>  <46BBBDDF.2000307@manicmethod.com>
	 <1187285317.909.36.camel@moss-spartans.epoch.ncsc.mil>
	 <46C48D2B.3010504@manicmethod.com>
	 <1187286476.909.51.camel@moss-spartans.epoch.ncsc.mil>
	 <46C48F01.40101@manicmethod.com>
	 <1187287475.909.69.camel@moss-spartans.epoch.ncsc.mil>
	 <1187291884.909.103.camel@moss-spartans.epoch.ncsc.mil>
	 <46C4A5DA.7030709@manicmethod.com>
Content-Type: text/plain
Date: Thu, 16 Aug 2007 15:33:37 -0400
Message-Id: <1187292817.909.111.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-16 at 15:30 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> >> Some of Dan's policycoreutils patches are trivial or simple bug fixes.
> >> Others are less clear to me.
> >>
> >> I was going to test the libsemanage genhomedircon patches, but haven't
> >> done so yet.  I don't have a problem with them conceptually.  Have you
> >> verified that they yield no change in output under -targeted and -strict
> >> policy?  And run them under valgrind?
> >>     
> >
> > Oh, and what to do about the fact that it won't build anywhere but
> > rawhide (ustr dependency)?
> >
> >   
> We can pull the parts of ustr we need into the library, it is designed 
> to do used that way. This is also trunk though, and we don't guarantee 
> ABI stability in trunk right? The sepolgen dependency of python 2.5 
> causes similar problems AFAIK.

Ok.  I just wanted to test on F7, so I just did a yum
--enablerepo=development install ustr ustr-devel and then everything was
happy.

But the more important issue is that it doesn't work (see other mail).
Pity.  ENOTEST w/o users added to seusers.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
