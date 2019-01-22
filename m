Return-Path: <SRS0=5TXQ=P6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABBEC282C5
	for <selinux@archiver.kernel.org>; Tue, 22 Jan 2019 15:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5956217D6
	for <selinux@archiver.kernel.org>; Tue, 22 Jan 2019 15:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Ptf8ZXJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfAVPZD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:25:03 -0500
Received: from uphb19pa09.eemsg.mail.mil ([214.24.26.83]:56033 "EHLO
        USFB19PA12.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729498AbfAVPYH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Jan 2019 10:24:07 -0500
X-EEMSG-check-017: 246993867|USFB19PA12_EEMSG_MP8.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Jan 2019 15:24:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1548170642; x=1579706642;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=EedhNwDPrePssGs/sHPgL2jg6NBmFY/GWm1rOIQ27G4=;
  b=Ptf8ZXJpcFAUXpCecTtGDBYu0GuhAd8BhRVI6Ez/1A65jH5ptb9EWrNy
   sl/oV/lBvUKqRUzngjY31+cgYowXDkqcwsVuCFw9QLO7gVAdS16cMARSY
   V1W3+sCexbwDLXrSqt4M8cxSJhVN1LQhXBz6H+YtcClsxdTyLl5d1vUd1
   p2yoHDdVDHhlHgVqNWk68uzIB0FWMart95o8mg4tRG2ztlzG8RQRGJIVG
   UaEOdzRxzj2YxzbQ+1fimGSccVKmp7Et0/8K2Q9v3+qtEIjxPkDNUF9yi
   RcoKRZLgBnCl0AL9IbwQDTw2tqoMuiA2GckhIafHXOuwy+IZyxiE0nw4M
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,506,1539648000"; 
   d="scan'208";a="22921288"
IronPort-PHdr: =?us-ascii?q?9a23=3A95E3+B8xIiBXkf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0ewWIJqq85mqBkHD//Il1AaPAd2Lraocw8Pt8InYEVQa5piAtH1QOLdtbD?=
 =?us-ascii?q?Qizfssogo7HcSeAlf6JvO5JwYzHcBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBB?=
 =?us-ascii?q?r/KRB1JuPoEYLOksi7ze+/94HQbglSmDaxfa55IQmrownWqsQYm5ZpJLwryh?=
 =?us-ascii?q?vOrHtIeuBWyn1tKFmOgRvy5dq+8YB6/ShItP0v68BPUaPhf6QlVrNYFygpM3?=
 =?us-ascii?q?o05MLwqxbOSxaE62YGXWUXlhpIBBXF7A3/U5zsvCb2qvZx1S+HNsDtU7s6RS?=
 =?us-ascii?q?qt4LtqSB/wiScIKTg58H3MisdtiK5XuQ+tqwBjz4LRZoyaOuB+fqfAdt0EQ2?=
 =?us-ascii?q?RPUNtaWyhYDo69aocCCfcKM+RFoInnv1YAsBuwCxeiBO3sxDFHiHD50q8m3O?=
 =?us-ascii?q?ouCgzGwA8tEsgSvHjIotj4NqEfWv21wqnSyjXDautb1yrh6IfWahAhoe+DXb?=
 =?us-ascii?q?RtesTMzEkgDQfFjlGOpo3lIjiY0f8NvHWA7+d7SeKui3IoqwF2ojS1wMcskZ?=
 =?us-ascii?q?PGipgaylDD6yV02YA4LsC2Rk58ZN6rCppQtyeCOotsXMwtXmFotzwmyrEcpZ?=
 =?us-ascii?q?G7ey0KxIwkxxHBcfyHdZaH4hb5WOaWOzd4i2ppeL2+hxau9Uiv0PbzWtOo31?=
 =?us-ascii?q?ZNqypIlMTHuHMV1xHL98SKRfRw8l2h1DqSzQzf9O5JLV4umabGLZMq36Q+mY?=
 =?us-ascii?q?AJsUvZGy/7gED2jKiLeUo64uWo8OHnYqn+pp+bKo90lhnyMqQwlcy7BuQ1Kh?=
 =?us-ascii?q?QOUHKB+eS9yb3j5lf1QKlKj/IqkqnZt4rWJcIHqa6iHwBZyIMj6xe7Dzu+0d?=
 =?us-ascii?q?QYm2cILE5ddR6agIXkNEvCLfDlAfulnVihnylny+rbMrH5B5XCNHnDkLPvfb?=
 =?us-ascii?q?Zn7E5czRI+zctC6JJPEbwBPPLyVVPxtNzfFBM5NRe0zPz9BNVy0YMeR3qDAr?=
 =?us-ascii?q?WFP6PKrV+I+uUvLvGLZI8Qvzb9MP4l6OTygnAnglIdZ7em0oYXaH+iAvRqOV?=
 =?us-ascii?q?mWYX3pgt0ZC2cFohI+TPD2iF2FSTNTfGi9X6Y95jE9FYKnApzORp6igLOfxi?=
 =?us-ascii?q?e3BJ5WaX5cClCKD3joc5+IW/AWaCKdOsVhiCALVaC9S4890hGjrBP1xKB8Lu?=
 =?us-ascii?q?XK+iwVronj28R15+LJiBEy+zh0ANqH022UU257hHkESCMx3KB6uUZ90EuM0b?=
 =?us-ascii?q?Bkg/xEEtxe//dJUgY8NZ7BwO12EsvyVRzdcdeUUlamQ8mmADEoQtI0xN8Bfl?=
 =?us-ascii?q?t9G9G8gR3YwSqqDKEal6aRCJw37K3cxX7xKNh5y3rc06khlVYmSNNVNWK6nq?=
 =?us-ascii?q?5/6xTTB4nRnkWFlaanbqcc0zDX9GeF02WOuFtUUAlqUaXKRXoffFfZrczl5k?=
 =?us-ascii?q?PeSL+jEbAnMgpHyc6fJapGc9PpjU5bS/j9JtTRfWaxlnyuBRaH2LyMdpDme2?=
 =?us-ascii?q?YD0yXHDkgLjQQT8WyBNQgkCSeru3jeAyB2FVLzf0Ps9vFzp2+0Tk8uyAGKcl?=
 =?us-ascii?q?Vh16Gu9x4LivyTVekT0qgHuCg/sTV0Gkiy39bMB9qHvQphc/YUXdRox1FLz2?=
 =?us-ascii?q?/b/yl6JZqpJK1hzgoZdgNsuUrl2j1tB4lAmNRsp3QvmllcM6WdhWhdeiuY0J?=
 =?us-ascii?q?a4AbjeLm3/7Vj7cKLN8k3P29aRvKEU4bI3rEu171LhLVYr73gyi4od6HCb/J?=
 =?us-ascii?q?ifSVNKD58=3D?=
X-IPAS-Result: =?us-ascii?q?A2CvAwADNUdc/wHyM5BjHAEBAQQBAQcEAQGBZYFbKWZPM?=
 =?us-ascii?q?yeEAZQETAEBAQEBAQaBCAgliTOOYoFnMgYBhEACgmwiOBIBAwEBAQEBAQIBb?=
 =?us-ascii?q?BwMgjopAYJnAQUjDwEFQRAJAg4KAgIRFQICVwYNBgIBAYJfPwGBdA0PkQubY?=
 =?us-ascii?q?YEvhC4BhXAFgQuLNhd4gQeBEScMgl+DHgQYgQISARIBBwRTgkqCVwKRDJA6W?=
 =?us-ascii?q?gmHJIpxBhiSFI8gjVohZXErCAIYCCEPO4I4ATMTghQXE4M4hRSFXSEDMAEBg?=
 =?us-ascii?q?QMBAYdFDheCJwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 22 Jan 2019 15:24:00 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0MFNwjL015176;
        Tue, 22 Jan 2019 10:23:59 -0500
Subject: Re: [PATCH v2 0/3] Allow initializing the kernfs node's secctx based
 on its parent
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
References: <20190109162830.8309-1-omosnace@redhat.com>
 <fbdcf8ef-1587-18f2-3293-452d62305ab3@schaufler-ca.com>
 <f7312dd2-ea86-51ab-652d-2df39faf52c7@tycho.nsa.gov>
 <ef22910a-4922-5f66-b7c5-7a7c1dbad8e6@schaufler-ca.com>
 <93d310a7-0bce-dccd-8136-c659a460e084@tycho.nsa.gov>
 <1062e181-16fa-66b8-a48c-786edcb9deb7@schaufler-ca.com>
 <CAFqZXNsxfjwDaCWDrqxP736y_3Jm-r=twaHtkkTDtMuym774Jw@mail.gmail.com>
 <CAFqZXNsm2+79gMTqhxoZuPgibxfhSjJXu8742o7Ho7Yrf=2QCw@mail.gmail.com>
 <3f663024-98f0-98c9-6235-fa4ffafa6a03@tycho.nsa.gov>
Message-ID: <17663d9c-6667-fac9-9dda-610ff506bd5b@tycho.nsa.gov>
Date:   Tue, 22 Jan 2019 10:26:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3f663024-98f0-98c9-6235-fa4ffafa6a03@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/22/19 9:17 AM, Stephen Smalley wrote:
> On 1/22/19 3:49 AM, Ondrej Mosnacek wrote:
>> On Mon, Jan 14, 2019 at 10:01 AM Ondrej Mosnacek <omosnace@redhat.com> 
>> wrote:
>>> On Thu, Jan 10, 2019 at 6:55 PM Casey Schaufler 
>>> <casey@schaufler-ca.com> wrote:
>>>> Resending after email configuration repair.
>>>>
>>>> On 1/10/2019 6:15 AM, Stephen Smalley wrote:
>>>>> On 1/9/19 5:03 PM, Casey Schaufler wrote:
>>>>>> On 1/9/2019 12:37 PM, Stephen Smalley wrote:
>>>>>>> On 1/9/19 12:19 PM, Casey Schaufler wrote:
>>>>>>>> On 1/9/2019 8:28 AM, Ondrej Mosnacek wrote:
>>>>>>>>> Changes in v2:
>>>>>>>>> - add docstring for the new hook in union security_list_options
>>>>>>>>> - initialize *ctx to NULL and *ctxlen to 0 in case the hook is not
>>>>>>>>>      implemented
>>>>>>>>> v1: 
>>>>>>>>> https://lore.kernel.org/selinux/20190109091028.24485-1-omosnace@redhat.com/T/ 
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> This series adds a new security hook that allows to initialize 
>>>>>>>>> the security
>>>>>>>>> context of kernfs properly, taking into account the parent 
>>>>>>>>> context. Kernfs
>>>>>>>>> nodes require special handling here, since they are not bound 
>>>>>>>>> to specific
>>>>>>>>> inodes/superblocks, but instead represent the backing tree 
>>>>>>>>> structure that
>>>>>>>>> is used to build the VFS tree when the kernfs tree is mounted.
>>>>>>>>>
>>>>>>>>> The kernfs nodes initially do not store any security context 
>>>>>>>>> and rely on
>>>>>>>>> the LSM to assign some default context to inodes created over 
>>>>>>>>> them.
>>>>>>>>
>>>>>>>> This seems like a bug in kernfs. Why doesn't kernfs adhere to 
>>>>>>>> the usual
>>>>>>>> and expected filesystem behavior?
>>>>>>>
>>>>>>> sysfs / kernfs didn't support xattrs at all when we first added 
>>>>>>> support for setting security contexts to it, so originally all 
>>>>>>> sysfs / kernfs inodes had a single security context, and we only 
>>>>>>> required separate storage for the inodes that were explicitly 
>>>>>>> labeled by userspace.
>>>>>>>
>>>>>>> Later kernfs grew support for trusted.* xattrs using 
>>>>>>> simple_xattrs but the existing security.* support was left mostly 
>>>>>>> unchanged.
>>>>>>
>>>>>> OK, so as I said, this seems like a bug in kernfs.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>> Kernfs
>>>>>>>>> inodes, however, allow setting an explicit context via the 
>>>>>>>>> *setxattr(2)
>>>>>>>>> syscalls, in which case the context is stored inside the kernfs 
>>>>>>>>> node's
>>>>>>>>> metadata.
>>>>>>>>>
>>>>>>>>> SELinux (and possibly other LSMs) initialize the context of 
>>>>>>>>> newly created
>>>>>>>>> FS objects based on the parent object's context (usually the 
>>>>>>>>> child inherits
>>>>>>>>> the parent's context, unless the policy dictates otherwise).
>>>>>>>>
>>>>>>>> An LSM might use information about the parent other than the 
>>>>>>>> "context".
>>>>>>>> Smack, for example, uses an attribute SMACK64TRANSMUTE from the 
>>>>>>>> parent
>>>>>>>> to determine whether the Smack label of the new object should be 
>>>>>>>> taken
>>>>>>>> from the parent or the process. Passing the "context" of the 
>>>>>>>> parent is
>>>>>>>> insufficient for Smack.
>>>>>>>
>>>>>>> IIUC, this would involve switching the handling of security.* 
>>>>>>> xattrs in kernfs over to use simple_xattrs too (so that we can 
>>>>>>> store multiple such attributes), and then pass the entire 
>>>>>>> simple_xattrs list or at least anything with a security.* prefix 
>>>>>>> when initializing a new node or refreshing an existing inode.  
>>>>>>> Then the security module could extract any security.* attributes 
>>>>>>> of interest for use in determining the label of new inodes and in 
>>>>>>> refreshing the label of an inode.
>>>
>>> I actually had a patch to do just that at one point because I thought
>>> for a while that it would be required to call
>>> security_inode_init_security() (which I had tried to somehow force
>>> into the kernfs node creation at some point), but then I realized it
>>> is not actually needed (although would make thing a bit nicer) and put
>>> it away... I will try to dig it out and reuse here.
>>
>> Okay, now that I tried to do this with full xattr support I ran into a
>> problem. Along with converting kernfs to use simple_xattrs for
>> security attributes, I removed the call to
>> security_inode_notifysecctx() from kernfs_refresh_inode(), as it no
>> longer makes sense (kernfs doesn't know which attribute contains the
>> context; the LSM should now be able to pull it out via
>> vfs_getxattr()). However, SELinux now doesn't set the right security
>> context in the selinux_d_instantiate() hook, because the policy tells
>> it to use genfs, not xattr.
>>
>> So... I'm not sure how to fix this. Setting fs_use_xattr for cgroupfs
>> in the policy won't work, because then all nodes will be unlabeled_t
>> by default. Maybe we could patch the genfs case in
>> inode_doinit_with_dentry() to try fetching the xattr first? I'm not
>> very confident about touching that part of the code, so I would
>> welcome some advice here.
>>
>> This is the code I have so far, in case it helps:
>> https://gitlab.com/omos/linux-public/compare/selinux-next...selinux-fix-cgroupfs-v8 
>>
> 
> I would have left security_inode_notifysecctx() or an equivalent that 
> passes all of the xattrs to push the security attributes to the security 
> module.
> 
> Blindly calling __vfs_getxattr() on genfs could be a problem; IIRC, 
> doing so on fuse filesytems can create a deadlock during mount.  Or at 
> least that was the issue with switching fuse to fs_use_xattr in the past.

See commits 4d546f81717d253ab67643bf072c6d8821a9249c, 
102aefdda4d8275ce7d7100bc16c88c74272b260, 
089be43e403a78cd6889cde2fba164fefe9dfd89, 
811f3799279e567aa354c649ce22688d949ac7a9 and
https://bugzilla.redhat.com/show_bug.cgi?id=1256635#c34 for some prior 
work and discussions in this area.


