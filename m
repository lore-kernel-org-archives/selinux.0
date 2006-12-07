Subject: Re: [redhat-lspp] pam_namespace is broken from an SELinux
	perspective.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>, Linda Knippers <linda.knippers@hp.com>,
        redhat-lspp <redhat-lspp@redhat.com>, selinux@tycho.nsa.gov,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <200612080747.47134.russell@coker.com.au>
References: <4576E34D.1030105@hp.com>
	 <1165521862.12263.127.camel@moss-spartans.epoch.ncsc.mil>
	 <1165522316.12263.134.camel@moss-spartans.epoch.ncsc.mil>
	 <200612080747.47134.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 15:47:49 -0500
Message-Id: <1165524469.12263.137.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-12-08 at 07:47 +1100, Russell Coker wrote:
> On Friday 08 December 2006 07:11, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > Note however that the parallel thread on redhat-lspp has proposed using
> > Dan's patch (with fixes) for now to get the desired behavior for MLS,
> > renaming the current "context" option in namespace.conf to "level" to be
> > specific to level instantiation, and later introduce "role" or "context"
> > for role-based and/or full context instantiation when/if such support
> > exists in the kernel and/or policy.
> 
> Having the choice of instantiating by level, role, or by full context seems 
> like a useful feature to me.

Yes, although it somewhat breaks the intended encapsulation of the
context and security_compute_member interface.  At that point the level
returned by security_compute_member becomes rather irrelevant - it would
always be overridden by the logic in pam_namespace itself based on
whether "level" was specified.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
