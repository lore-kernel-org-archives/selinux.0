Subject: Re: [PATCH 4/4] SELinux: validate kernel object classes and
	permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chad Sellers <csellers@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20061106173950.246905998@tresys.com>>
References: <20061106173814.457967976@tresys.com> >
	  <20061106173950.246905998@tresys.com>>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 16:32:50 -0500
Message-Id: <1162848770.3009.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-11-06 at 12:38 -0500, Chad Sellers wrote:
> Index: linux-2.6-discovery/security/selinux/ss/services.c
> ===================================================================
> --- linux-2.6-discovery.orig/security/selinux/ss/services.c
> +++ linux-2.6-discovery/security/selinux/ss/services.c
> @@ -53,6 +57,11 @@
>  extern void selnl_notify_policyload(u32 seqno);
>  unsigned int policydb_loaded_version;
>  
> +/*
> + * This is declared in avc.c
> + */
> +extern const struct selinux_class_perm selinux_class_perm;

(nit) Belongs in avc_ss.h.

What test cases have you applied?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
