Subject: Re: [PATCH] policy server API
From: Christopher Ashworth <cashworth@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, selinux-dev <selinux-dev@tresys.com>
In-Reply-To: <1150143204.8086.159.camel@moss-spartans.epoch.ncsc.mil>
References: <1148417141.20016.53.camel@popeye.columbia.tresys.com>
	 <1148494501.517.76.camel@popeye.columbia.tresys.com>
	 <1149008008.19716.1.camel@popeye.columbia.tresys.com>
	 <1150143204.8086.159.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 16:33:59 -0400
Message-Id: <1150144439.3003.18.camel@popeye.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A few initial responses...


On Mon, 2006-06-12 at 16:13 -0400, Stephen Smalley wrote:

> Do you have a simple test program/util to exercise this code?

We have been using the policy server to test.  This code is currently
not publicly available (i.e. the code on Source Forge is out of date).

> Why do we need to export the sepol handle to the caller?

[snip]

> Should this truly be an int or should it be a uint32_t?

These I defer to Josh.

> 
> Can we just be uint32_t throughout and avoid unnecessary tests and
> casts?

Our thinking here was that the public APIs that already exist are using
ints.  (e.g. module_list)  We opted for the internal check and
consistent use of int externally rather than changing the public API,
but we could certainly go uint32_t throughout if you prefer.

> Yuck.  User-visible warning during connect?

Hmmm.  I thought that this is what you had asked for during our meeting.
Note that in order to print a warning during the actual invocation of
the commands, we'd have to either a) touch all the existing database
functions (even more yucky), or add in the framework for the remote
database functions (required much more time to implement and test, and
we wanted to get this out for comment).

Chris


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
