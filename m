Subject: Re: [PATCH 0/2] new and improved range_transition statements
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "'SELinux List'" <SELinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <44CA2919.4010708@trustedcs.com>
References: <44CA2919.4010708@trustedcs.com>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 09:07:16 -0400
Message-Id: <1154351236.26550.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-07-28 at 10:11 -0500, Darrel Goeddel wrote:
> This following patches allow for specification of security classes for
> range_transition statements in the policy.  This is intended to address
> a solution for RedHat Bugzilla #185436.
> 
> http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=185436
> 
> While working on this format change to allow class specification, it was
> noted that the current range_transition handling in the policy toolchain was
> not ideal.  It expanded things at compile time and there was no way to get
> these statements into policy modules.  So, in addition to changing the kernel
> policy format and base policy format in a trivial manner to support the
> desired functionality, I also tried to make the base and module formats more
> robust when handling range_transition rules.

Thanks for taking the time to make this more complete.

>   Hopefully, this format will
> allow for range_transition statements in modules with additional work for
> libsepol in the (near?) future.  I will defer the toolchain gurus on the
> completeness of my approach ;)  This patch set has been tested in the
> following configurations:
> 
> old kernel / all old policy - sure glad that worked
> old kernel / old format modules generating a new format kernel policy that
>   is automatically downgraded at load time
> old kernel / new format modules generating a new format kernel policy that
>   is automatically downgraded at load time
> new kernel / old format modules generating a new format kernel policy
> old kernel / new format modules generating a new format kernel policy
> 

My biggest question is how to handle the format change. There are some
other bug fixes awaiting a module format change (not certain about
kernel format change) and it would be nice to include those in this
format bump. Unfortunately there are not patches for those fixes at the
moment.

Could we branch the code for a month or so for the other changes can be
introduced or is the fix more critical? Do you think that this must go
into RHEL 5 / FC6? Is it possible for the kernel changes to make it in
time for 2.6.18 and if they don't will this be included in RHEL 5 / FC6?

<snip>

> The kernel change is fairly simple.  Sure would be nice to get that into 2.6.18
> since it is for a bug fix...
> 

This makes me think that you time is critical.

> The toolchain changes are a bit more complex, although it sure seems a lot easier
> than it did when I started looking at the code.  I'd appreciate some scrutiny of
> this, especially in the area of future support for range_transition statements in
> policy modules.  I feel that will be very necessary and I hope to ease that path
> with the format change.
> 

I'll try to do a review of this today. Josh - could you take a look as
well?

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
