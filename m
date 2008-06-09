Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m59DTMa2005854
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 09:29:22 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m59DTKOD001676
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 13:29:21 GMT
Subject: Re: [refpolicy] /usr/lib32 type
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Martin Orr <martin@martinorr.name>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <484A8A15.9000507@martinorr.name>
References: <484A8A15.9000507@martinorr.name>
Content-Type: text/plain
Date: Mon, 09 Jun 2008 08:54:43 -0400
Message-Id: <1213016083.28428.9.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2008-06-07 at 14:16 +0100, Martin Orr wrote:
> On a 64-bit Debian system, /usr/lib32 is a symlink to
> /emul/ia32-linux/usr/lib.  It should be labelled as lib_t.
> 
> I don't know if the distro_debian is necessary - take it out if you want.

Actually what seems excessive is the (.*/)? in the middle.  Is it really
needed?  Its very broad, and doesn't sound like its needed.

> plain text document attachment (116_usr_lib32)
> Written by: Martin Orr
> 
> Mark /usr/lib32 as type lib_t
> 
> Index: policy/modules/system/libraries.fc
> ===================================================================
> --- policy/modules/system/libraries.fc.orig
> +++ policy/modules/system/libraries.fc
> @@ -110,6 +110,9 @@
>  
>  /usr/(.*/)?lib(/.*)?				gen_context(system_u:object_r:lib_t,s0)
>  /usr/(.*/)?lib64(/.*)?				gen_context(system_u:object_r:lib_t,s0)
> +ifdef(`distro_debian',`
> +	/usr/(.*/)?lib32(/.*)?		-l	gen_context(system_u:object_r:lib_t,s0)
> +')
>  
>  /usr/(.*/)?lib(64)?(/.*)?/ld-[^/]*\.so(\.[^/]*)* gen_context(system_u:object_r:ld_so_t,s0)
>  
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
