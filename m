Message-ID: <1345140726.4222.3.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] per device seapp_context support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, William Roberts <w.roberts@sta.samsung.com>
Date: Thu, 16 Aug 2012 14:12:06 -0400
In-Reply-To: <1345139705-1337-1-git-send-email-w.roberts@sta.samsung.com>
References: <1345139705-1337-1-git-send-email-w.roberts@sta.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-08-16 at 10:55 -0700, William Roberts wrote:
> ---
>  Android.mk |   13 ++++++++++---
>  1 files changed, 10 insertions(+), 3 deletions(-)

Thanks, applied.

> diff --git a/Android.mk b/Android.mk
> index 119c6ef..5eb3925 100644
> --- a/Android.mk
> +++ b/Android.mk
> @@ -20,6 +20,7 @@ LOCAL_POLICY_FS_USE := $(wildcard $(addsuffix sepolicy.fs_use, $(LOCAL_POLICY_DI
>  LOCAL_POLICY_PORT_CONTEXTS := $(wildcard $(addsuffix sepolicy.port_contexts, $(LOCAL_POLICY_DIRS)))
>  LOCAL_POLICY_GENFS_CONTEXTS := $(wildcard $(addsuffix sepolicy.genfs_contexts, $(LOCAL_POLICY_DIRS)))
>  LOCAL_POLICY_INITIAL_SID_CONTEXTS := $(wildcard $(addsuffix sepolicy.initial_sid_contexts, $(LOCAL_POLICY_DIRS)))
> +LOCAL_POLICY_SC := $(wildcard $(addsuffix seapp_contexts, $(LOCAL_POLICY_DIRS)))
>  
>  ##################################
>  include $(CLEAR_VARS)
> @@ -60,16 +61,22 @@ $(file_contexts): $(LOCAL_PATH)/file_contexts $(LOCAL_POLICY_FC)
>  	$(hide) m4 -s $^ > $@
>  
>  file_contexts :=
> +
>  ##################################
>  include $(CLEAR_VARS)
> -
>  LOCAL_MODULE := seapp_contexts
> -LOCAL_SRC_FILES := $(LOCAL_MODULE)
>  LOCAL_MODULE_CLASS := ETC
>  LOCAL_MODULE_TAGS := optional
>  LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)
>  
> -include $(BUILD_PREBUILT)
> +include $(BUILD_SYSTEM)/base_rules.mk
> +
> +seapp_contexts := $(intermediates)/seapp_contexts
> +$(seapp_contexts): $(LOCAL_PATH)/seapp_contexts $(LOCAL_POLICY_SC)
> +	@mkdir -p $(dir $@)
> +	$(hide) m4 -s $^ > $@
> +
> +seapp_contexts :=
>  
>  ##################################
>  include $(CLEAR_VARS)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
