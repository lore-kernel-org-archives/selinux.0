Message-ID: <1344603729.10631.28.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: system_app should be signed platform
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Fri, 10 Aug 2012 09:02:09 -0400
In-Reply-To: <CAFftDdqbGbhQc3s9nOqad=jzuj0jQDfY0u66GTg3YMweYaSH2g@mail.gmail.com>
References: 
	<CAFftDdqbGbhQc3s9nOqad=jzuj0jQDfY0u66GTg3YMweYaSH2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-08-09 at 21:08 -0700, William Roberts wrote:
> Shouldn't an app running in system_app domain also be signed as platform?
> 
> Does this break something I missed?
> 
> diff --git a/seapp_contexts b/seapp_contexts
> index 71eca75..6605f6f 100644
> --- a/seapp_contexts
> +++ b/seapp_contexts
> @@ -30,7 +30,7 @@
>  # level may be used to specify a fixed level for any UID.
>  #
>  isSystemServer=true domain=system
> -user=system domain=system_app type=system_data_file
> +user=system seinfo=platform domain=system_app type=system_data_file
>  user=nfc domain=nfc type=nfc_data_file
>  user=radio domain=radio type=radio_data_file
>  user=app_* domain=untrusted_app type=app_data_file levelFromUid=true

Technically you could specify seinfo=platform for all of the platform
UID entries in seapp_contexts, but that should be redundant and
unnecessary, as Android should already ensure that only platform-signed
apps can run with those UIDs.  An omitted seinfo= specifier in
seapp_contexts will match anything, so it does no harm to omit it there.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
