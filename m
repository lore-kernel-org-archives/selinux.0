Return-Path: <SRS0=WX8y=ON=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1525BC04EBF
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 15:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7309206B7
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 15:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7309206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbeLDPj5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:39:57 -0500
Received: from ucol19pa10.eemsg.mail.mil ([214.24.24.83]:33562 "EHLO
        UCOL19PA10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbeLDPj5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Dec 2018 10:39:57 -0500
X-EEMSG-check-008: 621259278|UCOL19PA10_EEMSG_MP8.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,314,1539648000"; 
   d="scan'208";a="621259278"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Dec 2018 15:39:55 +0000
X-IronPort-AV: E=Sophos;i="5.56,314,1539648000"; 
   d="scan'208";a="21310917"
IronPort-PHdr: =?us-ascii?q?9a23=3AUiwXhxwKsQ2OMgjXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0ukeKvad9pjvdHbS+e9qxAeQG9mDu7Qc06L/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHPYAhEniaxba9vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb7Vq4/Vy?=
 =?us-ascii?q?i84Kh3SR/okCYHOCA/8GHLkcx7kaZXrAu8qxBj34LYZYeYO/RkfqPZYNgUW2?=
 =?us-ascii?q?xPUMhMXCBFG4+wcZcDA+8HMO1FrYfyukEOoAOjCweyCuPhyjxGiHH40qI10e?=
 =?us-ascii?q?suDQ7I0Rc8H98MqnnYsMn5OakQXO2z0aLGzS/Db/RT2Trl9YbIbg4uoemMXb?=
 =?us-ascii?q?1ud8ra1FQhFwbfgVWUrYzqITOU3fkKvmiA8uVgTvmii3Inqg5tojivwd0gio?=
 =?us-ascii?q?/Sho0P0FzE+iJ5wJgsKNC+VUV1YsakHYNNuyyVOIZ6WMMvT3xytCokxbAKp4?=
 =?us-ascii?q?S3cDUMxZ863RDQceaHfJKN4h/7UeaRJip3i2x9dbKkghay7VCgyurhVsmoyF?=
 =?us-ascii?q?pKrjRKkt3Ltn0Vyxzc8NKHSvpg/ke6wzqPywDS5f1EIUAzj6bbLYIuwqUsmZ?=
 =?us-ascii?q?YJtETDHyv2lF33jK+QaEok5vCl5/nob7jpvJORN5J4hhvgPqkhhMCzG/k0Ph?=
 =?us-ascii?q?ALX2eB+OS80LPj/Vf+QLVPlvA2ibTWsIvBKMQHpq+2Hw9V0oE55xa5FDepys?=
 =?us-ascii?q?4UnXYALFJbYB6HlZTmO0nSIPDkCveym0qskDhsx/HGJLLhBo7ALmLdn7j8fb?=
 =?us-ascii?q?Zy8VJcxBAvwtBY4pJeEqsBL+7rWk/tqNzYCQc0Mwm1w+bkDNV90ZgeVHmUAq?=
 =?us-ascii?q?6YLqzSq0GH6f8uI+WWZI8VpS73K+I56P72kX85hVgdcLGu3ZsSb3C4BfJmLF?=
 =?us-ascii?q?+FbnXymdoBC3kFsRc+TOPwlF2OSyJcZ3G3X6gk/DE0FJqmDZvfRoCqmLGOxy?=
 =?us-ascii?q?m7HpxIaWBCF1+MCmzld4uFW/gSbCKdP9RhnSIfVbS7TI8hzx6uvhfgy7V7Nu?=
 =?us-ascii?q?rU5jEYtZX72dhu/eLTkREz9D10DsSbyGyCVWd0kX4SRz8x3aBwvFZxxUuE0a?=
 =?us-ascii?q?h9m/ZYD8Bc5+tVUgcmMp7R1/R6BMrvWgLFZdqJUEypQsiiAT0oS9IxxNgOY1?=
 =?us-ascii?q?xjFNm4kh/D2C+qCacPl7OXHJw07r7c33/pKsZ5ynbG0rQhjlY/TstMK2KmnK?=
 =?us-ascii?q?h/+BbXB4PSjUWZmLildb4G0C7O6miD12yOs19cUAJqVqXFR38fbFPMrdvl/k?=
 =?us-ascii?q?PCU6OuCbM/PwtFyM6CLLZKa9LwgVVbQvfjOdPeY2S/m2erHhuI2LyMY5Twe2?=
 =?us-ascii?q?kH3yXSFlIEkwYN8naCLwQ+AT2ho23GBjx0CV3ve1/s8fV5qH6jSk80zgeKb1?=
 =?us-ascii?q?Bu1ras9B4VnuGTRO0N3r0avCcssCt0HFmj0NLMEdaApBRufL9aYdwj5FdLz2?=
 =?us-ascii?q?XZtxZyPpa4NaBtmkYecxhrv0Ppzxh3EZtPkcwrrHMs0QpzJrmV0E1OdzyGx5?=
 =?us-ascii?q?D8IL7XJXfo/BCpdaHW3kvS0NGM+qcA8P44sUnsvBm1Fko+9HVqy8Ra0nWG6Z?=
 =?us-ascii?q?XOFwoSUYn8Ulwp+Bdnp7HVeDU965nI2n1rNKnn+gPFjuwoGuYmgjmnbt5beP?=
 =?us-ascii?q?eaGwjjGskyHcWiKOU23VOua0RXEvpV8fsPI86+d/aAkJWuNeJkkSPu2X9L+6?=
 =?us-ascii?q?hhw0mM8Gx6UeeO0JEblaLLljCbXivx2Q/y+vv8nppJMHRLRDKy?=
X-IPAS-Result: =?us-ascii?q?A2AKAABGngZc/wHyM5BjGgEBAQEBAgEBAQEHAgEBAQGBU?=
 =?us-ascii?q?wMBAQEBCwGBWimBaCeDeZRzAQEBAQEBBoEICCWJH44qgXo4AYRAAoNPIjYHD?=
 =?us-ascii?q?QEDAQEBAQEBAgFsKII2JAGCYgEFIwQRNAoDEAsOCgICJgICVwYNBgIBAYJeP?=
 =?us-ascii?q?4F1DaUEfDOFQIRygQuLExd4gQeBEScMgl+IBYJXAokcggSEWDdQj0oJkTsGG?=
 =?us-ascii?q?IFbiDaHFZpEDSSBVSsIAhgIIQ+DJ5B5IQMwgQUBAYpiAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 04 Dec 2018 15:39:54 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wB4FdroD027067;
        Tue, 4 Dec 2018 10:39:53 -0500
Subject: Re: overlayfs access checks on underlying layers
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        Daniel J Walsh <dwalsh@redhat.com>
References: <377b7d4f-eb1d-c281-5c67-8ab6de77c881@tycho.nsa.gov>
 <CAJfpegtNhcWD0VWy6LPtoDtQBfPu4x5iFsB053UMCidj6oMsuw@mail.gmail.com>
 <26bce3be-49c2-cdd8-af03-1a78d0f268ae@tycho.nsa.gov>
 <CAJfpeguL9xOh9Eq8LOP=ddJ4YD6nbp2UY6e2AYDVoHeCLuVhZA@mail.gmail.com>
 <6b125e8e-413f-f8e6-c7ae-50f7235c8960@tycho.nsa.gov>
 <CAJfpegv6y56k1-Tewu-Pu3x1W75LL6qYB6Hb6=n+2BJoNfEigA@mail.gmail.com>
 <c993dba4-5129-7f04-2724-a82a1f1cafa3@tycho.nsa.gov>
 <f84bbe0b-f4c1-50e0-8c84-a6589154b3ae@tycho.nsa.gov>
 <CAJfpegtBDTMbmKd6eDxRmtSJjGN6CnpGK_QPNSsxjkOoeu=1pQ@mail.gmail.com>
 <4c20a261-5ce1-f0a2-8d40-c6032a023216@tycho.nsa.gov>
 <20181204151549.GA21509@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <311721a0-26d4-3cf6-1628-acb2c2b1478b@tycho.nsa.gov>
Date:   Tue, 4 Dec 2018 10:42:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181204151549.GA21509@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/4/18 10:15 AM, Vivek Goyal wrote:
> On Tue, Dec 04, 2018 at 09:30:53AM -0500, Stephen Smalley wrote:
>> On 12/4/18 8:32 AM, Miklos Szeredi wrote:
>>> On Thu, Nov 29, 2018 at 10:16 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>
>>>> On 11/29/18 4:03 PM, Stephen Smalley wrote:
>>>>> On 11/29/18 2:47 PM, Miklos Szeredi wrote:
>>>>>> On Thu, Nov 29, 2018 at 5:14 PM Stephen Smalley <sds@tycho.nsa.gov>
>>>>>> wrote:
>>>>>>
>>>>>>> Possibly I misunderstood you, but I don't think we want to copy-up on
>>>>>>> permission denial, as that would still allow the mounter to read/write
>>>>>>> special files or execute regular files to which it would normally be
>>>>>>> denied access, because the copy would inherit the context specified by
>>>>>>> the mounter in the context mount case.  It still represents an
>>>>>>> escalation of privilege for the mounter.  In contrast, the copy-up on
>>>>>>> write behavior does not allow the mounter to do anything it could not do
>>>>>>> already (i.e. read from the lower, write to the upper).
>>>>>>
>>>>>> Let's get this straight:  when file is copied up, it inherits label
>>>>>> from context=, not from label of lower file?
>>>>>
>>>>> That's correct.  The overlay inodes are all assigned the label from the
>>>>> context= mount option, and so are any upper inodes created through the
>>>>> overlay.  At least that's my understanding of how it is supposed to
>>>>> work.  The original use case was for containers with the lower dir
>>>>> labeled with a context that is read-only to the container context and
>>>>> using a context that is writable by the container context for the
>>>>> context= mount.
>>>>>
>>>>>> Next question: permission to change metadata is tied to permission to
>>>>>> open?  Is it possible that open is denied, but metadata can be
>>>>>> changed?
>>>>>
>>>>> There is no metadata change occurring here. The overlay, upper, and
>>>>> lower inodes all keep their labels intact for their lifetime (both
>>>>> overlay and upper always have the context= label; upper has whatever its
>>>>                                                      ^^lower^^
>>>>
>>>>> original label was), unless explicitly relabeled by some process.  And
>>>>> when viewed through the overlay, the file always has the label specified
>>>>> via context=, even before the copy-up.
>>>
>>> Okay.
>>>
>>>>>
>>>>>> DAC model allows this: metadata change is tied to ownership, not mode
>>>>>> bits.   And different capability flag.
>>>>>>
>>>>>> If the same is true for MAC, then the pre-v4.20-rc1 is already
>>>>>> susceptible to the privilege escalation you describe, right?
>>>>>
>>>>> Actually, I guess there wouldn't be a privilege escalation if you
>>>>> checked the mounter's ability to create the new file upon copy-up, and
>>>>> checked the mounter's access to the upper inode label upon the
>>>>> subsequent read, write, or execute access.  Then we'd typically block
>>>>> the ability to create the device file and we'd block the ability to
>>>>> execute files with the label from context=.
>>>>>
>>>>> But copy-up of special files seems undesirable for other reasons (e.g.
>>>>> requiring mounters to be allowed to create device nodes just to permit
>>>>> client's to read/write them, possible implications for nodev/noexec,
>>>>> implications for socket and fifo files).
>>>
>>> I think you missed my point: opening a device file or executing an
>>> executable wouldn't normally require copy-up.   If
>>>
>>>    -  permission is granted on overlay to task, and
>>>    -  permission is granted on lower layer to mounter,
>>>
>>> then copy-up wouldn't be performed.
>>>
>>> My proposed sequence would be
>>>
>>> a) check task's creds against overlay inode, fail -> return fail, otherwise:
>>> b) check mounter's creds against lower inode, success -> return
>>> success, otherwise:
>>> c) copy up inode, fail -> return fail, otherwise
>>> d) check mounter's creds against upper inode, return result.
>>>
>>> So, unlike write access to regular files, write access to special
>>> files don't necessarily result in copy-up.
>>>
>>> You say this is an escalation of privilege, but I don't get it how.
>>> As DWalsh points out downthread, if mounter cannot create device
>>> files, then the copy-up will simply fail.  If mounter can create
>>> device files, then this is not an escalation of privilege for the
>>> mounter.
>>
>> Yes, in that case there isn't an escalation of privilege for the mounter (I
>> acknowledged that above).  I'm still not sure copy-up of special files is a
>> good idea though:
>>
>> - In the case of device files, there is the potential for mischief by the
>> client task in misusing the mounter's privileges to gain access to otherwise
>> unusable device node (nodev lower vs upper?),
> 
> I was thinking about it as well. But client can always bypass permissions
> of lower device inode by first removing device file and then by doing
> a mknod. And that will be equivalent of copy up. IOW, IIUC, we do not deny
> mknod to client and that always creates a way for it to write to device
> file (and it does not matter what are permissions on lower?)

I'm not sure what you mean by "we do not deny mknod to client".  Depends 
on your policy and what context the client is running in.  Plenty of 
situations where the client is not allowed to create device files 
directly, and the mounter is.

