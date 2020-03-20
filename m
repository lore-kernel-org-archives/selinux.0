Return-Path: <SRS0=Veyl=5F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363DEC4332E
	for <selinux@archiver.kernel.org>; Fri, 20 Mar 2020 13:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AE420739
	for <selinux@archiver.kernel.org>; Fri, 20 Mar 2020 13:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZ0msRJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCTNs2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:48:28 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36362 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgCTNs1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Mar 2020 09:48:27 -0400
Received: by mail-qt1-f194.google.com with SMTP id m33so4910218qtb.3;
        Fri, 20 Mar 2020 06:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c1wuGKT9hZhCpFx5nSB8++iwzrWxM3FhotWrSYNWev8=;
        b=nZ0msRJtsyPaxrEo2VlcllXgfvCKsz1NmENvZwevaDau0Lm+z02wG/5SWdsX7O/F8l
         SrUOir23bD2bXR2keMRPNUBoAz8W1CdZMs0ubbUGF497irDFjfVEuuGBRjpI60SQJL28
         Xl9QpewRbv+3KV2gQ+SfMfUo1Siv8XIwNYWLSJu7hKs4V+YlyjimjGWe7cr1ZyVzsd7e
         v4xII4sY4YN2juRjhXsPC6OBDJCoAcQTHO+CSQCIb/ApiF/Ga6LwU+3QQYGUI3gG+tCW
         swpfmr4d8s2qpSpQ4Bc1Wq90gpB/j50LEnqN5M1uWA7d8Q5oEcRyY5dI8X57u7zX2ggU
         Q8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c1wuGKT9hZhCpFx5nSB8++iwzrWxM3FhotWrSYNWev8=;
        b=cV018tM6YlHN8pZCuWPtizYbBgxWMrvFvbyRtlYfPrcRpmOk/rvE9tg+cmyAGKtjO1
         8OZ+/QCea+dHH0hDFzhcV3JfAQPPi3M6Mg6p5neW4wr1NCtVKXPHLi6f65urZMsjSJwt
         IzdhtJYuxzA/7UeAf3Cpacv3N/6GP4Leq4PcreZst058ZFfBIiCidbaeeYF+iCqQ8EjN
         PjyzhWvWUcKaP97xQsVvQIEBxNZLSedvJq5RaadZZ0fLe2YsuownzuKobmCYjtmODj0q
         PbxXEtHY4RrD480VU6DM3q2hczIQ8/LQEUvxUW9sQK7VYl/e/6llgIF9+5xVUBRmdZ1t
         RC0A==
X-Gm-Message-State: ANhLgQ2up5aog7TcCjP9GUeePB2gHD1qAGRjf/lxjteyMNR8xlLSxLfG
        ZoqeZxbyQZ6bfx/QWf0ysG0=
X-Google-Smtp-Source: ADFU+vsefeut3ZlWj4pOZNdAh3RRplwwfyXmnrYnHEU9RsOvwvNmbsYN0alPaZ2zwT2t3+N4v7P70g==
X-Received: by 2002:ac8:1196:: with SMTP id d22mr8359279qtj.344.1584712105733;
        Fri, 20 Mar 2020 06:48:25 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id y60sm4545045qtd.32.2020.03.20.06.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 06:48:24 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CE3E540F77; Fri, 20 Mar 2020 10:48:22 -0300 (-03)
Date:   Fri, 20 Mar 2020 10:48:22 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v1] perf tool: make Perf tool aware of SELinux access
 control
Message-ID: <20200320134822.GA29833@kernel.org>
References: <b8a0669e-36e4-a0e8-fd35-3dbd890d2170@linux.intel.com>
 <f5ed60b2-4a61-dc72-bfd5-6d0af74bc152@linux.intel.com>
 <20200319190126.GF14841@kernel.org>
 <20200319190504.GG14841@kernel.org>
 <d521a22d-9fa7-1bca-fa60-f23b55953c91@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d521a22d-9fa7-1bca-fa60-f23b55953c91@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Em Fri, Mar 20, 2020 at 03:24:47PM +0300, Alexey Budankov escreveu:
> 
> On 19.03.2020 22:05, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Mar 19, 2020 at 04:01:26PM -0300, Arnaldo Carvalho de Melo escreveu:
> <SNIP>
> > 
> > So I'll try the steps below with/without your patch, and then... what
> > are the steps that a tester needs to go thru to have that refpolicy in?
> > Install some new SELinux package or library, spelling out in detail the
> > steps one needs to go thru helps reviewing/testing,
> 
> Yes, sure. Steps to extend FC31 Targeted policy for testing perf_events access control:

Thanks a lot! This is the level of detail I was talking about, good job!

- Arnaldo
 
