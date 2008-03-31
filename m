Subject: Re: doc typo fix: s/behaviors/behavior/
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <jim@meyering.net>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <87sky98k48.fsf@rho.meyering.net>
References: <87sky98k48.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Mon, 31 Mar 2008 10:22:42 -0400
Message-Id: <1206973362.5610.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 2008-03-29 at 19:23 +0100, Jim Meyering wrote:
> Here's a tiny typo fix:

Thanks, applied.

> 
> Index: libselinux/man/man3/getfscreatecon.3
> ===================================================================
> --- libselinux/man/man3/getfscreatecon.3	(revision 2858)
> +++ libselinux/man/man3/getfscreatecon.3	(working copy)
> @@ -29,7 +29,7 @@
>  
> 
>  Note: Signal handlers that perform an setfscreate must take care to
> -save, reset, and restore the fscreate context to avoid unexpected behaviors.
> +save, reset, and restore the fscreate context to avoid unexpected behavior.
>  .SH "RETURN VALUE"
>  On error -1 is returned.
>  On success 0 is returned.
> Index: libselinux/man/man3/getexeccon.3
> ===================================================================
> --- libselinux/man/man3/getexeccon.3	(revision 2858)
> +++ libselinux/man/man3/getexeccon.3	(working copy)
> @@ -34,7 +34,7 @@
>  
> 
>  Note: Signal handlers that perform an execve must take care to
> -save, reset, and restore the exec context to avoid unexpected behaviors.
> +save, reset, and restore the exec context to avoid unexpected behavior.
>  
> 
>  .B rpm_execcon
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
