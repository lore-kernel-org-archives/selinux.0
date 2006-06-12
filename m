Subject: Re: [PATCH] policy server API
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christopher Ashworth <cashworth@tresys.com>
Cc: selinux@tycho.nsa.gov, selinux-dev <selinux-dev@tresys.com>
In-Reply-To: <1150144439.3003.18.camel@popeye.columbia.tresys.com>
References: <1148417141.20016.53.camel@popeye.columbia.tresys.com>
	 <1148494501.517.76.camel@popeye.columbia.tresys.com>
	 <1149008008.19716.1.camel@popeye.columbia.tresys.com>
	 <1150143204.8086.159.camel@moss-spartans.epoch.ncsc.mil>
	 <1150144439.3003.18.camel@popeye.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 17:30:26 -0400
Message-Id: <1150147826.13647.6.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-06-12 at 16:33 -0400, Christopher Ashworth wrote:
> A few initial responses...
> 
> 
> On Mon, 2006-06-12 at 16:13 -0400, Stephen Smalley wrote:
> 
> > Do you have a simple test program/util to exercise this code?
> 
> We have been using the policy server to test.  This code is currently
> not publicly available (i.e. the code on Source Forge is out of date).

I'd like something with which to exercise the new code.

> Our thinking here was that the public APIs that already exist are using
> ints.  (e.g. module_list)  We opted for the internal check and
> consistent use of int externally rather than changing the public API,
> but we could certainly go uint32_t throughout if you prefer.

Even if you keep the interface as is, I'm not sure why you cast to
unsigned int for comparison (and when will this be > UINT32_MAX?) and
then later to uint32_t.

> Hmmm.  I thought that this is what you had asked for during our meeting.
> Note that in order to print a warning during the actual invocation of
> the commands, we'd have to either a) touch all the existing database
> functions (even more yucky), or add in the framework for the remote
> database functions (required much more time to implement and test, and
> we wanted to get this out for comment).

No, we just don't want it to crash, i.e. it just needs to propagate
errors properly to the client program, and the client program will
hopefully generate a (admittedly uninformative) error message already.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
