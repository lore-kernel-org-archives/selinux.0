Subject: Re: Compatibility between binary policy file and kernel version
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Pravin <shindepravin@gmail.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1175526715.5889.55.camel@moss-spartans.epoch.ncsc.mil>
References: <9d1b82480704020747v1f05b267j874c4bb2d3f1f941@mail.gmail.com>
	 <1175526715.5889.55.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 02 Apr 2007 13:35:36 -0400
Message-Id: <1175535336.5889.72.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-04-02 at 11:11 -0400, Stephen Smalley wrote:
> On Mon, 2007-04-02 at 20:17 +0530, Pravin wrote:
> > Hi,
> > I am facing some problems with compatibility between binary policy
> > file and kernel version.
> > 
> > I have properly working selinux with kernel 2.6.19.
> > But When I use kernel 2.6.18 or 2.6.20, the filesystem labels r not recognized.
> > These kernels shows the default labels like
> > "system_u:object_r:unlabeled_t:s0" but same object shows proper label
> > in kernel 2.6.19.
> 
> Can you give a specific example of such a label?
> 
> > I am using FC6 filesystem with selinux policies compiled by SEEdit.
> > The binary policy file created is "/etc/selinux/seedit/policy/policy.21"
> 
> Are there any other binary policy files in that directory, and is
> your /etc/selinux/config specifying "seeedit" as the SELINUXTYPE?
> 
> > Do I need to re-create compiled binary policies for kernel 2.6.18 ?
> 
> You shouldn't need to do so; load_policy should handle downgrading of
> the binary policy file to the kernel version automatically (as of FC5
> and later).
> 
> > One more doubt that I have is kernel that I am using are not
> > Fedora-core kernel but plain vanilla kernels.
> > Can this create problems, as may be FC kernels are having different
> > binary policy format?
> 
> Shouldn't be different.
> 
> Might be useful to capture strace load_policy output and see what policy
> file(s) it opens.

Also, are there any differences in the kernel configs between those
kernels, particularly for security-related options?
grep SECURITY .config

Do you have SECURITY_SELINUX_POLICYDB_VERSION_MAX enabled or disabled?
(should be disabled on FC5 and later).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
