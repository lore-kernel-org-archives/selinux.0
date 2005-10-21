Subject: Re: MLS context?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <Pine.LNX.4.63.0510210011040.4922@excalibur.intercode>
References: <200510152027.59150.russell@coker.com.au>
	 <200510182133.56086.russell@coker.com.au>
	 <1129731662.2375.164.camel@moss-spartans.epoch.ncsc.mil>
	 <200510211252.18124.russell@coker.com.au>
	 <Pine.LNX.4.63.0510210011040.4922@excalibur.intercode>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 07:22:30 -0400
Message-Id: <1129893750.2375.517.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-10-21 at 00:13 -0400, James Morris wrote:
> On Fri, 21 Oct 2005, Russell Coker wrote:
> 
> > OK, it's a pity that we have the same character used for delimiting fields 
> > within the identity:role:domain part and also for separating the level and 
> > categories (with a possibility of two of them if we have categories in both 
> > the low and high levels).
> 
> It's probably not entirely too late at this stage to change this to 
> something like:
> 
> foo_u:foo_r:foo_t:s0+c0,c1-s1+c0,c1,c2

I'm not sure why we would do that.  Parsing the existing context is
quite straightforward.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
