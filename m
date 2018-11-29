Return-Path: <SRS0=qOBY=OI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A9AC07E85
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 21:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A67B20868
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 21:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A67B20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.nsa.gov
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeK3IHq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:07:46 -0500
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:13788 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeK3IHp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Nov 2018 03:07:45 -0500
X-EEMSG-check-008: 662307853|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,295,1539648000"; 
   d="scan'208";a="662307853"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by ucol19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 29 Nov 2018 21:01:00 +0000
X-IronPort-AV: E=Sophos;i="5.56,295,1539648000"; 
   d="scan'208";a="21166968"
IronPort-PHdr: =?us-ascii?q?9a23=3A27XcSBXPcd22mQsu9V0BZlmZKy3V8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRePvqdThVPEFb/W9+hDw7KP9fy4CSpYud6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9uLxi6txndutULioZ+N6g9zQ?=
 =?us-ascii?q?fErGFVcOpM32NoIlyTnxf45siu+ZNo7jpdtfE8+cNeSKv2Z6s3Q6BWAzQgKG?=
 =?us-ascii?q?A1+dbktQLfQguV53sTSXsZnxxVCAXY9h76X5Pxsizntuph3SSRIMP7QawoVT?=
 =?us-ascii?q?mk8qxmUwHjhjsZODEl8WHXks1wg7xdoBK9vBx03orYbJiIOPZiYq/ReNUXSm?=
 =?us-ascii?q?RbXsZVSidPHIWyYYUSBOYFJOpUsZXxq14IoBCjBwejGfnvxydViHHo06000+?=
 =?us-ascii?q?cvHw/I0wMvHd0BrHvaoc7pNKoQS+250LXEwDvBYv5QxDzz6JLIchckofyUQL?=
 =?us-ascii?q?xwbdTeyVEvFwzbiFWbtJHrPzaP2eQJt2iU8ephXv+ohm48tg5xuSOixtssi4?=
 =?us-ascii?q?bVhoIVzUrI9SNiwIkvP9G4R0l7YcC9HZZWqiqUNJN2T9s/T2xntys20L0LtY?=
 =?us-ascii?q?OhcCQUx5kr2QTTZ+GBfoOV+BzsTvyRLi19hH99fbK/gAu9/la4x+3nU8m0zE?=
 =?us-ascii?q?5Kri1YktnQrnwN1wLc6syASvZl4keuwyyP1wHO6uFfO0w0iaraJIIhwr43jJ?=
 =?us-ascii?q?YTt1jMHjTql0nsia+Wd0Ek9vCp6+ThfLrmuoeRO5J7hwzxKKgjmtGzDf4mPg?=
 =?us-ascii?q?UBQWSX4/mw2KXm/ULjQbVKivM2krPesJDfPckbvbO2AxRO34Y/6xewEzem0N?=
 =?us-ascii?q?MCkXkBN1JKYgiLj4fuO1HQOPz4F+uwg0ywkDd3wPDLJrjhApTOLnjHl7fhZq?=
 =?us-ascii?q?1w61VdyQUt19BQ+Y9bCrAbLPLzR0/7rMbYAQMhMwyo3+bnD81w1p0RWWKIAq?=
 =?us-ascii?q?6WKqfSvESS5u0xPuaMZJUauCrnJ/c54P7uiGczmUUBcqmxwZsXdHe4E+xhI0?=
 =?us-ascii?q?WcZnrsmdEBHn0WsQUgV+HqkkONXiNTZ3moQ6Iw/C00CIWjDY3bXICinKSB3D?=
 =?us-ascii?q?unHp1Rfm1JEV6MEXb2eIWARvgMczmfIsFgkjMaUbiuVpQh2g+1tAPgzLpnNO?=
 =?us-ascii?q?XU8DUCtZ3/zNh1+/HTlRYq+DxvFcud12GMTmB0n2MOXDI5xqZ/rlFnyleE0K?=
 =?us-ascii?q?h3nuZUGsBU5/NMSg06L4LTz/RmC9DuXQLMZs+JR0y7QtWiGjwxVsg+w8IKY0?=
 =?us-ascii?q?pkHtWiiRfD3zC0DLMPi7OLA5k0+LrG33ftP8Z912rG1K45glkiQ8tPM3Cmh6?=
 =?us-ascii?q?Fm+wjQGYHJiUOZmLiudakHwi7N+3mMzXCUsEFbTgFwS6PFUm4bZkfMqtT5/E?=
 =?us-ascii?q?zCRae0Cbs7KgtB1dKCKqxSZ93tjFVGQurjOdvHb2KsnWewBBGIxrWCbIrxYG?=
 =?us-ascii?q?gdwirdB1YekwwJ/naJKxI+BiG/rGLaFjBuEkjvY0z0++lktHy7VlM0zx2Nb0?=
 =?us-ascii?q?B507q1+xgVheGTSv8K0LIEozoupCtqHFmj29LbEMSApwV/c6VGe98940lI1X?=
 =?us-ascii?q?jftwNjOpysNadihkQRcw5vpUPhyw13CplckcgttH4q1xR9KaaZ0FNHajOZ0o?=
 =?us-ascii?q?v9OqPYKmbs5hCjca3W1U/E0NaQ5KgP7O40q1L5vAGmDkAi6Wlo08FJ03uA4Z?=
 =?us-ascii?q?XHFBcdUJzrXUYz7Bh6p6rXYjMj6IzJ1X1jK7W0viXe1NIuAet2giqnKvJeM6?=
 =?us-ascii?q?eDD0fJAcAACsSvYLgvmlutaQksJ/Jf7qM4PoWmaq3V9rSsObNbgD++jWlBqL?=
 =?us-ascii?q?t420aI+js0HvXExL4Z0vqY2U2BTD66g1C/5JOk0btYbC0fSzLsgRPvA5RcM+?=
 =?us-ascii?q?grJ94G?=
