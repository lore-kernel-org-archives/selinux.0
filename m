Date: Wed, 27 Aug 2008 09:30:12 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: subrata@linux.vnet.ibm.com, ltp-list <ltp-list@lists.sourceforge.net>,
        Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov
Subject: Re: [patch] selinux:  simplify ioctl checking, SELinux enhancements
 in 2.6.26
In-Reply-To: <1219769432.2721.235.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <alpine.LRH.1.10.0808270928580.11256@tundra.namei.org>
References: <1212672088.2763.46.camel@moss-spartans.epoch.ncsc.mil>  <1212675820.4742.53.camel@subratamodak.linux.ibm.com>  <1212676382.2763.79.camel@moss-spartans.epoch.ncsc.mil>  <1213102248.4791.4.camel@subratamodak.linux.ibm.com>
 <1213108674.30576.130.camel@moss-spartans.epoch.ncsc.mil>  <1219767982.5452.39.camel@subratamodak.linux.ibm.com> <1219769432.2721.235.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 26 Aug 2008, Stephen Smalley wrote:

> > > changes, I'll wait until they hit mainline before updating the test
> > > case, although that will break the test on older kernels.
> > 
> > Would you like to revisit the Reference Policy test cases for SELinux in
> > LTP after the following changes in SELinux in 2.6.26 kernel:
> > 
> > * Create new open permission,
> > * Introduce permissive types,
> > * Remove redundant exports,
> > * Use new audit hooks, remove redundant exports,
> 
> I've added Eric Paris and James Morris to the cc as they are
> co-maintainers of the SELinux kernel code and since Eric implemented the
> new open permission and permissive types support.  One potential
> stumbling block there is that both features require a correspondingly
> updated policy toolchain and base policy configuration in order to
> effectively leverage them.  Any tests would have to be conditional on
> not only the kernel version but also the userland and base policy in
> place.

Added an item to the TODO list at

http://selinuxproject.org/page/Kernel_Development

Also cc'd the SELinux mailing list, where all such emails should go so 
that we have a record of the discussion and so that others can 
participate.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
