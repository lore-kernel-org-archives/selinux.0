Date: Wed, 13 Feb 2008 22:47:05 +0900
From: Yuichi Nakamura <himainu-ynakam@miomio.jp>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: himainu-ynakam@miomio.jp, selinux@tycho.nsa.gov,
        James Morris
 <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh
 <dwalsh@redhat.com>
Subject: Re: Disabling SELinux by kernel vulnerability
Message-Id: <20080213224705.36a6b84e.himainu-ynakam@miomio.jp>
In-Reply-To: <1202841912.24250.105.camel@moss-spartans.epoch.ncsc.mil>
References: <20080212234339.40551955.himainu-ynakam@miomio.jp>
	<1202841912.24250.105.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On Tue, 12 Feb 2008 13:45:12 -0500
Stephen Smalley  wrote:
> 
> On Tue, 2008-02-12 at 23:43 +0900, Yuichi Nakamura wrote:
> > Hi.
> > 
> > I saw an article on slashdot.
> > http://it.slashdot.org/article.pl?sid=08/02/10/2011257
> > 
> > Local exploit code for Linux kernel exists, 
> > exploit code is also disclosed in http://www.milw0rm.com/exploits/5092.
> > 
> > In the exploit code, only uid is changed to 0.
> > So, SELinux is not affected.
> > 
> > However, SELinux can be disabled by overwriting selinux_enforcing to 0.
> > The address of selinux_enforcing can be seen in /proc/kallsyms, 
> > and I've set the value on the address to 0.
> > 
> > I tried that on Fedora 8, 
> > and I could disable SELinux(set selinux as permissive) from xguest_t
> > domain.
> > 
> > I want to make it more difficult 
> > for attackers to disable SELinux by kernel exploit.
> > 
> > I think not exporting selinux_enforcing(and selinux_disable) to
> > /proc/kallsyms is useful.
> > And /proc/kallsyms is visible from many processes because it is proc_t,
> > assigning /proc/kallsyms label such as proc_ksym_t may be also useful.
> > Are they really useful?
> > Or any idea??
> 
> It would be more useful to just build a kernel with a config that
> disabled the support for permissive mode and runtime disable altogether;
> such config options already exist.  And you can also omit /proc/kallsyms
> altogether via kernel config.
> 
> Labeling /proc/kallsyms with a distinct type is likely feasible, so that
> could be changed in policy.
Many people do not want to recompile kernel,
so this looks more useful.

But I am not sure whether this is really useful or not.
In my environment(Fedora 8), 
the address of selinux_enforcing is the same in every boot.
So I guess the address of selinux_enforcing is the same in the same kernel binary.
The same kernel binary is used in Fedora, 
so attacker see the address of selinux_enforcing in his own Fedora,
and he can use the address in other Fedora machines.
If this is correct, it makes no sense to give different label for /proc/kallsyms.

> There is a patch floating around to turn the LSM hook calls into direct
> SELinux calls so that there is no more security_ops pointer that can be
> overwritten.  But there will still be other critical variables, and
> SELinux can't protect against kernel vulnerabilities in general.
Yes, basically it is correct.
But making attack harder is good thing.

> 
> -- 
> Stephen Smalley
> National Security Agency
> 
> 

Regards,
Yuichi Nakamura

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
