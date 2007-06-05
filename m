Subject: Re: setfiles -c is failing do to bad checking on options.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46648BAC.8090702@redhat.com>
References: <46648BAC.8090702@redhat.com>
Content-Type: text/plain
Date: Tue, 05 Jun 2007 10:05:45 -0400
Message-Id: <1181052345.25769.31.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-06-04 at 18:01 -0400, Daniel J Walsh wrote:
> plain text document attachment (diff)
> diff --exclude-from=exclude --exclude=sepolgen-1.0.8 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/setfiles/setfiles.c policycoreutils-2.0.19/setfiles/setfiles.c
> --- nsapolicycoreutils/setfiles/setfiles.c	2007-05-18 09:58:33.000000000 -0400
> +++ policycoreutils-2.0.19/setfiles/setfiles.c	2007-06-04 17:42:44.000000000 -0400
> @@ -858,8 +858,6 @@
>  		if (strcmp(input_filename, "-") != 0)
>  			fclose(f);
>  	} else {
> -		if (optind >= argc)
> -			usage(argv[0]);
>  		for (i = optind; i < argc; i++) {
>  			errors |= process_one(argv[i]);
>  		}

Thanks, merged.  Only affects trunk, as this was due to the merger of
setfiles and restorecon into a single program.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