> * download selinux-policy srpm [1]: selinux-policy-3.14.4-48.fc31.src.rpm on my FC31
> 
> * install srpm - it creates rpmbuild dir: 
>   [root@host ~]# rpm -Uhv selinux-policy-3.14.4-48.fc31.src.rpm
> 
> * get into rpmbuild/SPECS dir and unpack sources:
>   [root@host ~]# rpmbuild -bp selinux-policy.spec
> 
> * Place patch below at rpmbuild/BUILD/selinux-policy-b86eaaf4dbcf2d51dd4432df7185c0eaf3cbcc02
>   dir and apply it:
>   [root@host ~]# patch -p1 < selinux-policy-perf-events-perfmon.patch
>   patching file policy/flask/access_vectors
>   patching file policy/flask/security_classes
>   [root@host ~]# cat selinux-policy-perf-events-perfmon.patch
> diff -Nura a/policy/flask/access_vectors b/policy/flask/access_vectors
> --- a/policy/flask/access_vectors	2020-02-04 18:19:53.000000000 +0300
> +++ b/policy/flask/access_vectors	2020-02-28 23:37:25.000000000 +0300
> @@ -174,6 +174,7 @@
>  	wake_alarm
>  	block_suspend
>  	audit_read
> +	perfmon
>  }
>  
>  #
> @@ -1099,3 +1100,15 @@
>  
>  class xdp_socket
>  inherits socket
> +
> +class perf_event
> +{
> +	open
> +	cpu
> +	kernel
> +	tracepoint
> +	read
> +	write
> +}
> +
> +
> diff -Nura a/policy/flask/security_classes b/policy/flask/security_classes
> --- a/policy/flask/security_classes	2020-02-04 18:19:53.000000000 +0300
> +++ b/policy/flask/security_classes	2020-02-28 21:35:17.000000000 +0300
> @@ -200,4 +200,6 @@
>  
>  class xdp_socket
>  
> +class perf_event
> +
>  # FLASK
> 
>   [root@host ~]#
> 
>  * get into rpmbuild/SPECS dir and build policy packages from patched sources: 
>    [root@host ~]# rpmbuild --noclean --noprep -ba selinux-policy.spec
>    so you have this:
>    [root@host ~]# ls -alh rpmbuild/RPMS/noarch/
>    total 33M
>    drwxr-xr-x. 2 root root 4.0K Mar 20 12:16 .
>    drwxr-xr-x. 3 root root 4.0K Mar 20 12:16 ..
>    -rw-r--r--. 1 root root 112K Mar 20 12:16 selinux-policy-3.14.4-48.fc31.noarch.rpm
>    -rw-r--r--. 1 root root 1.2M Mar 20 12:17 selinux-policy-devel-3.14.4-48.fc31.noarch.rpm
>    -rw-r--r--. 1 root root 2.3M Mar 20 12:17 selinux-policy-doc-3.14.4-48.fc31.noarch.rpm
>    -rw-r--r--. 1 root root  12M Mar 20 12:17 selinux-policy-minimum-3.14.4-48.fc31.noarch.rpm
>    -rw-r--r--. 1 root root 4.5M Mar 20 12:16 selinux-policy-mls-3.14.4-48.fc31.noarch.rpm
>    -rw-r--r--. 1 root root 111K Mar 20 12:16 selinux-policy-sandbox-3.14.4-48.fc31.noarch.rpm
>    -rw-r--r--. 1 root root  14M Mar 20 12:17 selinux-policy-targeted-3.14.4-48.fc31.noarch.rpm
> 
>  * install SELinux packages from FC repo [2], if not already done so, and 
>    update with the patched rpms above:
>    [root@host ~]# rpm -Uhv rpmbuild/RPMS/noarch/selinux-policy-*
> 
>  * there are also packages providing GUI interface and visualizing SELinux management
>    [root@host ~]# dnf install policycoreutils-gui
> 
>  * enable SELinux Permissive mode for Targeted policy, if not already done so:
>    [root@host ~]# cat /etc/selinux/config
>    # This file controls the state of SELinux on the system.
>    # SELINUX= can take one of these three values:
>    #     enforcing - SELinux security policy is enforced.
>    #     permissive - SELinux prints warnings instead of enforcing.
>    #     disabled - No SELinux policy is loaded.
>    SELINUX=permissive
>    # SELINUXTYPE= can take one of these three values:
>    #     targeted - Targeted processes are protected,
>    #     minimum - Modification of targeted policy. Only selected processes are protected. 
>    #     mls - Multi Level Security protection.
>    SELINUXTYPE=targeted
> 
>  * enable filesystem SELinux labeling at the next reboot
>    [root@host ~]# touch /.autorelabel
> 
>  * reboot machine and it will label filesystems and load Targeted policy into the kernel
> 
>  * login and check that dmesg output doesn't mention that perf_event class is unknown to SELinux subsystem
> 
>  * check that SELinux is enabled and in Permissive mode
>    [root@host ~]# getenforce
>    Permissive
> 
>  * turn SELinux into Enforcing mode:
>    [root@host ~]# setenforce 1
>    [root@host ~]# getenforce
>    Enforcing
> 
>  * Now the machine is enabled to test the patch
> 
> --- If something went wrong ---
> 
> * To turn SELinux into Permissive mode: setenforce 0
> * To fully disable SELinux during kernel boot [3] set kernel command line parameter: selinux=0
> * To remove SELinux labeling from local filesystems: find / -mount -print0 | xargs -0 setfattr -h -x security.selinux
> * To fully turn SELinux off a machine set SELINUX=disabled at /etc/selinux/config file and reboot
> 
> ~Alexey
> 
> [1] https://download-ib01.fedoraproject.org/pub/fedora/linux/updates/31/Everything/SRPMS/Packages/s/selinux-policy-3.14.4-49.fc31.src.rpm
> [2] https://docs.fedoraproject.org/en-US/Fedora/11/html/Security-Enhanced_Linux/sect-Security-Enhanced_Linux-Working_with_SELinux-Enabling_and_Disabling_SELinux.html
> [3] https://danwalsh.livejournal.com/10972.html
> 

-- 

- Arnaldo
