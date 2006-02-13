Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1DM6MXf016961
	for <selinux@tycho.nsa.gov>; Mon, 13 Feb 2006 17:06:23 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1DM6KHG004416
	for <selinux@tycho.nsa.gov>; Mon, 13 Feb 2006 22:06:20 GMT
Subject: Re: Latest diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43EB8C6D.7060809@redhat.com>
References: <43EB8C6D.7060809@redhat.com>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 17:08:04 -0500
Message-Id: <1139868484.13925.134.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-09 at 13:39 -0500, Daniel J Walsh wrote:
> Update build.conf to match what I believe should be the defaults.

I don't see a compelling need to make MCS default for the upstream
policy.  As for the MONOLITHIC=n, I'd prefer to wait until FC5 comes out
so that there is a final release with loadable modules.

> Add some of Russell's mcs changes

I dropped the mcs file change.  We can't have hard-coded types.

> Prelink needs to execute_no_trans ld_so_t

Fixed to use the already existing interface.

> hal continuously wants more privs...

Do we really want to make the insmod transition unconditional?

> mta/sendmail wants to read postfix config and spools.

I don't understand why this change is needed for mta_send_mail().  It
makes sendmail_exec_t an entrypoint for the domain that wants to send
mail:

@@ -434,6 +434,7 @@
>  
>  	allow $1 sendmail_exec_t:lnk_file r_file_perms;
>  	domain_auto_trans($1, sendmail_exec_t, system_mail_t)
> +	domain_entry_file($1,sendmail_exec_t)
>  
>  	allow $1 system_mail_t:fd use;
>  	allow system_mail_t $1:fd use;


> Spamd wants to talk to razor and ldap.

Moved the ldap part down with the other sysnet stuff.

> auditctl needs to output to  terminals.

I merged this, but I'm curious why this is needed.

Theres also a couple where you added bootloader_getattr_boot_dirs()
where there already was a bootloader_search_boot().  I dropped these
since the latter was upgraded to have search_dir_perms, which has
getattr.

I moved the udev addition down, and found a dontaudit that could be
removed (read_all_domains_state vs dontaudit_list_all_domains_state).

The remainder is merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
