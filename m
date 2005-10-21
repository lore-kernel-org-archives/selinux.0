From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: MLS context?
Date: Fri, 21 Oct 2005 12:52:08 +1000
Cc: James Morris <jmorris@namei.org>, SE-Linux <selinux@tycho.nsa.gov>
References: <200510152027.59150.russell@coker.com.au> <200510182133.56086.russell@coker.com.au> <1129731662.2375.164.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1129731662.2375.164.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200510211252.18124.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 20 October 2005 00:21, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2005-10-18 at 21:33 +1000, Russell Coker wrote:
> > However it is two fields, the level/range and the optional categories.
>
> No, this is a common misunderstanding.  The category set is part of the
> _level_.  A level is a sensitivity and a category set.  A range is a low
> level and a high level.  The category set is not separate from the

OK, it's a pity that we have the same character used for delimiting fields 
within the identity:role:domain part and also for separating the level and 
categories (with a possibility of two of them if we have categories in both 
the low and high levels).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
