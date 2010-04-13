Subject: Re: determine least upper bound
From: Stephen Smalley <sds@tycho.nsa.gov>
To: michel m <michel.mcgregor@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <m2zbb74313d1004130956i6ce8e53z6f2ec9bbe385c278@mail.gmail.com>
References: <m2zbb74313d1004130956i6ce8e53z6f2ec9bbe385c278@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 13 Apr 2010 16:21:01 -0400
Message-Id: <1271190061.9577.119.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-04-13 at 21:26 +0430, michel m wrote:
> dear all,
> is there any way to determine least upper bound among security
> contexts? that is,if I got two secuirty contexts, how can I determine
> their least upper bound?

I presume you want the least upper bound of two MLS levels?  It doesn't
make sense to talk about the least upper bound of two contexts, as the
values for the other fields of the context (user, role, type) are
unordered.

The first question is why do you need to compute a lub or how do you
intend to use the result.  We would prefer to abstract the desired
computation in a way that can be meaningful independent of policy model
and hide it behind a policy-neutral interface, similar to how we're
previously dealt with range subset tests by introducing the context
contains permission check. 

The logic for computing the lub would be provided as a function in the
security server, which is the only component that knows the ordering.
That can be done either as a libsepol interface if you want to compute
it based on a particular policy file or as a kernel security server
interface (via selinuxfs), depending on whether you want to always
compute it against the active kernel policy or against a specific policy
file.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
