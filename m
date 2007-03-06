Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l26GcV5d005682
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 11:38:31 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l26Gdvxq018148
	for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2007 16:39:57 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: ccs attempts to ptrace itself (Probably killall)
Date: Tue, 6 Mar 2007 11:40:19 -0500
Message-ID: <1173199219.917.4.camel@sgc>
In-Reply-To: <200702261713.l1QHDG17030544@localhost.localdomain>
References: <200702261713.l1QHDG17030544@localhost.localdomain>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: <dwalsh@localhost.localdomain>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 12:13 -0500, dwalsh@localhost.localdomain wrote:
> ===File /tmp/patches/nsaserefpolicy_policy_modules_services_ccs.te===
> --- nsaserefpolicy/policy/modules/services/ccs.te	2007-02-19 11:32:53.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/services/ccs.te	2007-02-26 11:02:34.000000000 -0500
> @@ -33,6 +33,7 @@
>  
>  allow ccs_t self:capability { ipc_lock sys_nice sys_resource sys_admin };
>  allow ccs_t self:process { signal setrlimit setsched };
> +dontaudit ccs_t self:process ptrace;
>  allow ccs_t self:fifo_file { read write };
>  allow ccs_t self:unix_stream_socket { connectto create_stream_socket_perms };
>  allow ccs_t self:unix_dgram_socket create_socket_perms;
> ============================================================

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
