From: Yuichi Nakamura <ynakam@gwu.edu>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com
Message-ID: <fe76f8883168.3168fe76f888@gwu.edu>
Date: Tue, 11 Jul 2006 00:32:34 -0400
MIME-Version: 1.0
Subject: Re: [ANN] SELinux Policy Editor 2.0(seedit 2.0)
In-Reply-To: <1152565409.29240.25.camel@moss-spartans.epoch.ncsc.mil>
References: <20060706152929.dcab61db.ynakam@gwu.edu>
 <1152565409.29240.25.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 10 Jul 2006 17:03:29 -0400
Stephen Smalley  wrote:
> What are your plans for modular policy support?  In the absence of it,
> using your tool/policy on FC5 will disable the ability to use policy
> modules and semanage on FC5, which would be a regression for users and
> may break some packages that are beginning to leverage the semodule and
> semanage functionality.
I have two plans.

1) Full Simplified Policy, no modular policy
This is current version. 
Whole policy is replaced by simplified policy, generated policy is
monolithic.
What I want do is AppArmor-like configuration(security enhanced AppArmor??).
I think I do not need modular policy for that use.
semanage, semodule commands,APIs are not used in current version.

2) Appendable simplified policy, modular policy support
It exists only in my head..
Simplified policy for one domain is converted into .pp  file,
and loadable to existing policy.
It will take time, because I have been spending time for 1).

> Be aware that the old network controls are being superseded by the new
> secmark functionalty, so you will need to rework your tool to generate
> the new allow...:packet { send recv} rules and to generate iptables
> rules for marking the packets appropriately for 2.6.18 and later, unless
> you enable compatibility mode for the old checks.
Thanks for information.
I will support both.

Yuichi Nakamura

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
