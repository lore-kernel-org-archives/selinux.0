Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i98I7IrT024107
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 14:07:18 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i98I7HZ2014523
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 18:07:17 GMT
Subject: Re: More SELinux fixes.
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
In-Reply-To: <4165B9AA.8090803@redhat.com>
References: <4165B9AA.8090803@redhat.com>
Content-Type: text/plain
Message-Id: <1097258770.13326.14.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 08 Oct 2004 14:06:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged, with the exception of the sendmail part.

The sendmail.te part is a revision of Russell's patch from Oct 1st, is
this intentional?  Should these rules be added back?

On Thu, 2004-10-07 at 17:48, Daniel J Walsh wrote:
> Major fixup/cleanup of rpcd for nfs.
> 
> Fixes for ypbind.
> 
> Please eliminate space before "udp" in inetd_child calls.  This will not 
> work correctly with the space.
> 
> Added reserved_port_type attribute for all ports less than 1024.  NIS is 
> causing problems generating avc messages
> on these ports for random name_bind.  Want to be able to tell system to 
> don't audit these.   Might want to add a boolean
> to specifiy whether using NIS or not.
> 
> misc fixes.
> 
> Dan
> 
> ______________________________________________________________________

> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/sendmail.te policy-1.17.29/domains/program/unused/sendmail.te
> --- nsapolicy/domains/program/unused/sendmail.te	2004-10-07 08:02:01.000000000 -0400
> +++ policy-1.17.29/domains/program/unused/sendmail.te	2004-10-07 17:24:28.489441081 -0400
> @@ -99,3 +99,5 @@
>  allow system_mail_t sysctl_kernel_t:file read;
>  dontaudit system_mail_t system_crond_tmp_t:file { append };
>  dontaudit sendmail_t admin_tty_type:chr_file { getattr ioctl };
> +allow sendmail_t initrc_var_run_t:file { getattr read };
> +dontaudit sendmail_t initrc_var_run_t:file { lock write };

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
