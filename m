Subject: Re: Man page change for semodule -D qualifier
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4703B657.2010205@redhat.com>
References: <4703B657.2010205@redhat.com>
Content-Type: text/plain
Date: Fri, 05 Oct 2007 10:23:33 -0400
Message-Id: <1191594213.891.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-10-03 at 11:33 -0400, Daniel J Walsh wrote:
> plain text document attachment (diff)
> diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/semodule/semodule.8 policycoreutils-2.0.27/semodule/semodule.8
> --- nsapolicycoreutils/semodule/semodule.8	2007-07-16 14:20:42.000000000 -0400
> +++ policycoreutils-2.0.27/semodule/semodule.8	2007-10-03 11:23:39.000000000 -0400
> @@ -23,6 +23,9 @@
>  .B \-B, \-\-build		
>  force a rebuild of policy (also reloads unless -n is used)
>  .TP
> +.B \-D, \-\-disable_dontaudit
> +Temporarily remove dontaudits from policy.  Reverts whenever policy is rebuilt
> +.TP
>  .B \-i,\-\-install=MODULE_PKG
>  install/replace a module package
>  .TP
> @@ -58,6 +61,10 @@
>  $ semodule -i httpd.pp
>  # List non-base modules.
>  $ semodule -l
> +# Turn on all AVC Messages for which SELinux currently is "dontaudit"ing.
> +$ semodule -DB
> +# Turn "dontaudit" rules back on.
> +$ semodule -B
>  # Install or replace all non-base modules in the current directory.
>  $ semodule -i *.pp
>  # Install or replace all modules in the current directory.

Merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
