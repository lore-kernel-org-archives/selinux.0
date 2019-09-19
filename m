Return-Path: <SRS0=jdxV=XO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA668C3A5A6
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 17:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71A721928
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 17:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Zx7FRmFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389629AbfISR1X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:27:23 -0400
Received: from USAT19PA24.eemsg.mail.mil ([214.24.22.198]:6573 "EHLO
        USAT19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390733AbfISR1X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Sep 2019 13:27:23 -0400
X-EEMSG-check-017: 30022753|USAT19PA24_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,524,1559520000"; 
   d="scan'208";a="30022753"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Sep 2019 17:24:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568913891; x=1600449891;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=b7I3RI4d5a5UF/k0YQPG2iPjTpcQ+HfgJlMlV3AMiUA=;
  b=Zx7FRmFz35zDTWHHCHxsSZrCQ3dJ+oZCo0z6kznrTDEAaut5fxGple5I
   cGukoaFPPnIcoX4xI4sF81zOjA8OYxHMfrYV8jIHSIOKkQqs2H8f8Yi2Q
   cOcC61Cv4MwMQzYJU9GJWvZChzeplqtQ427tO0bWtkGpv0nvCYQK5USgK
   +WgqfWqsgWlzzjTFoolGa+7HekfZ621rkabeUF1dOrfZnChv3lksBna+c
   Cpl+6WvB2WFiVLniHWM56u1KD4w+1XtLyPmeJxxtJLUhi3Mrh/4gXE6EW
   kALilaWZOg9x/c09nprv1KMRCEXMxI/wzSV60/39ZxxBjMiu8UPezmEkj
   g==;
X-IronPort-AV: E=Sophos;i="5.64,524,1559520000"; 
   d="scan'208";a="33091822"
IronPort-PHdr: =?us-ascii?q?9a23=3ACtzs4xEWsaosNvdRH//gM51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zr8iwAkXT6L1XgUPTWs2DsrQY0rGQ6firADVaqdbZ6TZeKcYKD0?=
 =?us-ascii?q?dEwewt3CUYSPafDkP6KPO4JwcbJ+9lEGFfwnegLEJOE9z/bVCB6le77DoVBw?=
 =?us-ascii?q?mtfVEtfre9FYHdldm42P6v8JPPfQpImCC9YbRvJxmqsAndrMYbjZZsJ6or1B?=
 =?us-ascii?q?fFvnREd/lLyW92OFmfmwrw6tqq8JNs7ihcpegt+9JcXan/Yq81UaFWADM6Pm?=
 =?us-ascii?q?4v+cblrwPDTQyB5nsdVmUZjB9FCBXb4R/5Q5n8rDL0uvJy1yeGM8L2S6s0WS?=
 =?us-ascii?q?m54KdwVBDokiYHOCUn/2zRl8d9kbhUoBOlpxx43o7UfISYP+dwc6/BYd8XQ3?=
 =?us-ascii?q?dKU91PXCJdHIyzc4oPD/IAPelGqYn9u0AOpga6CQW1Ge/j1iNEinrw0KI0ye?=
 =?us-ascii?q?QhFRzN0hImEdwArX/YqMz5OacWXOywyqTD0DfNYO5M2Trl9YbGbB4hr/GPU7?=
 =?us-ascii?q?x+f8XexksgGB/KgFiLtYzoPSmY2vgRv2WV7edtU/+khW49qwF2pzii3toiip?=
 =?us-ascii?q?XXiYINylDL6yN5y5soK929UkF7ZdqkH4VQtiqHMIZ2Wd4tQ3pztSYmyrwJpZ?=
 =?us-ascii?q?67fC8QxJQh3B7QceaLc4eP4hL9TeucJypzinF9eL+nmhq//ketxvf8W8Wpyl?=
 =?us-ascii?q?pGsCVInsfWunwQ0RHY99KJReFn/ki73DaCzwXT6uZZLk8qjafbMJshwqIolp?=
 =?us-ascii?q?oUrETDAjf6mEXog6+ScUUp4vSo5P79YrXnu5+cLJV4ih3+M6symsy/Bv40Mg?=
 =?us-ascii?q?4SUGiA5euwzrjj/Uz9QLlSj/02lLfWsIzCKMgGqaO0DBVZ34Y+5xqlETur38?=
 =?us-ascii?q?oUkWMaIF5dfRKIlYnpO1XAIPDiCve/hkyhkCx2yPDdJbDhHpXMIWTDkLfmZ7?=
 =?us-ascii?q?p97VVcxxApwdBQ4JJUFKkNIOjvVU/pqNzYEhg5PhSow+foFNV90Z8eWWKUD6?=
 =?us-ascii?q?+WNaPdq16I5uY1L+aQY48VvS73K+I56P72kX85hVgdcLGy3ZQJbHC4H/JmI1?=
 =?us-ascii?q?iWYHf3nNcBHnkFvhAkQOzpllKCSzhTaGi2X64m4TE7Eo2mXs//QdWRjbDJ4C?=
 =?us-ascii?q?CnHtUCenBaDUyMOXjtfoSAHfwLbXTBDNVml2k/SbW5S4InnSqrvQv+xqsvev?=
 =?us-ascii?q?HY4QUEpJnj055z/OSVmhYso28nR/+B2n2AGjkn1lgDQCU7ieUm/B1w?=
X-IPAS-Result: =?us-ascii?q?A2BoAgAvuYNd/wHyM5BmHQEBBQEHBQGBVQYBCwGBbSqBP?=
 =?us-ascii?q?wEyKoQijxRNAQEBAQEBBoE2foh2jy2BewkBAQEBAQEBAQE0AQIBAYQ/AoMDI?=
 =?us-ascii?q?zYHDgIMAQEBBAEBAQEBBQMBAWyFOYI6KQGCZwEFIxVBEAsOCgICJgICVwYNB?=
 =?us-ascii?q?gIBAYJfP4F3FK0bgTKFTIMsgUmBDCgBiBWDcxh4gQeBESeCNjU+h0+CWASMb?=
 =?us-ascii?q?okSlwaCLIIuklQGG5kjqSgELYFYKwgCGAghD4MnUBAUkC8kAzCBBgEBj24BA?=
 =?us-ascii?q?Q?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 19 Sep 2019 17:24:50 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8JHOost025439;
        Thu, 19 Sep 2019 13:24:50 -0400
Subject: Re: strange tclass in AVCs
To:     Ted Toth <txtoth@gmail.com>
Cc:     selinux@vger.kernel.org
References: <CAFPpqQFwGgEKU9KY2kif4C95fZPvLH0TGdTxLKUAXuRgK2zxBw@mail.gmail.com>
 <ac6433e2-88a4-747c-66f5-d241499f40d6@tycho.nsa.gov>
 <CAFPpqQGfAifnShcWTMs1pJe1m7W_4wM8AUqFsvj4Zts5-9QiCQ@mail.gmail.com>
 <b2c71d86-c574-43d6-2fcf-17a06078c8df@tycho.nsa.gov>
 <CAFPpqQHJU8sta7t5ZQ2PQCJi064Po4jXZ2g-LAoOZPF9rtd-pQ@mail.gmail.com>
 <e8f03fe4-9a6d-3803-9766-ab3226fe79ed@tycho.nsa.gov>
 <CAFPpqQG_2B=-E8HNEaMkkKidXWPSuEs9M_ZWR7u_YdQ7KmvuCQ@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2d8a08ba-785d-bccc-69a7-e3de38a16f64@tycho.nsa.gov>
Date:   Thu, 19 Sep 2019 13:24:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFPpqQG_2B=-E8HNEaMkkKidXWPSuEs9M_ZWR7u_YdQ7KmvuCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/19/19 1:19 PM, Ted Toth wrote:
> On Thu, Sep 19, 2019 at 12:03 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 9/19/19 9:02 AM, Ted Toth wrote:
>>> On Wed, Sep 18, 2019 at 9:18 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>
>>>> On 9/18/19 10:03 AM, Ted Toth wrote:
>>>>> On Wed, Sep 18, 2019 at 8:53 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>>>
>>>>>> On 9/18/19 9:35 AM, Ted Toth wrote:
>>>>>>> I'm seeing things like tclass=context#012 in some AVCs what is this telling me?
>>>>>>
>>>>>> Just a guess here, but octal 012 is '\n' aka a newline character, and
>>>>>> libselinux/src/avc.c:avc_audit() appends a "\n" at the end of the buffer
>>>>>> before calling avc_log() to log the entire string.  avc_log() will call
>>>>>> the logging callback, and dbusd does define one, which calls
>>>>>> audit_log_user_avc_message().  Maybe audit_log_user_avc_message() is
>>>>>> escaping the newline character in its output as well as appending
>>>>>> additional data.
>>>>>>
>>>>>> I'm a little unclear though on why dbusd is checking a context contains
>>>>>> permission?
>>>>>
>>>>> These appear to only occur when systemd is starting the dbus daemon
>>>>> and they end up in /var/log/messages not /var/log/audit/audit.log as
>>>>> I'd expect.
>>>>
>>>> Sounds like auditd isn't operational at that point and therefore the
>>>> output just goes to syslog.
>>>>
>>>> Arguably avc_audit() shouldn't be adding a newline at all and that
>>>> should be handled by the logging callback (or default_selinux_log if no
>>>> callback is set).  But it has been this way forever, so that would no
>>>> doubt break some users.  Legacy of when this was a printk/printf.
>>>>
>>>>
>>>>
>>>>
>>>
>>> FWIW here's the comments from the function dbus uses that calls
>>> avs_has_perm where the contains check happens. Why dbus policy does
>>> not allow this is seems like an oversight.
>>
>> dbusd doesn't check context contains permission AFAIK, only acquire_svc
>> and send_msg permissions in the dbus class.  Is that something you
>> added?  Or are we picking up some kind of pam module interaction?
> 
> You're right it only checks those permissions not contains :( We don't
> modify dbus.
> How were you thinking pam could be involved?

No idea but pam_selinux does check context contains permission.  If 
dbusd is firing off anything that has pam_selinux in its pam stack, 
maybe that would show up?  I don't know.

Other scenario is that the check isn't truly for context contains but 
rather is a class/permission mapping problem, e.g. your dbusd isn't 
using selinux_set_mapping() or equivalent to map its class/perms and 
your policy has the context contains definitions where it expects the 
dbus class/perms to be.

> 
>>
>>>
>>> /**
>>>    * Determine if the SELinux security policy allows the given sender
>>>    * security context to go to the given recipient security context.
>>>    * This function determines if the requested permissions are to be
>>>    * granted from the connection to the message bus or to another
>>>    * optionally supplied security identifier (e.g. for a service
>>>    * context).  Currently these permissions are either send_msg or
>>>    * acquire_svc in the dbus class.
>>>    *
>>>    * @param sender_sid source security context
>>>    * @param override_sid is the target security context.  If SECSID_WILD this will
>>>    *        use the context of the bus itself (e.g. the default).
>>>    * @param target_class is the target security class.
>>>    * @param requested is the requested permissions.
>>>    * @returns #TRUE if security policy allows the send.
>>>    */
>>> #ifdef HAVE_SELINUX
>>> static dbus_bool_t
>>> bus_selinux_check (BusSELinuxID        *sender_sid,
>>>                      BusSELinuxID        *override_sid,
>>>                      security_class_t     target_class,
>>>                      access_vector_t      requested,
>>>                      DBusString          *auxdata)
>>>
>>

