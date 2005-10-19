Subject: Re: MLS context?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: James Morris <jmorris@namei.org>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200510182133.56086.russell@coker.com.au>
References: <200510152027.59150.russell@coker.com.au>
	 <1129553314.26309.13.camel@moss-spartans.epoch.ncsc.mil>
	 <Pine.LNX.4.63.0510171039370.23131@excalibur.intercode>
	 <200510182133.56086.russell@coker.com.au>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 10:21:02 -0400
Message-Id: <1129731662.2375.164.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-18 at 21:33 +1000, Russell Coker wrote:
> However it is two fields, the level/range and the optional categories.

No, this is a common misunderstanding.  The category set is part of the
_level_.  A level is a sensitivity and a category set.  A range is a low
level and a high level.  The category set is not separate from the
level/range; it is part of it (and both levels in the range can have
their own category set, although the high must naturally dominate the
low).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
