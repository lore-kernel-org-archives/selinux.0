Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1QHRkts012224
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 12:27:46 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1QHT8W2021219
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 17:29:08 GMT
Subject: Re: Spamd policy patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45DB2040.3030209@redhat.com>
References: <45DB2040.3030209@redhat.com>
Content-Type: text/plain
Date: Mon, 26 Feb 2007 12:29:25 -0500
Message-Id: <1172510965.15349.7.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 11:22 -0500, Daniel J Walsh wrote:
> spamassassin has a new directory under /var/lib that it stores files in.
> 
> Communicates with smtp port directly.
> 
> Needs to be able to create ~/.spam* files
> 
> Needs to signal pyzor.

A few things:

> +interface(`spamassassin_manage_lib_files',`

> +interface(`spamassassin_read_lib_files',`

I want to hold off on interface additions until there is a user, so
these should be in a patch with the additions to the caller.

> -corecmd_executable_file(spamc_exec_t)
> +userdom_executable_file(spamc_exec_t)

> -corecmd_executable_file(spamassassin_exec_t)
> +userdom_executable_file(spamassassin_exec_t)

These also are out of place

> @@ -139,6 +148,7 @@
>  
>         tunable_policy(`spamd_enable_home_dirs',`
>                 userdom_home_filetrans_generic_user_home_dir(spamd_t)
> +               userdom_manage_generic_user_home_dirs(spamd_t)
>                 userdom_manage_generic_user_home_content_dirs(spamd_t)
>                 userdom_manage_generic_user_home_content_files(spamd_t)
>                 userdom_manage_generic_user_home_content_symlinks(spamd_t)

Looking at what we have already, plus your addition, it doesn't seem
that it should be managing the user home directory, only ~/.spam*, which
would be home content.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
