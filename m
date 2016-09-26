Subject: Re: [PATCH 1/2] libsepol, checkpolicy: Update Android.mk
To: Bowgo Tsai <bowgotsai@google.com>, selinux@tycho.nsa.gov
References: <1474573685-124428-1-git-send-email-bowgotsai@google.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f213e1a4-5a68-dff2-b1b6-354410ef7fe1@tycho.nsa.gov>
Date: Mon, 26 Sep 2016 10:24:44 -0400
MIME-Version: 1.0
In-Reply-To: <1474573685-124428-1-git-send-email-bowgotsai@google.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/22/2016 03:48 PM, Bowgo Tsai wrote:
> From: bowgotsai <bowgotsai@google.com>

It looks to me as if the final versions of these patches changed before
they were committed to AOSP, so I'm going to ignore these and assume
you'll submit new ones.  Also, if updating these, shouldn't you also
update the top-level selinux/Android.mk file as well?

I was wondering however if it makes sense to keep these files upstream
or if we should just drop them and let them only exist in the Android tree.

> 
> ---
>  checkpolicy/Android.mk | 11 ++---------
>  libsepol/Android.mk    | 16 ++++++++--------
>  2 files changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/checkpolicy/Android.mk b/checkpolicy/Android.mk
> index 3b7ff8a..ee2f158 100644
> --- a/checkpolicy/Android.mk
> +++ b/checkpolicy/Android.mk
> @@ -18,13 +18,6 @@ common_includes := \
>  	$(LOCAL_PATH)/../libsepol/src/ \
>  
>  ##
> -# "-x c" forces the lex/yacc files to be compiled as c the build system
> -# otherwise forces them to be c++. Need to also add an explicit -std because the
> -# build system will soon default C++ to -std=c++11.
> -yacc_flags := -x c -std=gnu89
> -
> -
> -##
>  # checkpolicy
>  #
>  include $(CLEAR_VARS)
> @@ -32,7 +25,7 @@ include $(CLEAR_VARS)
>  LOCAL_MODULE := checkpolicy
>  LOCAL_MODULE_TAGS := optional
>  LOCAL_C_INCLUDES := $(common_includes) 
> -LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
> +LOCAL_CFLAGS := $(common_cflags)
>  LOCAL_SRC_FILES := $(common_src_files) checkpolicy.c
>  LOCAL_STATIC_LIBRARIES := libsepol
>  LOCAL_YACCFLAGS := -v
> @@ -49,7 +42,7 @@ include $(CLEAR_VARS)
>  LOCAL_MODULE := checkmodule
>  LOCAL_MODULE_TAGS := optional
>  LOCAL_C_INCLUDES := $(common_includes) 
> -LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
> +LOCAL_CFLAGS := $(common_cflags)
>  LOCAL_SRC_FILES := $(common_src_files) checkmodule.c
>  LOCAL_STATIC_LIBRARIES := libsepol
>  LOCAL_YACCFLAGS := -v
> diff --git a/libsepol/Android.mk b/libsepol/Android.mk
> index 6d89f17..e9cfeef 100644
> --- a/libsepol/Android.mk
> +++ b/libsepol/Android.mk
> @@ -81,6 +81,7 @@ common_includes := \
>  # build system will soon default C++ to -std=c++11.
>  yacc_flags := -x c -std=gnu89
>  
> +
>  ##
>  # libsepol.so
>  #
> @@ -88,12 +89,11 @@ include $(CLEAR_VARS)
>  
>  LOCAL_MODULE := libsepol
>  LOCAL_MODULE_TAGS := optional
> -LOCAL_COPY_HEADERS_TO := sepol
> -LOCAL_COPY_HEADERS := include/sepol/handle.h include/sepol/policydb.h cil/include/cil/cil.h
>  LOCAL_C_INCLUDES := $(common_includes) 
> -LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
> +LOCAL_CFLAGS := $(common_cflags)
> +LOCAL_CPPFLAGS := $(yacc_flags)
>  LOCAL_SRC_FILES := $(common_src_files) $(cil_src_files)
> -LOCAL_MODULE_CLASS := SHARED_LIBRARIES
> +LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
>  
>  include $(BUILD_HOST_SHARED_LIBRARY)
>  
> @@ -105,9 +105,10 @@ include $(CLEAR_VARS)
>  LOCAL_MODULE := libsepol
>  LOCAL_MODULE_TAGS := optional
>  LOCAL_C_INCLUDES := $(common_includes) 
> -LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
> +LOCAL_CFLAGS := $(common_cflags)
> +LOCAL_CPPFLAGS := $(yacc_flags)
>  LOCAL_SRC_FILES := $(common_src_files) $(cil_src_files)
> -LOCAL_MODULE_CLASS := STATIC_LIBRARIES
> +LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
>  
>  include $(BUILD_HOST_STATIC_LIBRARY)
>  
> @@ -122,7 +123,6 @@ LOCAL_C_INCLUDES := $(common_includes)
>  LOCAL_CFLAGS := $(common_cflags)
>  LOCAL_SRC_FILES := utils/chkcon.c
>  LOCAL_SHARED_LIBRARIES := libsepol
> -LOCAL_MODULE_CLASS := EXECUTABLES
>  
>  include $(BUILD_HOST_EXECUTABLE)
>  
> @@ -133,6 +133,6 @@ LOCAL_MODULE_TAGES := optional
>  LOCAL_C_INCLUDES := $(common_includes)
>  LOCAL_CFLAGS := $(common_cflags)
>  LOCAL_SRC_FILES := $(common_src_files)
> -LOCAL_MODULE_CLASS := STATIC_LIBRARIES
> +LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
>  
>  include $(BUILD_STATIC_LIBRARY)
> 
