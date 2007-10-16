Subject: Re: checkmodule and MLS/MCS support
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: russell@coker.com.au, Joshua Brindle <method@manicmethod.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1192536630.8702.12.camel@moss-spartans.epoch.ncsc.mil>
References: <200710142206.29369.russell@coker.com.au>
	 <200710160827.06055.russell@coker.com.au> <4713F56E.50002@manicmethod.com>
	 <200710161039.50870.russell@coker.com.au>
	 <1192536630.8702.12.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 08:43:43 -0400
Message-Id: <1192538623.3645.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-10-16 at 08:10 -0400, Stephen Smalley wrote:
> On Tue, 2007-10-16 at 10:39 +1000, Russell Coker wrote:
> > On Tuesday 16 October 2007 09:19, Joshua Brindle <method@manicmethod.com> 
> > wrote:
> > > > If we have some new users who decide that this is difficult enough that
> > > > selinux=0 is the solution then solving the problem has some real
> > > > benefits. 
> > >
> > > This is pretty extreme, its just a flag.
> > 
> > Yes, it is extreme, but it's what we are up against.
> 
> Do you have a specific suggestion on how to make checkmodule auto-detect
> the right mode that wouldn't cause breakage for existing policies/users?
>   

What about a config file with defaults? For most systems the policy type
never changes.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
