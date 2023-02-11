Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07531C61DA4
	for <selinux@archiver.kernel.org>; Sat, 11 Feb 2023 06:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjBKGYe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 11 Feb 2023 01:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBKGYc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 11 Feb 2023 01:24:32 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430562A6F1
        for <selinux@vger.kernel.org>; Fri, 10 Feb 2023 22:24:31 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id v3so4897255pfn.6
        for <selinux@vger.kernel.org>; Fri, 10 Feb 2023 22:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E/1ebeEWQORWHoU4VwBkSWhy1TTRKv/ogd4q7jpRsps=;
        b=XbPjiv9AoAP3S/b1ANSaEPYq3VRn7CvaaVR+EJhCX+ajgQ9VSFhRQEhkpatVgAXQyU
         EbLXWDwTMiCGmDCRpkcz8fGCDPXPkXdf8T9XO4LRydisS7UMNUpeytKiteBQ0VSJRJFj
         nU3HurKdERdqxfF4n31nd6aB5ouq3j/JVwixz3UGm6M+SFvkBnlOetLMI6YIJ4u5bUF7
         eBaoVQPSHb3gxuH6nDsbBaQS7Yko+Oal/uZ+0D8Xkh8k6XShsDyKTWSTcPbt79CwtqOz
         HDUXlNAzbaIqwv59WkLguYFs/4IJhPqRNk6WuTBVs52x0Fk4IFVqKj0CHkzk1pUp/sGB
         3MkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/1ebeEWQORWHoU4VwBkSWhy1TTRKv/ogd4q7jpRsps=;
        b=VXfXUJhWGhE3BiHl+XW/TS8Ix0EX7T9hQC5OdVTT+fnrdfr9QA8OFuCRGfE9N2Cr91
         7S+9VmIe0MBG5iRkqYIwkoMhTg7Cp5qYcSNBdRAtRJZjQh0m66+8Eim+ABw0dZ/WQlgm
         J6KjeV/bv5N+MYB7uTbAD6N2nI5x/czwGEZ5l5mXDtiKZRGf0sYxLOhAbGB0C9mUbT3J
         LRu6lKGUYQ5gmqTyiT0ZfrRQ6Jmp0POikVgQayRMtPmEYAGovX74rMAPTpDK4bIvZ9u2
         SR31Y87ALPvhFxpHsrXnQJbRYg3kDM9dzKyDjQBI2Nj2YLMquw0u2kShxIjTUfkmQ1Rp
         cMUw==
X-Gm-Message-State: AO0yUKX0R5EXQswg8MMdC6nJX2fUR2IQ8/2Mwjf5Qmigo83nAJ0qaU+S
        08jnT6sIv850DzAUR079hd5s+IDdFyieRSAFCC8=
X-Google-Smtp-Source: AK7set963TcA/HqH5A4iIL5//ee/ImZ9Hi9PSQdVOXrW8Hwo+Y1OKIzVZEnU5obVKP9Z4lEOyxLByA==
X-Received: by 2002:a62:5544:0:b0:5a8:4c18:820b with SMTP id j65-20020a625544000000b005a84c18820bmr8442143pfb.13.1676096670628;
        Fri, 10 Feb 2023 22:24:30 -0800 (PST)
Received: from localhost (99-123-3-233.lightspeed.sntcca.sbcglobal.net. [99.123.3.233])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78c49000000b00581dd94be3asm4204987pfd.61.2023.02.10.22.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 22:24:30 -0800 (PST)
Date:   Fri, 10 Feb 2023 22:24:29 -0800
From:   Jason Zaman <jason@perfinion.com>
To:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH v2 1/2] libselinux: add getpidprevcon
Message-ID: <Y+c0nchNNG5cJTHQ@anduin.perfinion.com>
References: <20230109170912.57887-1-cgzones@googlemail.com>
 <20230201131516.19967-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230201131516.19967-1-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 01, 2023 at 02:15:15PM +0100, Christian Göttsche wrote:
