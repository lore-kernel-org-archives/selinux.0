Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7GFE9X4001474
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 11:14:09 -0400
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7GFE8Cf004403
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 15:14:08 GMT
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 16 Aug 2007 17:14:07 +0200
From: selinux770@tortenboxer.de
In-Reply-To: <1187269164.909.8.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <20070816151407.290970@gmx.net>
MIME-Version: 1.0
References: <20070810101003.128080@gmx.net>	
 <1186746338.7233.11.camel@moss-spartans.epoch.ncsc.mil>	
 <20070810121259.128050@gmx.net>	
 <1186748504.7233.34.camel@moss-spartans.epoch.ncsc.mil>	
 <20070810130703.128070@gmx.net>	
 <1186751971.7233.70.camel@moss-spartans.epoch.ncsc.mil>	
 <20070810141236.128070@gmx.net>  <20070811180730.308640@gmx.net>	
 <1187009718.26008.19.camel@moss-spartans.epoch.ncsc.mil>	
 <20070815154407.250820@gmx.net>	
 <1187202831.20485.66.camel@moss-spartans.epoch.ncsc.mil>	
 <20070816080523.135750@gmx.net> <1187269164.909.8.camel@moss-spartans.epoch.ncsc.mil>
Subject: Re: wrong magic number (using old sources)
To: Stephen Smalley <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Ok, so libsepol needs to be fixed in the same way the kernel was to
> eliminate unaligned accesses.  Might take a little bit to work through
> all the code.  The size of the buffer has to be large enough for the
> largest next_entry() request.
> 
> As a possible short term work around, you might try this patch instead.
> It just converts the static buffer used within libsepol from unsigned
> char to uint32_t so that the buffer will be aligned (at least for u32).
> That avoids changing all the callers.

This smal patch worked fine for me. The policy is created and loaded (correctly I think :-)).

Thanks a lot for you support.


 
> Index: libsepol/src/private.h
> ===================================================================
> --- libsepol/src/private.h	(revision 2517)
> +++ libsepol/src/private.h	(working copy)
> @@ -5,6 +5,7 @@
>  #include <byteswap.h>
>  #include <endian.h>
>  #include <sepol/policydb/policydb.h>
> +#include <stdint.h>
>  
>  #if __BYTE_ORDER == __LITTLE_ENDIAN
>  #define cpu_to_le16(x) (x)
> @@ -39,7 +40,7 @@
>  /* Reading from a policy "file". */
>  static inline void *next_entry(struct policy_file *fp, size_t bytes)
>  {
> -	static unsigned char buffer[BUFSIZ];
> +	static uint32_t buffer[20];
>  	size_t nread;
>  
>  	if (bytes > sizeof buffer)
> 
> -- 
> Stephen Smalley
> National Security Agency

-- 
GMX FreeMail: 1 GB Postfach, 5 E-Mail-Adressen, 10 Free SMS.
Alle Infos und kostenlose Anmeldung: http://www.gmx.net/de/go/freemail

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
