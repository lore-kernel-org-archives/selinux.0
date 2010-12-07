Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oB7EwgVB014157
	for <selinux@tycho.nsa.gov>; Tue, 7 Dec 2010 09:58:42 -0500
Received: from smtp107.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id oB7EweZS005167
	for <selinux@tycho.nsa.gov>; Tue, 7 Dec 2010 14:58:40 GMT
Message-ID: <4CFE4B9E.3080408@schaufler-ca.com>
Date: Tue, 07 Dec 2010 06:58:38 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Stephen Smalley <stephen.smalley@gmail.com>
CC: Eric Paris <eparis@redhat.com>, penguin-kernel@i-love.sakura.ne.jp,
        selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org,
        linux-security-module@vger.kernel.org, viro@zeniv.linux.org.uk,
        hch@lst.de, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC PATCH 1/2] fs/vfs/security: pass last path component to
 LSM on inode creation
References: <20101203214518.30001.89859.stgit@paris.rdu.redhat.com>	<4CF9C1A1.7050603@schaufler-ca.com>	<1291498481.4929.77.camel@localhost.localdomain>	<4CFB4191.3090106@schaufler-ca.com> <AANLkTinm_Or+G=BjOU7Tdher-6YnOZXdtb43nGX4N+Et@mail.gmail.com>
In-Reply-To: <AANLkTinm_Or+G=BjOU7Tdher-6YnOZXdtb43nGX4N+Et@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/7/2010 5:43 AM, Stephen Smalley wrote:
> ...
> The only real question for this particular patch IMHO is whether the
> changes being made here are sensible from a vfs and fs point of view.
> Most of your comments seem more directed at whether or not SELinux
> should be extended in this manner (i.e. the 2nd patch), and that's a
> question for the SELinux developers, who have already come to
> consensus on the matter.

I will accept that the changes are acceptable to the SELinux
community and that the proposed behavior is perceived as
beneficial within that community.

One of the concerns that has traditionally been raised when new
LSM hooks or changes to existing hooks are proposed is that of
generality. I can think of a number of ways in which the final
component of a pathname could be used to make access control
decisions, but I would not expect to be using them myself. Who
else might you expect to make use of this LSM "enhancement", or
is this something that only SELinux is ever going to want? Is
the component something the LSM should be providing in general,
or is this the only case in which it makes sense?

I think that the LSM interfaces are awfully inconsistent and
quite arbitrary, and that a little bit of consideration about
the possibility of avoiding taking it even further in that
direction is in order, especially when a change is in a fuzzy
area that has been contentious in the past. I remember the
issues that were raised when the AppArmor folks proposed
LSM interface changes, and while the changes proposed today
lack the problems those changes did the same issues need to
be raised and addressed.

In the end, I don't mind an additional parameter I'll not be
using in Smack if it is generally useful.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