> Add the public interfaces getpidprevcon(3) and getpidprevcon_raw(3), and
> the utility getpidprevcon to gather the previous context before the last
> exec of a given process.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Acked-by: Jason Zaman <jason@perfinion.com>
And applied, thanks!
> ---
> v2:
>    added new interfaces to libselinux.map
> ---
>  libselinux/include/selinux/selinux.h    |  5 ++++
>  libselinux/man/man3/getcon.3            | 10 ++++++++
>  libselinux/man/man3/getpidprevcon.3     |  1 +
>  libselinux/man/man3/getpidprevcon_raw.3 |  1 +
>  libselinux/src/libselinux.map           |  6 +++++
>  libselinux/src/procattr.c               | 18 ++++++++++++++
>  libselinux/utils/.gitignore             |  1 +
>  libselinux/utils/getpidprevcon.c        | 33 +++++++++++++++++++++++++
>  8 files changed, 75 insertions(+)
>  create mode 100644 libselinux/man/man3/getpidprevcon.3
>  create mode 100644 libselinux/man/man3/getpidprevcon_raw.3
>  create mode 100644 libselinux/utils/getpidprevcon.c
> 
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
> index 47af9953..a0948853 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -54,6 +54,11 @@ extern int getpidcon_raw(pid_t pid, char ** con);
>  extern int getprevcon(char ** con);
>  extern int getprevcon_raw(char ** con);
>  
> +/* Get previous context (prior to last exec) of process identified by pid, and
> +   set *con to refer to it.  Caller must free via freecon. */
> +extern int getpidprevcon(pid_t pid, char ** con);
> +extern int getpidprevcon_raw(pid_t pid, char ** con);
> +
>  /* Get exec context, and set *con to refer to it.
>     Sets *con to NULL if no exec context has been set, i.e. using default.
>     If non-NULL, caller must free via freecon. */
> diff --git a/libselinux/man/man3/getcon.3 b/libselinux/man/man3/getcon.3
> index e7e394f3..1b4fe4b7 100644
> --- a/libselinux/man/man3/getcon.3
> +++ b/libselinux/man/man3/getcon.3
> @@ -23,6 +23,10 @@ setcon \- set current security context of a process
>  .sp
>  .BI "int getpidcon_raw(pid_t " pid ", char **" context );
>  .sp
> +.BI "int getpidprevcon(pid_t " pid ", char **" context );
> +.sp
> +.BI "int getpidprevcon_raw(pid_t " pid ", char **" context );
> +.sp
>  .BI "int getpeercon(int " fd ", char **" context );
>  .sp
>  .BI "int getpeercon_raw(int " fd ", char **" context );
> @@ -50,6 +54,11 @@ same as getcon but gets the context before the last exec.
>  returns the process context for the specified PID, which must be free'd with
>  .BR freecon ().
>  
> +.TP
> +.BR getpidprevcon ()
> +returns the process context before the last exec for the specified PID, which must be free'd with
> +.BR freecon ().
> +
>  .TP
>  .BR getpeercon ()
>  retrieves the context of the peer socket, which must be free'd with
> @@ -125,6 +134,7 @@ will fail if it is not allowed by policy.
>  .BR getcon_raw (),
>  .BR getprevcon_raw (),
>  .BR getpidcon_raw (),
> +.BR getpidprevcon_raw (),
>  .BR getpeercon_raw ()
>  and
>  .BR setcon_raw ()
> diff --git a/libselinux/man/man3/getpidprevcon.3 b/libselinux/man/man3/getpidprevcon.3
> new file mode 100644
> index 00000000..1210b5a0
> --- /dev/null
> +++ b/libselinux/man/man3/getpidprevcon.3
> @@ -0,0 +1 @@
> +.so man3/getcon.3
> diff --git a/libselinux/man/man3/getpidprevcon_raw.3 b/libselinux/man/man3/getpidprevcon_raw.3
> new file mode 100644
> index 00000000..1210b5a0
> --- /dev/null
> +++ b/libselinux/man/man3/getpidprevcon_raw.3
> @@ -0,0 +1 @@
> +.so man3/getcon.3
> diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
> index 6e04eb61..5e00f45b 100644
> --- a/libselinux/src/libselinux.map
> +++ b/libselinux/src/libselinux.map
> @@ -246,3 +246,9 @@ LIBSELINUX_3.4 {
>      selinux_restorecon_get_skipped_errors;
>      selinux_restorecon_parallel;
>  } LIBSELINUX_1.0;
> +
> +LIBSELINUX_3.5 {
> +  global:
> +    getpidprevcon;
> +    getpidprevcon_raw;
> +} LIBSELINUX_3.4;
> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> index 6f4cfb82..b7a93a2b 100644
> --- a/libselinux/src/procattr.c
> +++ b/libselinux/src/procattr.c
> @@ -300,3 +300,21 @@ int getpidcon(pid_t pid, char **c)
>  	}
>  	return getprocattrcon(c, pid, "current", NULL);
>  }
> +
> +int getpidprevcon_raw(pid_t pid, char **c)
> +{
> +        if (pid <= 0) {
> +                errno = EINVAL;
> +                return -1;
> +        }
> +        return getprocattrcon_raw(c, pid, "prev", NULL);
> +}
> +
> +int getpidprevcon(pid_t pid, char **c)
> +{
> +        if (pid <= 0) {
> +                errno = EINVAL;
> +                return -1;
> +        }
> +        return getprocattrcon(c, pid, "prev", NULL);
> +}
> diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
> index 3ef34374..b19b94a8 100644
> --- a/libselinux/utils/.gitignore
> +++ b/libselinux/utils/.gitignore
> @@ -9,6 +9,7 @@ getdefaultcon
>  getenforce
>  getfilecon
>  getpidcon
> +getpidprevcon
>  getsebool
>  getseuser
>  matchpathcon
> diff --git a/libselinux/utils/getpidprevcon.c b/libselinux/utils/getpidprevcon.c
> new file mode 100644
> index 00000000..662ad500
> --- /dev/null
> +++ b/libselinux/utils/getpidprevcon.c
> @@ -0,0 +1,33 @@
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <selinux/selinux.h>
> +
> +int main(int argc, char **argv)
> +{
> +	pid_t pid;
> +	char *buf;
> +	int rc;
> +
> +	if (argc != 2) {
> +		fprintf(stderr, "usage:  %s pid\n", argv[0]);
> +		exit(1);
> +	}
> +
> +	if (sscanf(argv[1], "%d", &pid) != 1) {
> +		fprintf(stderr, "%s:  invalid pid %s\n", argv[0], argv[1]);
> +		exit(2);
> +	}
> +
> +	rc = getpidprevcon(pid, &buf);
> +	if (rc < 0) {
> +		fprintf(stderr, "%s:  getpidprevcon() failed:  %s\n", argv[0], strerror(errno));
> +		exit(3);
> +	}
> +
> +	printf("%s\n", buf);
> +	freecon(buf);
> +	exit(EXIT_SUCCESS);
> +}
> -- 
> 2.39.1
> 
