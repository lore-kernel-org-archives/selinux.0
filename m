Subject: Re: SELinux on Android
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bhargava Shastry <bshas3@gmail.com>
Cc: russell@coker.com.au, SELinux@tycho.nsa.gov
In-Reply-To: <CAGGozWTpWRiNBc7zVNAL4TntSc=30RqpE2XXuTkfEqpN-UJsqA@mail.gmail.com>
References: 
	 <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com>
	 <1321900374.9385.39.camel@moss-pluto>
	 <CAGGozWRoHG9TW0xEy7c3ji1ksfXeHt_Nb+53=j3hpZSp0fWmDw@mail.gmail.com>
	 <201111230903.27267.russell@coker.com.au>
	 <CAGGozWTpWRiNBc7zVNAL4TntSc=30RqpE2XXuTkfEqpN-UJsqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 01 Dec 2011 14:04:42 -0500
Message-ID: <1322766282.7212.10.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-12-01 at 19:42 +0100, Bhargava Shastry wrote:
> Hi All,
> 
> I was wondering if there is way to do automatic policy updates for
> SELinux at runtime. On similar lines, is there a means by which
> SELinux queries a "supervisor" in the userspace in case a policy
> violation is detected in enforcing mode. For example, lets say
> SELinux's initial policy (loaded during device boot) does not permit
> program X to read file Y. If SELinux is enforcing such a policy, X is
> not allowed to read Y (obviously). In this scenario, is there a way to
> allow SELinux ask a user-space decision maker program if Y could
> indeed be read by X? Maybe the user-space decision maker deems the
> file safe to be read.
> 
> Apologies if I am being a little vague here. To put my question in
> perspective, I am working on evaluating SELinux on Android and it is
> sometimes useful for the Android middleware (sitting on top of the
> Linux kernel) to interfere in kernel-level MAC e.g. SELinux. So, it
> would be useful to know if a communication channel between SELinux and
> the middleware could be established esp. wrt policy updates.

SELinux does not support upcalls to userspace for decision making (and
doing so would be impossible for a number of the hooks, which are called
under various conditions and cannot always block).

It is however possible for a userspace agent to exercise various degrees
of control over SELinux, e.g. by loading new policy, by changing policy
booleans, or by specifying how to label particular processes and
objects.  But that would occur in response to some event visible to the
userspace agent, not in response to an upcall from SELinux in the middle
of processing some system call.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
