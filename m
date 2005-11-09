Subject: Re: [refpolicy][PATCH] fix Makefile BASE_MODS and MOD_MODS
	detection
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Johan Fischer <jfischer@cmcrc.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <43715253.2070108@cmcrc.com>
References: <43715253.2070108@cmcrc.com>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 09:22:36 -0500
Message-Id: <1131546156.24234.58.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-09 at 12:35 +1100, Johan Fischer wrote:
> quick patch to fix the modules detection from the modules.conf file...
> 
> before:
> $ awk '/^[[:blank:]]*[[:alpha:]]/{ if ($3 == "module") print $1 }'
> policy/modules.conf
> (no result)
> 
> after:
> $ awk '/^[[:blank:]]*[[:alpha:]]*/{ if ($3 == "module") print $1 }'
> policy/modules.conf
> apm
> apache
> bluetooth

I can't reproduce this behavior.  I don't believe this patch is correct,
as it makes the regex too inspecific.  With the change, the regex
matches all lines, so if the second word in a comment was "module", it
would print out "#", causing errors.
 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
