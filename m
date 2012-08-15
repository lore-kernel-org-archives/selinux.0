Message-ID: <1345032834.23766.1.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Support for device specific seapp_context additions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Wed, 15 Aug 2012 08:13:54 -0400
In-Reply-To: <CAFftDdqLJ4KC-4PEQAgJH3VZ-jY7P47L6kCKY7ro5ZiWF=D6vA@mail.gmail.com>
References: 
	<CAFftDdqLJ4KC-4PEQAgJH3VZ-jY7P47L6kCKY7ro5ZiWF=D6vA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-08-14 at 16:15 -0700, William Roberts wrote:
> The patch below enables per device seapp_contexts files.
> 
> I wasn't sure if we should name the file sepolicy.seapp_contexts or
> just seapp_contexts. I chosed against the current trend of sepolicy.*
> and went with seapp_contexts.
> I also ran it through m4 so we could use the include macro definition.
> That seemed to be working ok.

What's an example of how this would be used?  The concern would be that
there is no way presently to ensure that the per-device definitions take
precedence over the base definitions if they ever conflict/duplicate
keys.  

> 
> diff --git a/Android.mk b/Android.mk
> index 119c6ef..5eb3925 100644
> --- a/Android.mk
> +++ b/Android.mk
> @@ -20,6 +20,7 @@ LOCAL_POLICY_FS_USE := $(wildcard $(addsuffix
> sepolicy.fs_use, $(LOCAL_POLICY_DI
>  LOCAL_POLICY_PORT_CONTEXTS := $(wildcard $(addsuffix
> sepolicy.port_contexts, $(LOCAL_POLICY_DIRS)))
>  LOCAL_POLICY_GENFS_CONTEXTS := $(wildcard $(addsuffix
> sepolicy.genfs_contexts, $(LOCAL_POLICY_DIRS)))
>  LOCAL_POLICY_INITIAL_SID_CONTEXTS := $(wildcard $(addsuffix
> sepolicy.initial_sid_contexts, $(LOCAL_POLICY_DIRS)))
> +LOCAL_POLICY_SC := $(wildcard $(addsuffix seapp_contexts,
> $(LOCAL_POLICY_DIRS)))
> 
>  ##################################
>  include $(CLEAR_VARS)
> @@ -60,16 +61,22 @@ $(file_contexts): $(LOCAL_PATH)/file_contexts
> $(LOCAL_POLICY_FC)
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
