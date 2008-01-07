Subject: Re: role dominance
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <47824819.9040006@manicmethod.com>
References: <47824819.9040006@manicmethod.com>
Content-Type: text/plain
Date: Mon, 07 Jan 2008 12:53:47 -0500
Message-Id: <1199728427.2944.167.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-01-07 at 10:41 -0500, Joshua Brindle wrote:
> While working on policyrep we've found that role dominance is pretty 
> difficult to implement correctly, and apparently there is some ambiguity 
> about how it works. The main problem we are running into now is that 
> converting the role bitmaps of an old module (compatibility) back to a 
> role dominance statement is very difficult.

And likely unnecessary.  It isn't required that a conversion yield the
same source representation, but only that it yield the same end result
when you ultimately generate a kernel binary policy.  Or are you saying
that you can't even do the latter?

> Also it seems like noone has really used role dominance. During 
> conversations about it here Chris PeBenito suggests that he wants 
> something like it for refpolicy but a role attribute kind of system may 
> be much simpler and easier to implement/understand.
> 
> Thoughts?

Any language feature that isn't actually being used should probably be
deprecated.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
