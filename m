Return-Path: <SRS0=jdxV=XO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F3CC49ED7
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 17:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C357820644
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 17:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="To4tVnpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390745AbfISRD5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:03:57 -0400
Received: from UHIL19PA40.eemsg.mail.mil ([214.24.21.199]:29961 "EHLO
        UHIL19PA40.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390734AbfISRD5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Sep 2019 13:03:57 -0400
X-EEMSG-check-017: 27404889|UHIL19PA40_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,524,1559520000"; 
   d="scan'208";a="27404889"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA40.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Sep 2019 17:03:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568912635; x=1600448635;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=HB3STKhQ9w7YeNO8+tUwSp4hr51Hp81Fri/p67yunPo=;
  b=To4tVnprm8Ht1e5SNx5b4skAeqhucZvvuXutPVXMwtjs7w/NaxjTFQ2j
   sr2qQJAiPOe3nBQf0RoTHPPcQ0CzndfNsR8mm61DxiGWyVKRnF5k3TFQq
   OIe6BBHo16uI5qPDBW96WKzKXswO5oNCM3o1M5eWz84SjxTEQ8N4M5Trz
   6rlY37ePEKJmxU7vYkhIkvNfy4Zbm0leSkFcsaq7Ikr0CSzl5m+73dQF4
   Th6gMZUrbnzVH5WyE3NLyA7swyNifltcnrzf54hrPW8N+v57Pw7E24R00
   boDvpNhLoZ2tHc09n1WbrDM/XoC5xwJjcaEZnv9KdsKTFA2iavnGxgBA2
   g==;
X-IronPort-AV: E=Sophos;i="5.64,524,1559520000"; 
   d="scan'208";a="33089249"
IronPort-PHdr: =?us-ascii?q?9a23=3A+bXSqh1ijfcojH8hsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseIeLvad9pjvdHbS+e9qxAeQG9mCsLQe06GP6/CoGTRZp8rY6jZaKN0Efi?=
 =?us-ascii?q?RGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq8cbjZF8JqotxR?=
 =?us-ascii?q?fFv2dEdudLzm9sOV6fggzw68it8JJ96Shcp+4t+8tdWqjmYqo0SqBVAi47OG?=
 =?us-ascii?q?4v/s3rshfDTQqL5nQCV2gdjwRFDQvY4hzkR5n9qiT1uPZz1ymcJs32UKs7WS?=
 =?us-ascii?q?++4KdxSR/nkzkIOjgk+2zKkMNwjaZboBW8pxxjxoPffY+YOOZicq7bYNgXXn?=
 =?us-ascii?q?RKUNpPWCNdA4O8d4oPAPQHPeZEtIn2ul8CoQKjCQWwGO/jzzlFiXHs3a0+zu?=
 =?us-ascii?q?8vDwfI0gI9FN4KqXjZrNH4OKIUXOuozqfH0C/DYutL1znj5ojGchMvr/+CUr?=
 =?us-ascii?q?1/c8Xe1UYhGhjZjliSs4HpIy+Z2+oPvmWd8uFuVfivi2kiqwxpvzav2tkjip?=
 =?us-ascii?q?HJho0LzFDP6Dh3wIMvKt28TE50f96lG4ZXuiGBKoR2WdgvQ31ouSkmyr0Gvo?=
 =?us-ascii?q?S3fC4RyJs93RLfZPuHc5aR7x/lSe2fIi94iWp4dL+wiBu+60itxvDmWsWq31?=
 =?us-ascii?q?tGsDBJnsTKu3sQzRLc8NKHReF4/kq53DaP0B3c5f9cLEAvkKrbN4Yhwrktlp?=
 =?us-ascii?q?oPqUjDHjH5mEHxjKKOakUr4PKo6+X6YrX9vJOcK491hR3+MqQpgMC/B/g3Mh?=
 =?us-ascii?q?MSUGSB/OS81bnj8VX4QLVMkPI2jrHUvI3VKMkUvKK0AxJZ3pw95xuwETuqys?=
 =?us-ascii?q?kUkWECLF1feRKHi4bpO0vJIPD9Ffq/mEmjkCxwyvDaPrzuHpXNLn/ZnLfnZr?=
 =?us-ascii?q?Zy8VRQyAU0zdBB/55UEK0OIOrvWk/ts9zVFgM5MgOow+bgFNV91pgTWW2KAq?=
 =?us-ascii?q?CDMaPStUWE6f4oI+mJfIUVoiryK+A55/7yin80gUQdcret3ZsWbnC4A/tnLl?=
 =?us-ascii?q?6HYXrjnNgBC30GvgkgQ+zwjl2NTzpTa2y1X6Im6TFoQL6hWLvOSsiRh6CBlH?=
 =?us-ascii?q?OnDoFRemBuBVWFEHOufIKBDaQiciWXd/R9nyQEWL7pcIoo0RWjpUeu0LZ8Bv?=
 =?us-ascii?q?bF8S0f85T43Z564POFxkJ6ziB9E8nIizLFdGpzhG5dAmZrja0=3D?=
X-IPAS-Result: =?us-ascii?q?A2ASAQB8tINd/wHyM5BlHQEBBQEHBQGBUwgBCwGBbSqBP?=
 =?us-ascii?q?wEyKoQiiByGd00BAQEBAQEGgRElfoh2jy2BewkBAQEBAQEBAQE0AQIBAYQ/A?=
 =?us-ascii?q?oMDIzQJDgIMAQEBBAEBAQEBBQMBAWyFOYI6KQGCZwEFIxVBEAsOCgICJgICV?=
 =?us-ascii?q?wYNBgIBAYJfP4F3FKxngTKFTIMqgUmBDCgBiBWDcxh4gQeBEScMgio1PodPg?=
 =?us-ascii?q?lgEjG6JEpcGgiyCLpJUBhuZI6khOIFYKwgCGAghD4MnUBAUkC8kAzCBBgEBj?=
 =?us-ascii?q?24BAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 19 Sep 2019 17:03:54 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8JH3sdO020347;
        Thu, 19 Sep 2019 13:03:54 -0400
Subject: Re: strange tclass in AVCs
To:     Ted Toth <txtoth@gmail.com>
Cc:     selinux@vger.kernel.org
References: <CAFPpqQFwGgEKU9KY2kif4C95fZPvLH0TGdTxLKUAXuRgK2zxBw@mail.gmail.com>
 <ac6433e2-88a4-747c-66f5-d241499f40d6@tycho.nsa.gov>
 <CAFPpqQGfAifnShcWTMs1pJe1m7W_4wM8AUqFsvj4Zts5-9QiCQ@mail.gmail.com>
 <b2c71d86-c574-43d6-2fcf-17a06078c8df@tycho.nsa.gov>
 <CAFPpqQHJU8sta7t5ZQ2PQCJi064Po4jXZ2g-LAoOZPF9rtd-pQ@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e8f03fe4-9a6d-3803-9766-ab3226fe79ed@tycho.nsa.gov>
Date:   Thu, 19 Sep 2019 13:03:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFPpqQHJU8sta7t5ZQ2PQCJi064Po4jXZ2g-LAoOZPF9rtd-pQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/19/19 9:02 AM, Ted Toth wrote:
> On Wed, Sep 18, 2019 at 9:18 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 9/18/19 10:03 AM, Ted Toth wrote:
>>> On Wed, Sep 18, 2019 at 8:53 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>
>>>> On 9/18/19 9:35 AM, Ted Toth wrote:
>>>>> I'm seeing things like tclass=context#012 in some AVCs what is this telling me?
>>>>
>>>> Just a guess here, but octal 012 is '\n' aka a newline character, and
>>>> libselinux/src/avc.c:avc_audit() appends a "\n" at the end of the buffer
>>>> before calling avc_log() to log the entire string.  avc_log() will call
>>>> the logging callback, and dbusd does define one, which calls
>>>> audit_log_user_avc_message().  Maybe audit_log_user_avc_message() is
>>>> escaping the newline character in its output as well as appending
>>>> additional data.
>>>>
>>>> I'm a little unclear though on why dbusd is checking a context contains
>>>> permission?
>>>
>>> These appear to only occur when systemd is starting the dbus daemon
>>> and they end up in /var/log/messages not /var/log/audit/audit.log as
>>> I'd expect.
>>
>> Sounds like auditd isn't operational at that point and therefore the
>> output just goes to syslog.
>>
>> Arguably avc_audit() shouldn't be adding a newline at all and that
>> should be handled by the logging callback (or default_selinux_log if no
>> callback is set).  But it has been this way forever, so that would no
>> doubt break some users.  Legacy of when this was a printk/printf.
>>
>>
>>
>>
> 
> FWIW here's the comments from the function dbus uses that calls
> avs_has_perm where the contains check happens. Why dbus policy does
> not allow this is seems like an oversight.

dbusd doesn't check context contains permission AFAIK, only acquire_svc 
and send_msg permissions in the dbus class.  Is that something you 
added?  Or are we picking up some kind of pam module interaction?

> 
> /**
>   * Determine if the SELinux security policy allows the given sender
>   * security context to go to the given recipient security context.
>   * This function determines if the requested permissions are to be
>   * granted from the connection to the message bus or to another
>   * optionally supplied security identifier (e.g. for a service
>   * context).  Currently these permissions are either send_msg or
>   * acquire_svc in the dbus class.
>   *
>   * @param sender_sid source security context
>   * @param override_sid is the target security context.  If SECSID_WILD this will
>   *        use the context of the bus itself (e.g. the default).
>   * @param target_class is the target security class.
>   * @param requested is the requested permissions.
>   * @returns #TRUE if security policy allows the send.
>   */
> #ifdef HAVE_SELINUX
> static dbus_bool_t
> bus_selinux_check (BusSELinuxID        *sender_sid,
>                     BusSELinuxID        *override_sid,
>                     security_class_t     target_class,
>                     access_vector_t      requested,
>                     DBusString          *auxdata)
> 

