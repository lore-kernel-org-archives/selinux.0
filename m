Subject: Re: Fixes for checkmodule man page.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <461D2A3D.5040908@redhat.com>
References: <461D2A3D.5040908@redhat.com>
Content-Type: text/plain
Date: Thu, 12 Apr 2007 14:34:37 -0400
Message-Id: <1176402877.3986.175.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-11 at 14:34 -0400, Daniel J Walsh wrote:
> plain text document attachment (diff)
> --- checkpolicy-2.0.1/checkmodule.8~	2007-02-20 09:20:51.000000000 -0500
> +++ checkpolicy-2.0.1/checkmodule.8	2007-04-11 14:32:40.000000000 -0400
> @@ -3,7 +3,7 @@
>  checkmodule \- SELinux policy module compiler
>  .SH SYNOPSIS
>  .B checkmodule
> -.I "[-b] [-d] [-m] [-M] [-o output_file] [input_file]"
> +.I "[-b] [-m] [-M] [-V] [-o output_file] [input_file]"
>  .SH "DESCRIPTION"
>  This manual page describes the
>  .BR checkmodule
> @@ -25,16 +25,15 @@
>  Read an existing binary policy module file rather than a source policy
>  module file.  This option is a development/debugging aid.
>  .TP
> -.B \-d
> -Enter debug mode after loading the policy.  This option is a 
> -development/debugging aid.
> -.TP
>  .B \-m
>  Generate a non-base policy module.
>  .TP
>  .B \-M
>  Enable the MLS/MCS support when checking and compiling the policy module.
>  .TP
> +.B \-V
> + Show policy versions created by this program
> +.TP
>  .B \-o filename
>  Write a binary policy module file to the specified filename.
>  Otherwise, checkmodule will only check the syntax of the module source file

Thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
