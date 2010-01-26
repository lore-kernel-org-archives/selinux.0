Subject: Re: Building MLS/MCS policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: refpolicy@oss1.tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <201001261546.o0QFkDMJ023435@vivaldi15.register.it>
References: <201001261546.o0QFkDMJ023435@vivaldi15.register.it>
Content-Type: text/plain
Date: Tue, 26 Jan 2010 12:52:30 -0500
Message-Id: <1264528350.19890.74.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-01-26 at 16:46 +0100, Guido Trentalancia wrote:
> Stephen,
> 
> what I propose is to add a few lines of documentation explaining the process of switching between different policy types (see the two patches below, one for load_policy and the other for the reference policy).

You should technically separate these patches into separate messages,
the first directed to selinux list and the second directed to the
refpolicy list, with your diffs preferably against the respective git
trees for the two different projects (selinux userland vs. refpolicy).
But see below first.

> diff -pru policycoreutils-2.0.77/load_policy/load_policy.8 policycoreutils-2.0.77-new/load_policy/load_policy.8
> --- policycoreutils-2.0.77/load_policy/load_policy.8    2009-11-19 23:16:03.000000000 +0100
> +++ policycoreutils-2.0.77-new/load_policy/load_policy.8        2010-01-26 16:26:11.210178317 +0100
> @@ -12,6 +12,11 @@ load_policy loads the installed policy f
>  The existing policy boolean values are automatically preserved
>  across policy reloads rather than being reset to the default
>  values in the policy file.
> +.PP
> +It should be noted that it is not possible to switch between
> +a non-MLS/MCS policy and a MLS/MCS policy or viceversa at
> +runtime. To switch between such different types of policies
> +change the SELinux configuration and reboot the kernel.
> 
>  .SH "OPTIONS"
>  .TP

- Is the user likely to look at the load_policy man page upon this
failure given that he never directly invokes load_policy but only
indirectly through a chain of make load -> semodule -> load_policy?

- Is the last sentence sufficiently clear to actually help the user
resolve the problem?  I don't think so.  If this were the semodule man
page, I'd suggest that the user pass the -n flag to suppress policy
reload and only update the policy files, thereby enabling them to then
reboot with the new policy, or to pass the -s flag with an alternate
policy store (which is what setting NAME= in the refpolicy build.conf is
doing for you) so that it doesn't try to reload and then
changing /etc/selinux/config.  But this isn't the semodule man page.

> diff -pru refpolicy-2.20091117/README refpolicy-2.20091117-new/README
> --- refpolicy-2.20091117/README 2009-07-14 14:24:46.000000000 +0200
> +++ refpolicy-2.20091117-new/README     2010-01-26 16:39:13.272185609 +0100
> @@ -267,3 +267,14 @@ refresh                    Attempts to reinsert all modul
>  xml                    Build a policy.xml from the XML included with the
>                         base policy headers and any XML in the modules in
>                         the current directory.
> +
> +5) Switching between different types of policies (e.g. from non-MLS to MLS)
> +
> +In order to switch from a non-MLS/non-MCS policy to a MLS or MCS policy
> +(and viceversa), make sure to change in build.conf not only the TYPE
> +parameter between the two policies but also the NAME parameter (just name
> +the new policy differently from the previous one). Also, after building the
> +new policy, in order to load it for the first time (and eventually install
> +custom modules), it might be necessary to reboot the kernel in permissive
> +mode (after having changed the SELinux configuration file to select the
> +new policy).

This is up to Chris, but I'd tend to put this information with the
description of TYPE under the build.conf description rather than as a
separate item.  And it could be clearer.  Note that if you leave NAME=
blank then it inherits from TYPE, and thus a mcs or mls policy
automatically gets a distinct name.

Alternatively to spending time on documenting the current limitation, it
might be more interesting to try removing the restriction from the
SELinux kernel code and investigating what needs to be done within the
kernel to enable it to be done safely.  Primarily this would mean:
- pushing the selinux_mls_enabled flag inside the policydb so that it
could be per-policydb (this is already the case in libsepol),
- in the non-MLS to MLS case, ensuring that the MLS fields of the
context for all existing entries in the sidtab are filled in with a
suitable default value, likely taken from one of the initial SIDs,
- in the MLS to non-MLS case, freeing any storage used by the MLS fields
in the context for all existing entries in the sidtab.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
