Subject: Re: determine least upper bound
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Joe Nall <joe@nall.com>
In-Reply-To: <1271190061.9577.119.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 5 May 2010 10:42:56 -0500
Cc: michel m <michel.mcgregor@gmail.com>, selinux <selinux@tycho.nsa.gov>
Message-Id: <C1F57EA7-A58C-4270-AC00-D44D199B5FE7@nall.com>
References: <m2zbb74313d1004130956i6ce8e53z6f2ec9bbe385c278@mail.gmail.com> <1271190061.9577.119.camel@moss-pluto.epoch.ncsc.mil>
To: Stephen Smalley <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Apr 13, 2010, at 3:21 PM, Stephen Smalley wrote:

> On Tue, 2010-04-13 at 21:26 +0430, michel m wrote:
>> dear all,
>> is there any way to determine least upper bound among security
>> contexts? that is,if I got two secuirty contexts, how can I determine
>> their least upper bound?
> 
> I presume you want the least upper bound of two MLS levels?  It doesn't
> make sense to talk about the least upper bound of two contexts, as the
> values for the other fields of the context (user, role, type) are
> unordered.
> 
> The first question is why do you need to compute a lub or how do you
> intend to use the result.

Sorry for responding so late. We do this to compute a shared level
to communicate with a community of users.

We have application level bit twiddling code to do lub computation.
We then pass the result through mcstrans to see if the resulting
raw context converts. The code isn't really portable outside our
code base and assumes all kinds of things about the structure of
the range portion of the context.

joe

>  We would prefer to abstract the desired
> computation in a way that can be meaningful independent of policy model
> and hide it behind a policy-neutral interface, similar to how we're
> previously dealt with range subset tests by introducing the context
> contains permission check. 
> 
> The logic for computing the lub would be provided as a function in the
> security server, which is the only component that knows the ordering.
> That can be done either as a libsepol interface if you want to compute
> it based on a particular policy file or as a kernel security server
> interface (via selinuxfs), depending on whether you want to always
> compute it against the active kernel policy or against a specific policy
> file.
> 
> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
