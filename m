Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2LIwsTN029713
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2007 14:58:54 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2LIwpRY018247
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2007 18:58:51 GMT
Subject: Re: ricci_modstorage needs to transition to lvm and dontaudit
	ptrace
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45F02404.4060407@redhat.com>
References: <45F02404.4060407@redhat.com>
Content-Type: text/plain
Date: Wed, 21 Mar 2007 18:59:10 +0000
Message-Id: <1174503551.2750.0.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-08 at 09:56 -0500, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/services/ricci.te     2007-03-06 09:53:20.000000000 -0500
> +++ serefpolicy-2.5.8/policy/modules/services/ricci.te  2007-03-08 09:16:00.000000000 -0500
> @@ -449,6 +448,7 @@
>  #
>  
>  allow ricci_modstorage_t self:process { setsched signal };
> +dontaudit ricci_modstorage_t self:process ptrace;
>  allow ricci_modstorage_t self:capability { mknod sys_nice };
>  allow ricci_modstorage_t self:fifo_file rw_fifo_file_perms;
>  allow ricci_modstorage_t self:unix_dgram_socket create_socket_perms;
> @@ -498,6 +498,10 @@
>  ')
>  
>  optional_policy(`
> +       lvm_domtrans(ricci_modstorage_t)
> +')
> +
> +optional_policy(`
>         nscd_socket_use(ricci_modstorage_t)
>  ') 

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
