Return-Path: <SRS0=MVxc=RY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91418C43381
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 12:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B78B218A5
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 12:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZOsJgM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfCUMIz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:08:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41287 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbfCUMIz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Mar 2019 08:08:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id a25so4766459edc.8
        for <selinux@vger.kernel.org>; Thu, 21 Mar 2019 05:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=BQF3GiDU1SADW+epVlgBSaRDPO6KeQmd0VjMf+3C8CM=;
        b=YZOsJgM/6iVATd5QGg+UxBCmppzvd5O1LaB3KKnvdIlV3B3rZCJLTBM06UL/zKnIsR
         7jaJDtk5ItwZP+3nCCOzIcj+B67jsnveACvSUYNg2W5VrDRNzb+3tENnYUMwMVE9Waps
         UkVsZJ3tCTxF4DCYZUAqUSLg7wzfZ9bdWyBbcaWOFkWyjQnCp6KvR+Pp2aNB/oKMj9OV
         2gsM84E9dbak8OOL9orz39CNs43X4MstvUPuC5GiI38KCv5HfxANIsJK9zH6wSNPdrdW
         HoVSGC4aBa6rJGcjaFkqaQBrzR1/asFkhJ6+5UIiZuBp5IjPmuM/WE7IgOiULHDHQn3o
         CCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=BQF3GiDU1SADW+epVlgBSaRDPO6KeQmd0VjMf+3C8CM=;
        b=Rem+ZEoOrGlR2qrhhq1x9lTSkz8NopLMtFhvddvuKlyxKe5heR+3PalbThSvWTEh+O
         5LDzm4KEYJW4hXkJn+Mf+ob1SrMw4jsSCJAQrChZQ/q2MQFnU5L0wGlg6VdKgFIhToxn
         u3WpG8Q8Fw/d13R93XVrVmoyXUQgyFU3s7x7KppGJwEemRTctSTdvfmJ3K7RZERCXFd0
         8PetM2GzMdLaAL9NUWGyQ0b9dIbhmkCoVGciMDLzuA359qsT/eAKnc+0wrBCPIeMx62N
         rKllIk5BrC4svA9y1kjZiCCxdp0X//fwOsWgUUgtwaJoPVR/FYpO4Y6xr1IhvSRtRK19
         W9sw==
X-Gm-Message-State: APjAAAXIASLzbf+IrZ55wA1HxlLbPTVvR22Subo0wqiKuh7tjD3rP2Hq
        tUDfQDxmx95khY3NkL1WwbI=
X-Google-Smtp-Source: APXvYqxOR+UWdvobXXSImQ7ETxCuwCu6miHq0AoNeOjv2XOgN8luDW39quYWPRmvO323vmShUO0KYg==
X-Received: by 2002:a50:86ad:: with SMTP id r42mr2371575eda.40.1553170133547;
        Thu, 21 Mar 2019 05:08:53 -0700 (PDT)
