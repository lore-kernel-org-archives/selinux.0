Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1A3C433E6
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 18:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D89D64F53
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 18:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhCDSD4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Mar 2021 13:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbhCDSDj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Mar 2021 13:03:39 -0500
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2269FC06175F
        for <selinux@vger.kernel.org>; Thu,  4 Mar 2021 10:02:59 -0800 (PST)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 38BEB2A12B1;
        Thu,  4 Mar 2021 19:02:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 38BEB2A12B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1614880978;
        bh=IWDmVNcx2elAmv2AzdeCHZ5TXTlbnLWih+qr4TFD3FU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=opATvPNI/IhwIbyPkoybG3uGEo8fkkqWKoxyJxT1qkM+TeQEG8SHz6ji4FH+vQeJ9
         0v66OE1nHIlX64H5DBS201HdNIFB5UPvv0GHFCGk4D+aJ6lXUa3GNckdhVlp70lBrw
         1Gyh0LvEYAQmTfnxNEZjBCE05UAZw5CWEAuJMSzc=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Zdenek Pytela <zpytela@redhat.com>
Subject: Re: [PATCH userspace] fixfiles: do not exclude /dev and /run in -C
 mode
References: <20210301171922.321907-1-omosnace@redhat.com>
        <871rcv9dww.fsf@redhat.com>
        <CAFqZXNuzTSEok=x3ZyVyQvUK_DsBS6Ykfxk6DrUPLpnF+TQGRw@mail.gmail.com>
Date:   Thu, 04 Mar 2021 19:02:55 +0100
In-Reply-To: <CAFqZXNuzTSEok=x3ZyVyQvUK_DsBS6Ykfxk6DrUPLpnF+TQGRw@mail.gmail.com>
        (Ondrej Mosnacek's message of "Thu, 4 Mar 2021 16:02:16 +0100")
Message-ID: <ypjleegulru8.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ondrej Mosnacek <omosnace@redhat.com> writes:

> On Thu, Mar 4, 2021 at 3:44 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>> Ondrej Mosnacek <omosnace@redhat.com> writes:
>>
>> > I can't think of a good reason why they should be excluded. On the
>> > contrary, excluding them can cause trouble very easily if some labeling
>> > rules for these directories change. For example, we changed the label
>> > for /dev/nvme* from nvme_device_t to fixed_disk_device_t in Fedora
>> > (updating the allow rules accordingly) and after policy update they
>> > ended up with an invalid context, causing denials.
>>
>> I guess that /dev/ is there in order to avoid relabeling tty devices and block
>> the user from access:
>>
>> [root@localhost ~]# ls -Z /dev/tty1
>> user_u:object_r:user_tty_device_t:s0 /dev/tty1
>>
>> [root@localhost ~]# matchpathcon /dev/tty1
>> /dev/tty1       system_u:object_r:tty_device_t:s0

user_tty_device_t is probably a customizable_type and so as long as you dont
`--force` it should not reset.

>
> $ sudo chcon user_u:object_r:user_tty_device_t:s0 /dev/tty21
> $ ll -Z /dev/tty21
> crw--w----. 1 root tty user_u:object_r:user_tty_device_t:s0 4, 21 feb
> 26 15:13 /dev/tty21
> $ sudo restorecon -v /dev/tty21
> /dev/tty21 not reset as customized by admin to
> user_u:object_r:user_tty_device_t:s0
> $ ll -Z /dev/tty21
> crw--w----. 1 root tty user_u:object_r:user_tty_device_t:s0 4, 21 feb
> 26 15:13 /dev/tty21
>
> $ cat /etc/selinux/targeted/contexts/customizable_types
> container_file_t
> sandbox_file_t
> svirt_image_t
> svirt_home_t
> svirt_sandbox_file_t
> virt_content_t
> httpd_user_htaccess_t
> httpd_user_script_exec_t
> httpd_user_rw_content_t
> httpd_user_ra_content_t
> httpd_user_content_t
> git_session_content_t
> home_bin_t
> user_tty_device_t
>
> restorecon also doesn't change the user portion of the label if I only
> change that to user_u (leaving the type as tty_device_t).

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
