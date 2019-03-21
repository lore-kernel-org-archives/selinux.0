Return-Path: <SRS0=MVxc=RY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1599DC43381
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 11:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13F0218D8
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 11:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfCULlH convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:41:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfCULlH (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 21 Mar 2019 07:41:07 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6AF3308125E;
        Thu, 21 Mar 2019 11:41:06 +0000 (UTC)
Received: from localhost (ovpn-204-57.brq.redhat.com [10.40.204.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 267581974C;
        Thu, 21 Mar 2019 11:41:05 +0000 (UTC)
References: <20190318210913.2392-1-nicolas.iooss@m4x.org>
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        Laurent Bigonville <bigon@debian.org>
Subject: Re: [PATCH 1/1] restorecond: use /run instead of /var/run
In-reply-to: <20190318210913.2392-1-nicolas.iooss@m4x.org>
Date:   Thu, 21 Mar 2019 12:40:59 +0100
Message-ID: <pjdlg18ihf8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 21 Mar 2019 11:41:07 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On most distributions, /var/run is a symbolic link to /run so 
> using
> /var/run or /run lead to the same result. Nevertheless systemd 
> started
> to warn about using /var/run in a service file, logging entries 
> such as:
>
>     /usr/lib/systemd/system/restorecond.service:8: PIDFile= 
>     references
>     path below legacy directory /var/run/, updating
>     /var/run/restorecond.pid → /run/restorecond.pid; please 
>     update the
>     unit file accordingly.
>
> Switch to /run in order to follow this advice.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

Laurent, is it acceptable for Debian?


> ---
>  restorecond/restorecond.c       | 4 ++--
>  restorecond/restorecond.conf    | 2 +-
>  restorecond/restorecond.init    | 2 +-
>  restorecond/restorecond.service | 2 +-
>  restorecond/utmpwatcher.c       | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/restorecond/restorecond.c 
> b/restorecond/restorecond.c
> index 7b984b298f79..d5f70fc2e2c1 100644
> --- a/restorecond/restorecond.c
> +++ b/restorecond/restorecond.c
> @@ -84,7 +84,7 @@ static void done(void) {
>  	selabel_close(r_opts.hnd);
>  }
>  
> -static const char *pidfile = "/var/run/restorecond.pid";
> +static const char *pidfile = "/run/restorecond.pid";
>  
>  static int write_pid_file(void)
>  {
> @@ -217,7 +217,7 @@ int main(int argc, char **argv)
>  	write_pid_file();
>  
>  	while (watch(master_fd, watch_file) == 0) {
> -	};
> +	}
>  
>  	watch_list_free(master_fd);
>  	close(master_fd);
> diff --git a/restorecond/restorecond.conf 
> b/restorecond/restorecond.conf
> index c64e74758d2f..1a61ece384d7 100644
> --- a/restorecond/restorecond.conf
> +++ b/restorecond/restorecond.conf
> @@ -2,7 +2,7 @@
>  /etc/resolv.conf
>  /etc/samba/secrets.tdb
>  /etc/updatedb.conf
> -/var/run/utmp
> +/run/utmp
>  /var/log/wtmp
>  /root/*
>  /root/.ssh/*
> diff --git a/restorecond/restorecond.init 
> b/restorecond/restorecond.init
> index 775c52b0ce7c..c1cbb247fa91 100644
> --- a/restorecond/restorecond.init
> +++ b/restorecond/restorecond.init
> @@ -9,7 +9,7 @@
>  #
>  # processname: /usr/sbin/restorecond
>  # config: /etc/selinux/restorecond.conf 
> -# pidfile: /var/run/restorecond.pid
> +# pidfile: /run/restorecond.pid
>  #
>  # Return values according to LSB for all commands but status:
>  # 0 - success
> diff --git a/restorecond/restorecond.service 
> b/restorecond/restorecond.service
> index 0511a1c740ac..6bce99d39735 100644
> --- a/restorecond/restorecond.service
> +++ b/restorecond/restorecond.service
> @@ -6,7 +6,7 @@ ConditionSecurity=selinux
>  [Service]
>  Type=forking
>  ExecStart=/usr/sbin/restorecond
> -PIDFile=/var/run/restorecond.pid
> +PIDFile=/run/restorecond.pid
>  
>  [Install]
>  WantedBy=multi-user.target
> diff --git a/restorecond/utmpwatcher.c 
> b/restorecond/utmpwatcher.c
> index 62ad2e98aff3..8660520370de 100644
> --- a/restorecond/utmpwatcher.c
> +++ b/restorecond/utmpwatcher.c
> @@ -49,7 +49,7 @@ unsigned int utmpwatcher_handle(int 
> inotify_fd, int wd)
>  {
>  	int changed = 0;
>  	struct utmp u;
> -	const char *utmp_path = "/var/run/utmp";
> +	const char *utmp_path = "/run/utmp";
>  	struct stringsList *prev_utmp_ptr = utmp_ptr;
>  	if (wd != utmp_wd)
>  		return -1;

