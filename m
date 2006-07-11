Subject: Re: [ANN] SELinux Policy Editor 2.0(seedit 2.0)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <ynakam@gwu.edu>
Cc: selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com
In-Reply-To: <fe76f8883168.3168fe76f888@gwu.edu>
References: <20060706152929.dcab61db.ynakam@gwu.edu>
	 <1152565409.29240.25.camel@moss-spartans.epoch.ncsc.mil>
	 <fe76f8883168.3168fe76f888@gwu.edu>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 07:48:13 -0400
Message-Id: <1152618493.29240.87.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-07-11 at 00:32 -0400, Yuichi Nakamura wrote:
> On Mon, 10 Jul 2006 17:03:29 -0400
> Stephen Smalley  wrote:
> > What are your plans for modular policy support?  In the absence of it,
> > using your tool/policy on FC5 will disable the ability to use policy
> > modules and semanage on FC5, which would be a regression for users and
> > may break some packages that are beginning to leverage the semodule and
> > semanage functionality.
> I have two plans.
> 
> 1) Full Simplified Policy, no modular policy
> This is current version. 
> Whole policy is replaced by simplified policy, generated policy is
> monolithic.
> What I want do is AppArmor-like configuration(security enhanced AppArmor??).
> I think I do not need modular policy for that use.
> semanage, semodule commands,APIs are not used in current version.

You might not be using semanage and semodule from your own tools, but
users are using them already in FC5 and packages are beginning to use
them as well from scriptlets in order to install per-package policy or
apply other package-specific customizations.  Hence, switching to using
seedit will break such usage.

It shouldn't be difficult for you to just build your simplified policy
as a base policy module using checkmodule and install it via semodule,
in the same manner as the stock FC5 selinux-policy package.  Then users
and packages can continue using semodule and semanage.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
