Message-ID: <53C91F83.10603@tycho.nsa.gov>
Date: Fri, 18 Jul 2014 09:22:11 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Andy Ruch <adruch2002@yahoo.com>, SELinux ML <selinux@tycho.nsa.gov>,
 Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: why does kernel call setenforce
References: <1405643284.28501.YahooMailNeo@web120705.mail.ne1.yahoo.com>
In-Reply-To: <1405643284.28501.YahooMailNeo@web120705.mail.ne1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/17/2014 08:28 PM, Andy Ruch wrote:
> Hello,
> 
> This is more of an educational question. I'm running a custom policy on RHEL 6.5.
> 
> 
> Why does the kernel call setenforce only after the selinux policy RPM has been updated? Out of the box, I don't see any AVCs. Once I update the policy, I see an AVC for "kernel_t security_t:security setenforce". Is the kernel setting SELinux to permissive or enforcing during those calls? 

By "after the selinux policy RPM has been updated", do you mean after
you have installed your own policy?  Do you mean that this happens when
you install your policy and reload or when you reboot after installing
your policy?

The kernel does not call setenforce; your init program or dracut
initramfs script does that, but it would show up in the kernel_t domain
because it happens before switching or transitioning (depending on your
particular init program and whether it implements the transition via
setcon or re-exec) to the init_t domain.  Since init loads the policy
originally, it starts in the kernel_t domain and can only
switch/transition to the init_t domain after loading policy.

Normally this occurs upon invoking
libselinux/src/load_policy.c:selinux_init_load_policy() from your init
program (I think in RHEL6 a dracut selinux-loadpolicy.sh script was
invoking load_policy -i which calls the same function).  That sets
enforcing mode and loads policy as per your /etc/selinux/config
settings, optionally overridden by any selinux=0 or enforcing=0
parameters on the kernel command-line.

If your kernel was configured with CONFIG_SECURITY_SELINUX_DEVELOP=y
(the default), then it always starts in permissive mode and must be
switched to enforcing mode by init.  If not, then the kernel is always
enforcing and there is no support for permissive mode at all.  However,
regardless, until a policy is first loaded, the kernel will allow any
requested permission.

setenforce permission is checked whenever there is a change to the
current enforcing status, so it can show up for permissive -> enforcing
(although that will be allowed regardless since it will be permissive at
the point of the check) or for enforcing -> permissive (where a denial
would prevent switching).  There should be a separate MAC_STATUS audit
message generated upon setenforce changes that will show you the
enforcing= and old_enforcing= values.

All that said, I'm a bit puzzled by your statement that you are seeing
an avc message at all, as selinux_init_load_policy() calls
security_setenforce() before loading policy, so at that point nothing
would ever be denied since there is no policy yet.