X-IPAS-Result: =?us-ascii?q?A2AnAQDUUgBc/wHyM5BlHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VUFKYE1MyeDeZQhUAEBBoEICCWJHpAgOAGEQAKDMiI3Bg0BAwEBAQEBAQIBb?=
 =?us-ascii?q?CiCNiQBgmEBAQEBAgEjFUEFCwsYAgImAgJXBg0GAgEBgl4/gXUFCKl0gS+FQ?=
 =?us-ascii?q?IRvgQuLCxd4gQeBOAyCX4gFglcCiRaCA4RRNFCPNQmRLAYYgVqINIcOmioig?=
 =?us-ascii?q?VUrCAIYCCEPgyeQeSEDMIEFAQGNPwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 29 Nov 2018 21:01:00 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wATL0wfi029482;
        Thu, 29 Nov 2018 16:00:58 -0500
Subject: Re: overlayfs access checks on underlying layers
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        Daniel J Walsh <dwalsh@redhat.com>
References: <CAJfpegs9JjkXguemL4qSiBvRP6Dnut-D+nJo-oLFXkfCL1Egvw@mail.gmail.com>
 <CAJfpegvfqx+0D32n1h2X7oj5d1mZWiLTcSSGpBnD+ba7AKzPyA@mail.gmail.com>
 <20181127210542.GA2599@redhat.com>
 <CAJfpegtQGM2z9TOt3DWwd39fC60cQknsC4vNnj7YimVEubRzUg@mail.gmail.com>
 <20181128170302.GA12405@redhat.com>
 <377b7d4f-eb1d-c281-5c67-8ab6de77c881@tycho.nsa.gov>
 <CAJfpegtNhcWD0VWy6LPtoDtQBfPu4x5iFsB053UMCidj6oMsuw@mail.gmail.com>
 <26bce3be-49c2-cdd8-af03-1a78d0f268ae@tycho.nsa.gov>
 <CAJfpeguL9xOh9Eq8LOP=ddJ4YD6nbp2UY6e2AYDVoHeCLuVhZA@mail.gmail.com>
 <6b125e8e-413f-f8e6-c7ae-50f7235c8960@tycho.nsa.gov>
 <CAJfpegv6y56k1-Tewu-Pu3x1W75LL6qYB6Hb6=n+2BJoNfEigA@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <c993dba4-5129-7f04-2724-a82a1f1cafa3@tycho.nsa.gov>
Date:   Thu, 29 Nov 2018 16:03:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAJfpegv6y56k1-Tewu-Pu3x1W75LL6qYB6Hb6=n+2BJoNfEigA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/29/18 2:47 PM, Miklos Szeredi wrote:
> On Thu, Nov 29, 2018 at 5:14 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
>> Possibly I misunderstood you, but I don't think we want to copy-up on
>> permission denial, as that would still allow the mounter to read/write
>> special files or execute regular files to which it would normally be
>> denied access, because the copy would inherit the context specified by
>> the mounter in the context mount case.  It still represents an
>> escalation of privilege for the mounter.  In contrast, the copy-up on
>> write behavior does not allow the mounter to do anything it could not do
>> already (i.e. read from the lower, write to the upper).
> 
> Let's get this straight:  when file is copied up, it inherits label
> from context=, not from label of lower file?

That's correct.  The overlay inodes are all assigned the label from the 
context= mount option, and so are any upper inodes created through the 
overlay.  At least that's my understanding of how it is supposed to 
work.  The original use case was for containers with the lower dir 
labeled with a context that is read-only to the container context and 
using a context that is writable by the container context for the 
context= mount.

> Next question: permission to change metadata is tied to permission to
> open?  Is it possible that open is denied, but metadata can be
> changed?

There is no metadata change occurring here. The overlay, upper, and 
lower inodes all keep their labels intact for their lifetime (both 
overlay and upper always have the context= label; upper has whatever its 
original label was), unless explicitly relabeled by some process.  And 
when viewed through the overlay, the file always has the label specified 
via context=, even before the copy-up.

> DAC model allows this: metadata change is tied to ownership, not mode
> bits.   And different capability flag.
> 
> If the same is true for MAC, then the pre-v4.20-rc1 is already
> susceptible to the privilege escalation you describe, right?

Actually, I guess there wouldn't be a privilege escalation if you 
checked the mounter's ability to create the new file upon copy-up, and 
checked the mounter's access to the upper inode label upon the 
subsequent read, write, or execute access.  Then we'd typically block 
the ability to create the device file and we'd block the ability to 
execute files with the label from context=.

But copy-up of special files seems undesirable for other reasons (e.g. 
requiring mounters to be allowed to create device nodes just to permit 
client's to read/write them, possible implications for nodev/noexec, 
implications for socket and fifo files).
