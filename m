From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [redhat-lspp] pam_namespace is broken from an SELinux perspective.
Date: Fri, 8 Dec 2006 07:47:42 +1100
Cc: Daniel J Walsh <dwalsh@redhat.com>, Linda Knippers <linda.knippers@hp.com>,
        redhat-lspp <redhat-lspp@redhat.com>, selinux@tycho.nsa.gov,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
References: <4576E34D.1030105@hp.com> <1165521862.12263.127.camel@moss-spartans.epoch.ncsc.mil> <1165522316.12263.134.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1165522316.12263.134.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200612080747.47134.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 08 December 2006 07:11, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Note however that the parallel thread on redhat-lspp has proposed using
> Dan's patch (with fixes) for now to get the desired behavior for MLS,
> renaming the current "context" option in namespace.conf to "level" to be
> specific to level instantiation, and later introduce "role" or "context"
> for role-based and/or full context instantiation when/if such support
> exists in the kernel and/or policy.

Having the choice of instantiating by level, role, or by full context seems 
like a useful feature to me.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
