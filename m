Message-ID: <1343822361.20926.7.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] Spelling correction and formatting fixed.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, William Roberts <w.roberts@sta.samsung.com>
Date: Wed, 01 Aug 2012 07:59:21 -0400
In-Reply-To: <1343784031-23573-1-git-send-email-w.roberts@sta.samsung.com>
References: <1343784031-23573-1-git-send-email-w.roberts@sta.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-07-31 at 18:20 -0700, William Roberts wrote:
> The following commits introduced the issue:
> 75776a76
> 482698a6
> 
> Please apply to SEAndroidManager branch master
> 
> Change-Id: Id6f0ca6da33a001cf86b6ad4e83cbc2e523880c7

Thanks, applied.

> ---
>  jni/exception.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/jni/exception.c b/jni/exception.c
> index 4189fe2..22bc1a7 100644
> --- a/jni/exception.c
> +++ b/jni/exception.c
> @@ -23,10 +23,10 @@ throwNoClassDefError(JNIEnv *env, char *message) {
>  	exClass = (*env)->FindClass( env, className );
>  
>  	if(exClass == NULL) {
> -        ALOGE("Could no throw java/lang/NoClassDefFoundError");
> -        /* If this happens, the program is out of control */
> -        exit(42);
> -    }
> +            ALOGE("Could not throw java/lang/NoClassDefFoundError");
> +            /* If this happens, the program is out of control */
> +            exit(42);
> +        }
>  	return (*env)->ThrowNew( env, exClass, message );
>  }
>  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
