Return-Path: <SRS0=MVxc=RY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892B3C43381
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 13:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D1020693
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 13:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfCUNiw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:38:52 -0400
Received: from ithil.bigon.be ([163.172.57.153]:43490 "EHLO ithil.bigon.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfCUNiv (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 21 Mar 2019 09:38:51 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Mar 2019 09:38:50 EDT
Received: from localhost (localhost [IPv6:::1])
        by ithil.bigon.be (Postfix) with ESMTP id 00A501FC7C;
        Thu, 21 Mar 2019 14:31:10 +0100 (CET)
Received: from ithil.bigon.be ([IPv6:::1])
        by localhost (ithil.bigon.be [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id LfBzXsLYgaoG; Thu, 21 Mar 2019 14:31:10 +0100 (CET)
Received: from [10.40.1.128] (mail2.vdab.be [193.53.238.200])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bigon@bigon.be)
        by ithil.bigon.be (Postfix) with ESMTPSA;
        Thu, 21 Mar 2019 14:31:10 +0100 (CET)
Subject: Re: [PATCH 1/1] restorecond: use /run instead of /var/run
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
References: <20190318210913.2392-1-nicolas.iooss@m4x.org>
 <pjdlg18ihf8.fsf@redhat.com>
From:   Laurent Bigonville <bigon@debian.org>
Message-ID: <088c5caa-859b-1989-0270-4269baad7478@debian.org>
Date:   Thu, 21 Mar 2019 14:31:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <pjdlg18ihf8.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr-BE
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Le 21/03/19 à 12:40, Petr Lautrbach a écrit :
>
> Nicolas Iooss <nicolas.iooss@m4x.org> writes:
>
>> On most distributions, /var/run is a symbolic link to /run so using
>> /var/run or /run lead to the same result. Nevertheless systemd started
>> to warn about using /var/run in a service file, logging entries such as:
>>
>>     /usr/lib/systemd/system/restorecond.service:8: PIDFile= references
>>     path below legacy directory /var/run/, updating
>>     /var/run/restorecond.pid → /run/restorecond.pid; please update the
>>     unit file accordingly.
>>
>> Switch to /run in order to follow this advice.
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>
> Laurent, is it acceptable for Debian?

Yes it's OK for debian as well.

/run is a symlink to /var/run here too, see point 8 at 
https://www.debian.org/doc/debian-policy/ch-opersys.html#file-system-hierarchy

>
>
>> ---
>>  restorecond/restorecond.c       | 4 ++--
>>  restorecond/restorecond.conf    | 2 +-
>>  restorecond/restorecond.init    | 2 +-
>>  restorecond/restorecond.service | 2 +-
>>  restorecond/utmpwatcher.c       | 2 +-
>>  5 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c
>> index 7b984b298f79..d5f70fc2e2c1 100644
>> --- a/restorecond/restorecond.c
>> +++ b/restorecond/restorecond.c
>> @@ -84,7 +84,7 @@ static void done(void) {
>>      selabel_close(r_opts.hnd);
>>  }
>>
>> -static const char *pidfile = "/var/run/restorecond.pid";
>> +static const char *pidfile = "/run/restorecond.pid";
>>
>>  static int write_pid_file(void)
>>  {
>> @@ -217,7 +217,7 @@ int main(int argc, char **argv)
>>      write_pid_file();
>>
>>      while (watch(master_fd, watch_file) == 0) {
>> -    };
>> +    }
>>
>>      watch_list_free(master_fd);
>>      close(master_fd);
>> diff --git a/restorecond/restorecond.conf b/restorecond/restorecond.conf
>> index c64e74758d2f..1a61ece384d7 100644
>> --- a/restorecond/restorecond.conf
>> +++ b/restorecond/restorecond.conf
>> @@ -2,7 +2,7 @@
>>  /etc/resolv.conf
>>  /etc/samba/secrets.tdb
>>  /etc/updatedb.conf
>> -/var/run/utmp
>> +/run/utmp
>>  /var/log/wtmp
>>  /root/*
>>  /root/.ssh/*
>> diff --git a/restorecond/restorecond.init b/restorecond/restorecond.init
>> index 775c52b0ce7c..c1cbb247fa91 100644
>> --- a/restorecond/restorecond.init
>> +++ b/restorecond/restorecond.init
>> @@ -9,7 +9,7 @@
>>  #
>>  # processname: /usr/sbin/restorecond
>>  # config: /etc/selinux/restorecond.conf -# pidfile: 
>> /var/run/restorecond.pid
>> +# pidfile: /run/restorecond.pid
>>  #
>>  # Return values according to LSB for all commands but status:
>>  # 0 - success
>> diff --git a/restorecond/restorecond.service 
>> b/restorecond/restorecond.service
>> index 0511a1c740ac..6bce99d39735 100644
>> --- a/restorecond/restorecond.service
>> +++ b/restorecond/restorecond.service
>> @@ -6,7 +6,7 @@ ConditionSecurity=selinux
>>  [Service]
>>  Type=forking
>>  ExecStart=/usr/sbin/restorecond
>> -PIDFile=/var/run/restorecond.pid
>> +PIDFile=/run/restorecond.pid
>>
>>  [Install]
>>  WantedBy=multi-user.target
>> diff --git a/restorecond/utmpwatcher.c b/restorecond/utmpwatcher.c
>> index 62ad2e98aff3..8660520370de 100644
>> --- a/restorecond/utmpwatcher.c
>> +++ b/restorecond/utmpwatcher.c
>> @@ -49,7 +49,7 @@ unsigned int utmpwatcher_handle(int inotify_fd, int 
>> wd)
>>  {
>>      int changed = 0;
>>      struct utmp u;
>> -    const char *utmp_path = "/var/run/utmp";
>> +    const char *utmp_path = "/run/utmp";
>>      struct stringsList *prev_utmp_ptr = utmp_ptr;
>>      if (wd != utmp_wd)
>>          return -1;
>
