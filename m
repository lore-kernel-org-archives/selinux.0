Subject: Re: Latest diffs
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41FA9717.2000609@redhat.com>
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA9717.2000609@redhat.com>
Content-Type: text/plain
Message-Id: <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 01 Feb 2005 13:45:33 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.  Some comments below.

On Fri, 2005-01-28 at 14:48, Daniel J Walsh wrote:
> Changes include
> 
> removal of ifdef automount.te
> autofs is defined outside of automount.te so this is not necassary and 
> was causing targeted policy problems.
> 
> Introduction of texrel_shlib_t which define shlib_t libraries that use 
> text relocation (execmod).  I have only labeled a few of these so far,
> as Red Hat is working to clean these up.  Also using a boolean to turn 
> this feature off allow_execmod
> 
> Changes to make smbmount work
> 
> Fixes for tmpreaper
> 
> Changed postgres helper apps back to default context, running them in 
> postgresql breaks alot.
> 
> Added HelixPlayer file_context
> 
> Modified the Makefile so that it defaults to
> make -> make policy
> 
> make load and make reload no longer install the context files, only make 
> install does.
> 
> This prevents people from overwriting the system context files if they 
> have modified them.
> 

> diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.21.5/macros/program/mozilla_macros.te
> --- nsapolicy/macros/program/mozilla_macros.te	2005-01-28 11:50:50.000000000 -0500
> +++ policy-1.21.5/macros/program/mozilla_macros.te	2005-01-28 14:02:57.000000000 -0500
> @@ -25,7 +25,7 @@
>  allow $1_mozilla_t $1_t:process signull;
>  
>  # Set resource limits and scheduling info.
> -allow $1_mozilla_t self:process { setrlimit setsched };
> +allow $1_mozilla_t self:process { execmem setrlimit setsched };
>  
>  allow $1_mozilla_t usr_t:{ lnk_file file } { getattr read };
>  allow $1_mozilla_t var_lib_t:file { getattr read };
Didn't merge this.

> @@ -127,7 +125,7 @@
>  #
>  allow $1_mozilla_t ld_so_cache_t:file execute;
>  allow $1_mozilla_t locale_t:file execute;
> -dontaudit $1_mozilla_t device_type:{ chr_file file } execute;
> +dontaudit $1_mozilla_t *:{ chr_file file } execute;
>  dontaudit $1_t ld_so_cache_t:file execute;
>  dontaudit $1_t locale_t:file execute;
Can we be a little bit more specific here?

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
