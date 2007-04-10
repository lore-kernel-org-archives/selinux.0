Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3AD5xq3030992
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 09:05:59 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3AD5vgn027854
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 13:05:58 GMT
Subject: Re: kudzu requests sys_ptrace,  I am denying it.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4604349B.9010203@redhat.com>
References: <4604349B.9010203@redhat.com>
Content-Type: text/plain
Date: Tue, 10 Apr 2007 09:06:39 -0400
Message-Id: <1176210399.9840.15.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 16:12 -0400, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/admin/kudzu.te        2007-03-20 23:38:29.000000000 -0400
> +++ serefpolicy-2.5.10/policy/modules/admin/kudzu.te    2007-03-23 10:42:14.000000000 -0400
> @@ -22,7 +22,7 @@
>  #
>  
>  allow kudzu_t self:capability { dac_override sys_admin sys_rawio net_admin sys_tty_config mknod };
> -dontaudit kudzu_t self:capability sys_tty_config;
> +dontaudit kudzu_t self:capability { sys_ptrace sys_tty_config };
>  allow kudzu_t self:process { signal_perms execmem };
>  allow kudzu_t self:fifo_file rw_fifo_file_perms;
>  allow kudzu_t self:unix_stream_socket { connectto create_stream_socket_perms };

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
