Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAGD575a023384
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 08:05:07 -0500
Received: from nz-out-0102.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAGD4OaI028903
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 13:04:24 GMT
Received: by nz-out-0102.google.com with SMTP id z6so268621nzd
        for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 05:05:22 -0800 (PST)
Message-ID: <e294b46e0611160505h5debe173y31642772d7e3a563@mail.gmail.com>
Date: Thu, 16 Nov 2006 13:05:21 +0000
From: "Bradley Chapman" <kakadu@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Fwd: A good place to start?
In-Reply-To: <e294b46e0611131323n4e90be3dg8f5365778c15b3bc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <e294b46e0610300931w25367ca4nc8f914dc4277e8ab@mail.gmail.com>
	 <1162308788.32614.68.camel@moss-spartans.epoch.ncsc.mil>
	 <e294b46e0611131323n4e90be3dg8f5365778c15b3bc@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mr. Smalley,

On 10/31/06, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2006-10-30 at 17:31 +0000, Bradley Chapman wrote:
> > I've just finished installing a new Debian system and decided to put
> > SELinux onto it. After getting the programs installed, the kernel
> > recompiled, the filesystem relabeled and the policy reloaded, I now
> > have a few questions I want to ask about what to do next:
>
> What version of Debian?  What SELinux packages?  Modular/managed policy
> or monolithic policy?

Debian unstable/main, using the mainline SELinux packages and a
monolithic policy.

>
> > - how do I allow domain transitions from user_r to sysadm_r? I keep
> > getting the "user_u:sysadm_r:sysadm_t is not a valid context" error,
> > even though /etc/selinux/refpolicy-strict/users/local.users AND
> > /etc/selinux/refpolicy-strict/src/policy/config/local.users contain
> > the following line:
> >
> > user user roles { user_r sysadm_r };
>
> That isn't what you want to do.  First, user_u is a fallback for
> unprivileged users not otherwise identified in policy - you don't want
> to grant it access to sysadm_r.  Second, for users who should be
> authorized for sysadm_r, you want to make their default role staff_r so
> that they are protected from user_r users.  staff_r should already be
> authorized to transition to sysadm_r.

Ah. Most of the newbie setup stuff I came across seemed to suggest
that this was the way to allow users to transition to sysadm_r from
user_r. I'll make the change and try again.

>
> /etc/selinux/$P/users/local.users is also deprecated as a way of
> defining local users in SELinux.  You should be using seusers (if Debian
> supports that, which is unclear to me - check their pam_selinux to see
> if it calls getseuserbyname() - if not, someone needs to file updated
> SELinux patches for Debian), and using semanage to manage such user
> mappings.

This is something that does indeed confuse me, which is undoubtedly
why you asked after the packages I'm using - there seems to be
multiple ways to configure things within the policy directories under
/etc/selinux.

>
> > - where should I start editing policy files to remove the various avc:
> > denied errors I get when starting the machine? At the moment, there
> > are quite a few - most of which occur in the
> > system_u:system_r:initrc_t context. Should I begin there?
>
> Are they actually denials from direct commands by the rc scripts, or
> from daemons erroneously left in the calling domain due to lack of a
> defined domain or proper domain transition rule?

They seem to be a mixture of both. Is there an easy way of separating
the two so that I can concentrate on one or the other?

>
> > - out of the various GUI-based policy editors out there, which ones
> > are good for SELinux newbies?
>
> SLIDE has the best integration with reference policy.
>
> SEEdit is the most oriented toward ease of use, but I believe that it
> requires you to convert over entirely to its own simplified policy, and
> it makes tradeoffs between quality of protection and ease of use.
>
> Perhaps the better question is which ones do you find helpful?

At the moment, anything which makes it easy to edit the policy would
be helpful. Since I'm starting with the reference policy I guess I
will try SLIDE.

Brad
-- 
CONTROL YOUR TABS: https://addons.mozilla.org/extensions/158

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
