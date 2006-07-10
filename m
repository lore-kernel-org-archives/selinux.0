Subject: Re: [ANN] SELinux Policy Editor 2.0(seedit 2.0)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <ynakam@gwu.edu>
Cc: selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com
In-Reply-To: <20060706152929.dcab61db.ynakam@gwu.edu>
References: <20060706152929.dcab61db.ynakam@gwu.edu>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 17:03:29 -0400
Message-Id: <1152565409.29240.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-07-06 at 15:29 -0400, Yuichi Nakamura wrote:
> Hi.
> 
> I am glad to announce that SELinux Policy Editor 2.0(seedit 2.0) has been released.
> seedit is a tool to make SELinux easy.
> We have renewed the tool. Almost everything have been changed. 
> Policy generator, new GUI are developed, and many others.
> You can download and try it from 
> http://seedit.sourceforge.net 
> Manuals are also provided.
> It supports Fedora Core 5 and Cent OS 4.
> 
> If you have question, please feel free to contact me.

What are your plans for modular policy support?  In the absence of it,
using your tool/policy on FC5 will disable the ability to use policy
modules and semanage on FC5, which would be a regression for users and
may break some packages that are beginning to leverage the semodule and
semanage functionality.

> allownet -protocol tcp -port 80 server.

Be aware that the old network controls are being superseded by the new
secmark functionalty, so you will need to rework your tool to generate
the new allow...:packet { send recv} rules and to generate iptables
rules for marking the packets appropriately for 2.6.18 and later, unless
you enable compatibility mode for the old checks.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
