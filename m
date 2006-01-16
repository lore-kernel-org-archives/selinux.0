Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0GJ4eXf024035
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2006 14:04:40 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0GJ3Wlk019930
	for <selinux@tycho.nsa.gov>; Mon, 16 Jan 2006 19:03:33 GMT
Subject: Re: [PATCH] sereference: Makefile changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Spencer Shimko <sshimko@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200601121423.31372.sshimko@tresys.com>
References: <200601121423.31372.sshimko@tresys.com>
Content-Type: text/plain
Date: Mon, 16 Jan 2006 14:06:05 -0500
Message-Id: <1137438365.29815.246.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-01-12 at 14:23 -0500, Spencer Shimko wrote:
> The attached patch makes it possible to change the on-off-module state of 
> policy from the command line at build time.  Rather then maintaining 
> separate modules.conf for various similar builds, one can maintain a 
> common modules.conf and tweak it when running make.

> diff -urN refpolicy-old/Makefile refpolicy-new/Makefile
> --- refpolicy-old/Makefile      2006-01-12 11:07:59.000000000 -0500
> +++ refpolicy-new/Makefile      2006-01-12 14:10:03.000000000 -0500
> @@ -165,9 +165,17 @@
>  # modules.conf setting for unused module
>  MODUNUSED := off
>  
> +# test for additional module configuration information from command line and check for confusing input
> +MOD_TEST = $(foreach var, $(APPS_OFF), $(findstring $(var), $(APPS_ON) $(APPS_MODS)))
> +MOD_TEST += $(foreach var, $(APPS_MODS), $(findstring $(var), $(APPS_ON)))
> +ifneq ($(strip $(MOD_TEST)),)
> +        $(error Applications must be on, module, or off, and not in more than one list! $(strip $(MOD_TEST)) found in multiple lists!)
> +endif

I believe using filter instead of foreach+findstring will simplify the
above part, since it returns the words in the text (APPS_ON and
APPS_MODS) that match any of the words in the pattern (APPS_OFF).

>  # extract settings from modules.conf
> -BASE_MODS := $(addsuffix .te,$(shell awk '/^[[:blank:]]*[[:alpha:]]/{ if ($$3 == "$(MODBASE)") print $$1 }' $(MOD_CONF) 2> /dev/null))
> -MOD_MODS := $(addsuffix .te,$(shell awk '/^[[:blank:]]*[[:alpha:]]/{ if ($$3 == "$(MODMOD)") print $$1 }' $(MOD_CONF) 2> /dev/null))
> +# strip out all additional module configuration information from command line, then add back in to avoid dupes
> +BASE_MODS := $(strip $(filter-out $(strip $(APPS_OFF) $(APPS_MODS) $(APPS_ON)), $(addsuffix .te,$(shell awk '/^[[:blank:]]*[[:alpha:]]/{ if ($$3 == "$(MODBASE)") print $$1 }' $(MOD_CONF) 2> /dev/null)))) $(addsuffix .te,$(APPS_ON))
> +MOD_MODS := $(strip $(addsuffix .te, $(filter-out $(strip $(APPS_OFF) $(APPS_MODS) $(APPS_ON)), $(shell awk '/^[[:blank:]]*[[:alpha:]]/{ if ($$3 == "$(MODMOD)") print $$1 }' $(MOD_CONF) 2> /dev/null)))) $(addsuffix .te,$(APPS_MODS))
>  OFF_MODS := $(addsuffix .te,$(shell awk '/^[[:blank:]]*[[:alpha:]]/{ if ($$3 == "$(MODUNUSED)") print $$1 }' $(MOD_CONF) 2> /dev/null))
> 
Using sort might simplify this, as it removes duplicates, in addition to
sorting the list.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
