Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F63C43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 15:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83CC2146E
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 15:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Hn5IgkWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfLRPNu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:13:50 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:41262 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfLRPNu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 10:13:50 -0500
Received: by mail-ua1-f43.google.com with SMTP id f7so745118uaa.8
        for <selinux@vger.kernel.org>; Wed, 18 Dec 2019 07:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2EIEXfvfMwN3D7ORQF5+AB996TGcSb5Y+7lCcWkOPIw=;
        b=Hn5IgkWIA+OV9Hyor/8Bg55Ovc4H7/5wXzhFbX9sW/kYo7RC5OPnEzvQrUXaweWC2U
         mMRL//BBkqf5cdDv6uGgJhnyhlk6jJChzE83w+IW8fRRzawviFTu+34pz48PpNfkxkLD
         OFMgfqo8lvHbTmNqxf/eh2wU7gDwHea0syWWIzm+J4SGy4J3wweljaPIRK1eNx5hzfZl
         tOofBdEKXUSm/8KQb9XGsoeRwKW1FZfxXqovl1rf0BE+CFwRYhu7J7IWgNePkoGnwETj
         dhGro6UvVRerUS1f3pN8DKFrv2ckg7XH+36MosiNZ38m+C0rBoXGNJCE7Fi4sE4rkH58
         LrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2EIEXfvfMwN3D7ORQF5+AB996TGcSb5Y+7lCcWkOPIw=;
        b=ierRgUj2Z4vnrd9l6gtFilR0vlzhOadSmztMsPA2EujHU7W7EZd/ustOJz8kdncIG8
         lZHRky/T1CA9uG+1PBWYslLW/vfYx9ywlUS1RargPenYR/Ry8JTnrp4WK/UeSKlMv7uG
         ZHKF28Twi3snj4jL4TAaLLjdBGps2Rj73FSNiHYgl0ETJjnHg3wVnOL7H6kgNKsH8mdi
         lixx43QdeBjAVaDBjo8a2ZYnqIqjee4HK+7OXAvmyHRpHth2YrNEWnb43KaBH9pKNMEW
         ffe9N2FBa/UdHJryk8VDQZC2VXBp9g/9bWTX8oFCw/XXuV5NN1t4qcVnc+HVQZLXBsLm
         5O5Q==
X-Gm-Message-State: APjAAAXyQnKjfI+eInykemrFg5iTFJebh1bbEOQfpXOQvOsU+5Z8hige
        66Nz6fJmOY3tyvanW9YDb0mmM7JIsL/ltIZOyupTKWLz
X-Google-Smtp-Source: APXvYqxracT0GYdCAhocK7cH2P06o2WMyFDvl7MXzjsEw+tog9AcCYUUCppYSkL7ACr8VF7Cgc61/njHYGx83vvd9Pg=
X-Received: by 2002:ab0:2759:: with SMTP id c25mr1679223uap.104.1576682028931;
 Wed, 18 Dec 2019 07:13:48 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Wed, 18 Dec 2019 16:13:37 +0100
Message-ID: <CAJ2a_Ddz0dXzuhyyO_SNNZRc==8K7Nba0N6Rh_u+yig6c7w3tQ@mail.gmail.com>
Subject: incorrect sysfs contexts
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

I am trying to refine contexts of sysfs.

When using genfscon statements like:
    genfscon sysfs /  system_u:object_r:sysfs_t:s0
    genfscon sysfs /class/net  system_u:object_r:net_sysfs_t:s0
    genfscon sysfs /devices  system_u:object_r:generic_device_sysfs_t:s0
    genfscon sysfs /devices/system/cpu  system_u:object_r:cpu_sysfs_t:s0
    genfscon sysfs /devices/system/cpu/online
system_u:object_r:cpu_online_sysfs_t:s0
    genfscon sysfs /firmware  system_u:object_r:firmware_sysfs_t:s0
    genfscon sysfs /module/apparmor  system_u:object_r:apparmor_sysfs_t:s0

and file context definitions like:
    /sys(/.*)?
gen_context(system_u:object_r:sysfs_t,s0)
    /sys/module/apparmor(/.*)?
gen_context(system_u:object_r:apparmor_sysfs_t,s0)
    /sys/devices/system/cpu(/.*)?
gen_context(system_u:object_r:cpu_sysfs_t,s0)
    /sys/devices/system/cpu/online          --
gen_context(system_u:object_r:cpu_online_sysfs_t,s0)
    /sys/firmware(/.*)?
gen_context(system_u:object_r:firmware_sysfs_t,s0)
    /sys/devices(/.*)?
gen_context(system_u:object_r:generic_device_sysfs_t,s0)
    /sys/devices/.*/sd[a-z](/.*)?
gen_context(system_u:object_r:harddrive_sysfs_t,s0)
    /sys/devices/.*/hwmon(/.*)?
gen_context(system_u:object_r:hwmon_sysfs_t,s0)
    /sys/class/net(/.*)?
gen_context(system_u:object_r:net_sysfs_t,s0)
    /sys/devices/.*/net(/.*)?
gen_context(system_u:object_r:net_sysfs_t,s0)

with a systemd tmpfiles entry:
    #Type Path        Mode UID  GID  Age Argument
    Z     /sys        -    -    -    -   -

I still get incorrect labeled entries after boot:

$ restorecon -v -R -n /
Would relabel /sys/devices/platform/intel_rapl_msr.0/subsystem from
system_u:object_r:sysfs_t:s0 to
system_u:object_r:generic_device_sysfs_t:s0
Would relabel /sys/devices/pci0000:00/0000:00:05.0/0-0:AD1980/subsystem
from system_u:object_r:sysfs_t:s0 to
system_u:object_r:generic_device_sysfs_t:s0
Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/controlC0/de=
vice
from system_u:object_r:sysfs_t:s0 to
system_u:object_r:generic_device_sysfs_t:s0
Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/controlC0/su=
bsystem
from system_u:object_r:sysfs_t:s0 to
system_u:object_r:generic_device_sysfs_t:s0
Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D1c/dev=
ice
from system_u:object_r:sysfs_t:s0 to
system_u:object_r:generic_device_sysfs_t:s0
Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D1c/sub=
system
from system_u:object_r:sysfs_t:s0 to
system_u:object_r:generic_device_sysfs_t:s0
Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0c/dev=
ice
from system_u:object_r:sysfs_t:s0 to
system_u:object_r:generic_device_sysfs_t:s0
Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0c/sub=
system
from system_u:object_r:sysfs_t:s0 to
system_u:object_r:generic_device_sysfs_t:s0
Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/device
from system_u:object_r:sysfs_t:s0 to
system_u:object_r:generic_device_sysfs_t:s0
Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/subsystem
from system_u:object_r:sysfs_t:s0 to
system_u:object_r:generic_device_sysfs_t:s0
Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0p/dev=
ice
from system_u:object_r:sysfs_t:s0 to
system_u:object_r:generic_device_sysfs_t:s0
Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0p/sub=
system
from system_u:object_r:sysfs_t:s0 to
system_u:object_r:generic_device_sysfs_t:s0

Using auditallow statements reveals no accesses.

How can I enforce these entries to be created with correct labels?


Best regards,
     Christian G=C3=B6ttsche
