MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: role dominance
Date: Mon, 7 Jan 2008 13:22:48 -0500
Message-ID: <1199730168.12626.376.camel@gorn>
In-Reply-To: <1199728427.2944.167.camel@moss-spartans.epoch.ncsc.mil>
References: <47824819.9040006@manicmethod.com> <1199728427.2944.167.camel@moss-spartans.epoch.ncsc.mil>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Joshua Brindle" <method@manicmethod.com>,
        "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-01-07 at 12:53 -0500, Stephen Smalley wrote:
> On Mon, 2008-01-07 at 10:41 -0500, Joshua Brindle wrote:
> > While working on policyrep we've found that role dominance is pretty 
> > difficult to implement correctly, and apparently there is some ambiguity 
> > about how it works. The main problem we are running into now is that 
> > converting the role bitmaps of an old module (compatibility) back to a 
> > role dominance statement is very difficult.
> 
> And likely unnecessary.  It isn't required that a conversion yield the
> same source representation, but only that it yield the same end result
> when you ultimately generate a kernel binary policy.  Or are you saying
> that you can't even do the latter?
> 
> > Also it seems like noone has really used role dominance. During 
> > conversations about it here Chris PeBenito suggests that he wants 
> > something like it for refpolicy but a role attribute kind of system may 
> > be much simpler and easier to implement/understand.
> 
> Any language feature that isn't actually being used should probably be
> deprecated.

Last time I tried to use it, the module compiler segfaulted I think.  At
a minimum, I believe it still had ordering issues, making it unusable.
It might see more use if the upcoming experiments on using RBAC for role
separation, rather than derived types, succeeds.  And if it does, the
role attribute might also be useful.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
