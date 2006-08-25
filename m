Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7PGK3ZC026525
	for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2006 12:20:03 -0400
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7PGJSP8024702
	for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2006 16:19:29 GMT
Date: Fri, 25 Aug 2006 11:29:51 -0500
From: Klaus Weidner <klaus@atsec.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
        redhat-lspp-list <redhat-lspp@redhat.com>
Subject: Re: [PATCH] Add boolean controlling user access to kernel keyring
Message-ID: <20060825162951.GA17482@w-m-p.com>
References: <20060825005512.GA17489@w-m-p.com> <1156515928.3199.14.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1156515928.3199.14.camel@sgc.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Aug 25, 2006 at 10:25:27AM -0400, Christopher J. PeBenito wrote:
> On Thu, 2006-08-24 at 19:55 -0500, Klaus Weidner wrote:
> > This patch adds the boolean "allow_kernel_keyring_user_access" with the
> > goal of implementing an on/off switch for the kernel keyring as far as
> > unprivileged users are concerned. It defaults to true which corresponds
> > to the original behavior without this patch.
> > 
> > The reason for the patch is that the kernel keyring is a fairly complex
> > piece of code that would need testing and documentation if it were
> > available in the evaluated configuration for LSPP (labeled security
> > protection profile) compliant systems, and since it's unlikely to
> > currently be useful on those systems it would greatly simplify things to
> > have a way to disable the feature for unprivileged users at runtime.
> 
> I'm confused, there isn't any unprivileged user access that is disabled
> by this policy, only login programs.

My goal was to conditionalize all "allow" rules for operations on the key
class in the current policy, based on a comment by Stephen Smalley that
this would make the keys inaccessible. I was expecting that the user
processes would inherit the permissions from the login program used to
access the system, but that's apparently not how it works (sorry about
the confusion).

I've now experimented with the keyctl program and it appears that the
current policy already doesn't allow key operations for users.  I'm
getting "permission denied" errors for simple operations such as
"keyctl add user mykey stuff @u" when run as a staff_u user.

If the current refpolicy already disables access to the keyring, and
admins would need to add site-specific policy rules to allow it, I agree
that the patch isn't necessary.

(If there are plans to make the keyring features available to general
userspace programs by default in the refpolicy in the future, I think a
boolean to control it would be useful at that time.)

> Besides that, I really don't think this is needed because what you're
> saying is that you don't trust the key code.  However, the code that
> enforces this policy is the code that you don't trust, so this policy
> wouldn't gain anything.

I don't mistrust it in the sense that I expect it to do anything
malicious. The reason for the disabling switch is for the ongoing Common
Criteria LSPP evaluations -- any IPC mechanism that the system offers to
regular users needs to be fully documented and tested. That's a lot of
work, and it doesn't seem justified in this case since it's not something
that people running an MLS server would currently expect to be available.
If the system always denies access due to the policy, that's easy to
verify and will avoid the need for extensive testing and documentation.

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
