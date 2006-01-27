Message-ID: <43D98C71.9010601@tresys.com>
Date: Thu, 26 Jan 2006 21:58:57 -0500
From: Chad Sellers <csellers@tresys.com>
MIME-Version: 1.0
To: Chad Hanson <chanson@TrustedCS.com>
CC: SELinux List <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] mls passwd policy
References: <20060126222637.GB13279@dhcp-236.il.tcs-sec.com>
In-Reply-To: <20060126222637.GB13279@dhcp-236.il.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chad Hanson wrote:
> Below is a patch to enable generic user password changing at labels above s0.
> The passwd command only changes the shadow file and does not touch the
> password file. The chfn/chsh commands do not have MLS privileges, so there
> is not a downgrade channel at the current time.

At first look, chage is labeled passwd_exec_t as well, so that's a
bigger downgrade channel. So, if we want to make passwd a trusted
program, we have to split out chage into a separate domain, and make
sure nothing else can get into passwd_t.

That said, as Steve S. pointed out, passwd is still a downgrade channel.
It may be somewhat limited in bandwidth, but it's available to all users
of the system. So, we need to at least document these channels, as Steve
G. pointed out.

Chad Sellers

> 
> -Chad
> 
> 
> diff -Nur serefpolicy-2.2.4/policy/modules/admin/usermanage.te serefpolicy-2.2.4.new/policy/modules/admin/usermanage.te
> --- serefpolicy-2.2.4/policy/modules/admin/usermanage.te	2006-01-23 07:33:45.000000000 -0600
> +++ serefpolicy-2.2.4.new/policy/modules/admin/usermanage.te	2006-01-25 15:54:16.000000000 -0600
> @@ -328,6 +328,9 @@
>  
>  miscfiles_read_localization(passwd_t)
>  
> +mls_file_write_down(passwd_t)
> +mls_file_downgrade(passwd_t)
> +
>  seutil_dontaudit_search_config(passwd_t)
>  
>  userdom_use_unpriv_users_fd(passwd_t)
> 


-- 

----------------------
Chad Sellers
Tresys Technology, LLC
http://www.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
