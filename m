Message-ID: <53CD0CCB.5080300@tycho.nsa.gov>
Date: Mon, 21 Jul 2014 08:51:23 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: What's a policy capability?
References: <53CA2650.2050608@gmail.com>
In-Reply-To: <53CA2650.2050608@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/19/2014 04:03 AM, dE wrote:
> I came cross this term and couldn't find much reference to it.

A mechanism for telling the kernel that your policy supports some new
feature/capability and therefore it is safe for the kernel to enable the
corresponding check/logic.  Used as a way of supporting new
checks/features in a backward-compatible manner:  old policies will not
have defined the policy capability for the new feature and therefore
will not enable the new check/logic by default, while new policies can
opt into or out of the new check/logic at their discretion.

ls /sys/fs/selinux/policy_capabilities will show the list of policy
capabilities known to your kernel, while cat
/sys/fs/selinux/policy_capabilities/<capability_name> will show whether
that capability was enabled (1) or disabled (0) in the currently loaded
policy.

seinfo --polcap will list enabled policy capabilities in the current or
specified policy.

The set of policy capabilities to be enabled in the policy is declared
in refpolicy/policy/policy_capabilities in the refpolicy source.

The kernel uses the value of specific policy capabilities to decide
whether to enable corresponding checks/logic in security/selinux/hooks.c
in the kernel source; look for tests of selinux_policycap_*.
These variables are set upon policy load by security_load_policycaps(),
loaded from a bitmap read from the policy file.
