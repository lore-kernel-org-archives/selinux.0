From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] SELinux: use SECINITSID_NETMSG instead of SECINITSID_UNLABELED for NetLabel
Date: Mon, 23 Apr 2007 16:40:10 -0400
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Joshua Brindle <method@manicmethod.com>, dwalsh@redhat.com
References: <20070314025023.115872483@hp.com> <200704231456.30910.paul.moore@hp.com> <1177360618.24282.107.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1177360618.24282.107.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200704231640.10821.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 23 April 2007 4:36:58 pm Stephen Smalley wrote:
> On Mon, 2007-04-23 at 14:56 -0400, Paul Moore wrote:
> > The next logical questions are first, does anyone have a good idea on how
> > to solve these compatibility breaks?  Second, assuming there is not an
> > easy fix, do people consider the issues above to be deal breakers?
>
> It sounds as though it has a very limited scope (MLS & NetLabel), and
> the kernel/policy mismatch is less likely in that environment (as
> changing the kernel or the policy would require re-evaluation, and in
> particular, the policy change modifies the MLS constraints).  So
> possibly just a matter of documenting the dependency between the kernel
> version and the policy version for MLS.

Okay, that sounds good to me.

Thanks.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
