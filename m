Message-ID: <1342101157.8057.29.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Fwd: [PATCH] Add build property ro.build.selinux when building
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Thu, 12 Jul 2012 09:52:37 -0400
In-Reply-To: <CAFftDdoiGsZpkLz-Vz3cD5PAUQhjdEra0qn4GKT2S-xGxcgFMw@mail.gmail.com>
References: <1341955378-20471-2-git-send-email-bill.c.roberts@gmail.com>
	 <CAFftDdoiGsZpkLz-Vz3cD5PAUQhjdEra0qn4GKT2S-xGxcgFMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-07-10 at 14:24 -0700, William Roberts wrote:
> When building with HAVE_SELINUX:=true, this build property will be
> added to the systems properties.
> ---
>  core/main.mk |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/core/main.mk b/core/main.mk
> index 3d8d6e0..e527160 100644
> --- a/core/main.mk
> +++ b/core/main.mk
> @@ -218,6 +218,10 @@ ifneq ($(filter sdk win_sdk sdk_addon,
> $(MAKECMDGOALS)),)
>  is_sdk_build := true
>  endif
> 
> +## have selinux ##
> +ifeq ($(HAVE_SELINUX),true)
> +ADDITIONAL_BUILD_PROPERTIES += ro.build.selinux=1
> +endif # HAVE_SELINUX
> 
>  ## user/userdebug ##

Already merged on master (and thus to seandroid). Not sure if you wanted
it on 4.0.4 or 4.1.1.  Subject line needs to identify target project and
branch(es).


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