Received: from brutus (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id 50sm1556236edz.73.2019.03.21.05.08.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 05:08:52 -0700 (PDT)
From:   Dominick Grift <dac.override@gmail.com>
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org, Nicolas Iooss <nicolas.iooss@m4x.org>,
        Laurent Bigonville <bigon@debian.org>
Subject: Re: [PATCH 1/1] restorecond: use /run instead of /var/run
References: <20190318210913.2392-1-nicolas.iooss@m4x.org>
        <pjdlg18ihf8.fsf@redhat.com>
Date:   Thu, 21 Mar 2019 13:08:51 +0100
In-Reply-To: <pjdlg18ihf8.fsf@redhat.com> (Petr Lautrbach's message of "Thu,
        21 Mar 2019 12:40:59 +0100")
Message-ID: <877ecspgz0.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Nicolas Iooss <nicolas.iooss@m4x.org> writes:
>
>> On most distributions, /var/run is a symbolic link to /run so using
>> /var/run or /run lead to the same result. Nevertheless systemd
>> started
>> to warn about using /var/run in a service file, logging entries such
>> as:
>>
>>     /usr/lib/systemd/system/restorecond.service:8: PIDFile=3D
>> references
>>     path below legacy directory /var/run/, updating
>>     /var/run/restorecond.pid =E2=86=92 /run/restorecond.pid; please
>> update the
>>     unit file accordingly.
>>
>> Switch to /run in order to follow this advice.
>>
>> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

There are other occurances of "/var/run" tree-wide. Some more important
than others: cd selinux; grep -r "/var/run" .

>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>
> Laurent, is it acceptable for Debian?
>
>
>> ---
>>  restorecond/restorecond.c       | 4 ++--
>>  restorecond/restorecond.conf    | 2 +-
>>  restorecond/restorecond.init    | 2 +-
>>  restorecond/restorecond.service | 2 +-
>>  restorecond/utmpwatcher.c       | 2 +-
>>  5 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c
>> index 7b984b298f79..d5f70fc2e2c1 100644
>> --- a/restorecond/restorecond.c
>> +++ b/restorecond/restorecond.c
>> @@ -84,7 +84,7 @@ static void done(void) {
>>  	selabel_close(r_opts.hnd);
>>  }
>>  -static const char *pidfile =3D "/var/run/restorecond.pid";
>> +static const char *pidfile =3D "/run/restorecond.pid";
>>   static int write_pid_file(void)
>>  {
>> @@ -217,7 +217,7 @@ int main(int argc, char **argv)
>>  	write_pid_file();
>>   	while (watch(master_fd, watch_file) =3D=3D 0) {
>> -	};
>> +	}
>>   	watch_list_free(master_fd);
>>  	close(master_fd);
>> diff --git a/restorecond/restorecond.conf
>> b/restorecond/restorecond.conf
>> index c64e74758d2f..1a61ece384d7 100644
>> --- a/restorecond/restorecond.conf
>> +++ b/restorecond/restorecond.conf
>> @@ -2,7 +2,7 @@
>>  /etc/resolv.conf
>>  /etc/samba/secrets.tdb
>>  /etc/updatedb.conf
>> -/var/run/utmp
>> +/run/utmp
>>  /var/log/wtmp
>>  /root/*
>>  /root/.ssh/*
>> diff --git a/restorecond/restorecond.init
>> b/restorecond/restorecond.init
>> index 775c52b0ce7c..c1cbb247fa91 100644
>> --- a/restorecond/restorecond.init
>> +++ b/restorecond/restorecond.init
>> @@ -9,7 +9,7 @@
>>  #
>>  # processname: /usr/sbin/restorecond
>>  # config: /etc/selinux/restorecond.conf -# pidfile:
>> /var/run/restorecond.pid
>> +# pidfile: /run/restorecond.pid
>>  #
>>  # Return values according to LSB for all commands but status:
>>  # 0 - success
>> diff --git a/restorecond/restorecond.service
>> b/restorecond/restorecond.service
>> index 0511a1c740ac..6bce99d39735 100644
>> --- a/restorecond/restorecond.service
>> +++ b/restorecond/restorecond.service
>> @@ -6,7 +6,7 @@ ConditionSecurity=3Dselinux
>>  [Service]
>>  Type=3Dforking
>>  ExecStart=3D/usr/sbin/restorecond
>> -PIDFile=3D/var/run/restorecond.pid
>> +PIDFile=3D/run/restorecond.pid
>>   [Install]
>>  WantedBy=3Dmulti-user.target
>> diff --git a/restorecond/utmpwatcher.c b/restorecond/utmpwatcher.c
>> index 62ad2e98aff3..8660520370de 100644
>> --- a/restorecond/utmpwatcher.c
>> +++ b/restorecond/utmpwatcher.c
>> @@ -49,7 +49,7 @@ unsigned int utmpwatcher_handle(int inotify_fd,
>> int wd)
>>  {
>>  	int changed =3D 0;
>>  	struct utmp u;
>> -	const char *utmp_path =3D "/var/run/utmp";
>> +	const char *utmp_path =3D "/run/utmp";
>>  	struct stringsList *prev_utmp_ptr =3D utmp_ptr;
>>  	if (wd !=3D utmp_wd)
>>  		return -1;
>

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift
