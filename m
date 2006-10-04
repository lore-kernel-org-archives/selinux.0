Subject: Re: [redhat-lspp] Re: RHEL5 Kernel with labeled networking
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Eric Paris <eparis@parisplace.org>, redhat-lspp@redhat.com,
        vyekkirala@TrustedCS.com, paul.moore@hp.com, selinux@tycho.nsa.gov,
        Linda Knippers <linda.knippers@hp.com>
In-Reply-To: <Pine.LNX.4.64.0610031207260.21081@d.namei>
References: <1159834998.28144.115.camel@localhost.localdomain>
	 <452282F2.1000107@hp.com>
	 <1159890356.28144.136.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0610031207260.21081@d.namei>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 10:09:02 -0400
Message-Id: <1159970943.19176.57.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-03 at 12:08 -0400, James Morris wrote:
> On Tue, 3 Oct 2006, Eric Paris wrote:
> 
> > I think there is going to need to be a policy change that I'm actually
> > talking with Dan about as I type this e-mail.  I think we  need
> > 
> > allow $1 unlabeled_t:packet { flow_in flow_out };
> > 
> > to be added to policy to allow things to work as they did.  I'll post
> > again as soon as we have a policy that appears to let normal networking
> > work in enforcing.
> 
> We need this policy in rawhide before the kernel patches are merged 
> upstream, so we can note the required policy version associated with the 
> patches.  We've do not want to kill Andrew Morton's box again with this 
> kind of thing.

The compat_net support should avoid such breakage, and compat_net is
enabled by default in a default kernel config (just not in the Fedora
kernel config).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
