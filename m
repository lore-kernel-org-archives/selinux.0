Return-Path: <SRS0=k4Wl=RH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE746C43381
	for <selinux@archiver.kernel.org>; Mon,  4 Mar 2019 18:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A17D206BA
	for <selinux@archiver.kernel.org>; Mon,  4 Mar 2019 18:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="YgKt7wk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfCDSwX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:52:23 -0500
Received: from uphb19pa08.eemsg.mail.mil ([214.24.26.82]:9329 "EHLO
        USFB19PA11.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726162AbfCDSwW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Mar 2019 13:52:22 -0500
X-EEMSG-check-017: 117533107|USFB19PA11_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Mar 2019 18:52:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1551725539; x=1583261539;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=mOcW812sxEX8GI7oCIGPziVYsszmewLiDhWIvfUWgfQ=;
  b=YgKt7wk6W5ZkBdrI4+ONzwBUf0ket7NEEm6I+arUTTZAM9PX68oLNRe/
   aBUbmVRoTP9VEpOLZjxDNXxdA4D/jDrHaCl2RQ2XKwiJsXe75jN34v9fR
   BZlEy4N1IL6RLkQ3BNkSjCxiW6lPRgJonBOYnNKtIBJSDhrxoyW2wD6/H
   jb/20bfHTMOl02rworMu1pEBaaQJF85ylu3KURMIIw5zMJov+IHASpeqO
   jSjRUJQiawfQc1UH85xhx613mNx7+626MypQZNXIHJ8VtP3lM+S1gAUVM
   mVw0sMLrU6IgwQtv1Eg0Q3VxAidxgWVPIkPlmFwL+8e12kg5ByKWSmR+U
   A==;
X-IronPort-AV: E=Sophos;i="5.58,440,1544486400"; 
   d="scan'208";a="21103139"
IronPort-PHdr: =?us-ascii?q?9a23=3AadNgGxXY5asCdPP9fylRymMZLdrV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRGDv6dThVPEFb/W9+hDw7KP9fy5ASpYuN6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vMBm6txndutQLioZ+N6g9zQ?=
 =?us-ascii?q?fErGFVcOpM32NoIlyTnxf45siu+ZNo7jpdtfE8+cNeSKv2Z6s3Q6BWAzQgKG?=
 =?us-ascii?q?A1+dbktQLfQguV53sTSXsZnxxVCAXY9h76X5Pxsizntuph3SSRIMP7QawoVT?=
 =?us-ascii?q?mk8qxmUwHjhjsZODEl8WHXks1wg7xdoBK9vBx03orYbJiIOPZiYq/ReNUXSm?=
 =?us-ascii?q?RbXsZVSidPHIWyYYUSBOYFJOpVr43wq14IoBCjBwejGfnvxydViHHo06000+?=
 =?us-ascii?q?cvHw/I0wMvHd0BrHvaoc7pNKoQS+250LXEwDvBYv5QxDzz6JLIchckofyUQL?=
 =?us-ascii?q?xwbdTeyVEvFwzbiFWbtJHrPzaP2eQJt2iU8ephXv+ohm48tg5xuSOixtssi4?=
 =?us-ascii?q?bVhoIVzUrI9SNiwIkvP9G4R0l7YcC9HZZWqiqUNJN2T9s/T2xntys20L0LtY?=
 =?us-ascii?q?OhcCQUx5kr2QTTZ+GBfoOV+BzsTvyRLi19hH99fbK/gAu9/la4x+3nU8m0zE?=
 =?us-ascii?q?5Kri1YktnQrnwN1wLc6syASvZl4keuwyyP1wHO6uFfO0w0iaraJIIhwr43jJ?=
 =?us-ascii?q?YTt1jMHjTql0nsia+Wd0Ek9vCp6+ThfLrmuoeRO5J7hwzxKKgjmtGzDf4mPg?=
 =?us-ascii?q?UBQWSX4/mw2KXm/ULjQbVKivM2krPesJDfPckbvbO2AxRO34Y/6xewEzem0N?=
 =?us-ascii?q?MCkXkBN1JKYgiLj4fuO1HQOPz4F+uwg0ywkDd3wPDLJqbhDY/JLnnDkbbgfb?=
 =?us-ascii?q?B95lVGxwo10N9f/ZVUCrAcL/7pRkDxs9nYBAcjMwOo2+bnFMl91oQGVGKRDa?=
 =?us-ascii?q?+ZN6PTvkWM5u80OemDepIauDbnJPg5/fLhkXg5mVoFd6mzwZQXcGy4HuhhI0?=
 =?us-ascii?q?iBZHrsg9QBEWMNvgolV+Hqk1yDXiBJZ3msQq085ys3CIK7DY3bXICinKSB3D?=
 =?us-ascii?q?unHp1Rfm1GDVWMEXDzd4WCQfgDdDydL9R7kjMaSLehS5Uu1Q20uADmzLpnK/?=
 =?us-ascii?q?Le+jcEupL7yNh1++rTmAkp+jx6DsSSzWWNQHxvnm4TST823b5woUhgxVeYz6?=
 =?us-ascii?q?d4mOZUFdtJ5/NGSg06L4LTz/RmC9DuXQLMZs+JR0y7QtWiGjwxVsg+w8IKY0?=
 =?us-ascii?q?pkHtWiiRfD3zC0DLMPi7OLA5k0+LrG33ftP8Z912rG1K45glkiQ8tPM3Cmh6?=
 =?us-ascii?q?Fm+wjQGYHJiUOZmLiudakHwi7N+3mMzXCUsEFbTgFwS6PFUm4bZkfMqtT5/E?=
 =?us-ascii?q?zCRae0Cbs7KgtB1dKCKqxSZ93tjFVGQurjOdvHb2KsnWewBBGIxrWCbIrxYG?=
 =?us-ascii?q?gdwirdB1YekwwJ/naJKxI+BiG/rGLaFjBuEkjvY0z0++lktHy7VlM0zx2Nb0?=
 =?us-ascii?q?B507q1+xgVheGTSv8K0LIEozoupCtqHFmj29LbEMSApwV/c6VGe98940lI1X?=
 =?us-ascii?q?jftwNjOpysNadihkQRcw5vpUPhyw13CplckcgttH4q1xR9KaaZ0FNHajOZ0o?=
 =?us-ascii?q?v9OqPYKmbs5hCjca3W1U/E0NaQ5KgP7O40q1L5vAGmDkAi6Wlo08FJ03uA4Z?=
 =?us-ascii?q?XHFBcdUJzrXUYz7Bh6p6rXYjMj6IzJ1X1jK7W0viXe1NIuAesv0gygcMtHMK?=
 =?us-ascii?q?OYCA/yFNUXB8yvKOwshlioYQsIPPtM+6EoIsOmbfqG2LKrPep5mTKminlI4J?=
 =?us-ascii?q?150k2S7Cd8VOHI0Igfw/2C3QuISS38jFG/vcDzg4xEYisSHmXsgRTjUatYfK?=
 =?us-ascii?q?46Ro8PGHW/JYXj3dx6loz8XVZR8lK5AFIKnsSufEzWJ2L8wwBTnWsQsHWj0X?=
 =?us-ascii?q?+mwDtlmjUBtKeT3CXShe/lcUxDcktKR21llh/XM4WugtwbFBytbgstkwCN/l?=
 =?us-ascii?q?T33aVXpeJ/Mj+Ab11Pen3NM2x6Uqa2/oGHaspL5YJg5T5bS8ygcFuaTfj7uB?=
 =?us-ascii?q?Jc3CT9STgNjAsnfi2n782q1ydxj3iQeTMq8SvU?=
X-IPAS-Result: =?us-ascii?q?A2CuBQAdc31c/wHyM5BlHAEBAQQBAQcEAQGBZYFhBSqBO?=
 =?us-ascii?q?DOEL5NlTAEBAQEBAQaBCC2JPJBgOAGEQAKEJSI4EgEBAwEBAQIBAwIBbCiCO?=
 =?us-ascii?q?ikBgmYBAQEBAgEjFUEFCwsYAgImAgJXBgEMCAEBF4JIP4FpBQipJoEvhUSEZ?=
 =?us-ascii?q?oELJIsoF3iBB4E4gmuEO4NQglcChzaCWoIIhRg7khkJizuDOoN5BhmBdIkqi?=
 =?us-ascii?q?ASKZJQoIYFWKwgCGAghD4MokGghA4E1AQGNQQ8XBIIjAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 04 Mar 2019 18:52:17 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x24IoSsM026122;
        Mon, 4 Mar 2019 13:50:28 -0500
Subject: Re: overlayfs access checks on underlying layers
To:     Mark Salyzyn <salyzyn@android.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        Daniel J Walsh <dwalsh@redhat.com>,
        LSM <linux-security-module@vger.kernel.org>
References: <CAJfpegs9JjkXguemL4qSiBvRP6Dnut-D+nJo-oLFXkfCL1Egvw@mail.gmail.com>
 <CAJfpegvfqx+0D32n1h2X7oj5d1mZWiLTcSSGpBnD+ba7AKzPyA@mail.gmail.com>
 <20181127210542.GA2599@redhat.com>
 <CAJfpegtQGM2z9TOt3DWwd39fC60cQknsC4vNnj7YimVEubRzUg@mail.gmail.com>
 <20181128170302.GA12405@redhat.com>
 <377b7d4f-eb1d-c281-5c67-8ab6de77c881@tycho.nsa.gov>
 <CAJfpegtNhcWD0VWy6LPtoDtQBfPu4x5iFsB053UMCidj6oMsuw@mail.gmail.com>
 <26bce3be-49c2-cdd8-af03-1a78d0f268ae@tycho.nsa.gov>
 <CAJfpeguL9xOh9Eq8LOP=ddJ4YD6nbp2UY6e2AYDVoHeCLuVhZA@mail.gmail.com>
 <20181129134943.GA16762@redhat.com>
 <fe78aaed-5fb1-3c51-1330-39de46ae39c5@android.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ae2682f2-4a15-39e6-eb49-b9c0e72f10e4@tycho.nsa.gov>
Date:   Mon, 4 Mar 2019 13:44:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <fe78aaed-5fb1-3c51-1330-39de46ae39c5@android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 3/4/19 12:01 PM, Mark Salyzyn wrote:
> On 11/29/2018 05:49 AM, Vivek Goyal wrote:
>> So will override_creds=off solve the NFS issue also where all access will
>> happen with the creds of task now? Though it will stil require more
>> priviliges in task for other operations in overlay to succeed.
> 
> NFS problems seems to have ended the discussion, too many stakeholders? 
> too many outstanding questions?
> 
> Do we accept the limitations of the override_creds patch as is, and then 
> have the folks more familiar with the NFS scenario(s) build on it?
> 
> [TL;DR]
> 
> After looking at all this discussion, it feels like a larger audited 
> rewrite of the security model is in order and override_creds=off may be 
> a disservice (although expediently deals with Android's needs) to a 
> correct general solution. I admit I have little idea where to go from 
> here for a general solution.
> 
> As far as I see it, the model of creator && caller credentials is a 
> problem for any non-overlapping (MAC) privilege models. This patch 
> allows one to drop any creator privilege escalation, re-introducing the 
> "caller" to the lower layers.
> 
> As such I would expect a better model is to _always_ check the caller 
> credentials again in the lower layers, and only check the creator 
> credentials, some without caller credentials, for some special cases? 
> Change an && to an || for some of the checks? What are those special 
> cases? I must admit _none_ of those special cases need attention in the 
> Android usage models though making it difficult for me to do the fight 
> thing for the associated stakeholders.

As I recall, there were multiple problems with using current process' 
creds for the operations on the lower/upper/work directories:

- Some overlayfs operations on the lower/upper/work directories required 
privilege (capabilities) that the current process might lack, e.g. to 
set ownership and the like on upper or work files, to set special xattrs 
used internally by overlayfs for whiteouts or similar purposes, to act 
on files within the work dir which was inaccessible to the current 
process to prevent accessing files in an incomplete state, etc. 
Originally that was handled by temporarily elevating the effective 
capabilities around the privileged operation in the overlayfs code but 
that didn't help with the SELinux or other LSM capability checking that 
was triggered upon the capable calls.  Without some change there you'd 
have to allow all client process domains all of the relevant 
capabilities in policy, greatly increasing their privileges.

- The original logic was checking access to the lower dir/files in the 
context of the current process when performing some operation that 
modifies the file content or metadata, thereby triggering a SELinux/LSM 
write or similar check, even though the actual data or metadata 
modification occurs to the copied-up file instead and does not affect 
the lower dir/files.  That was preventing making the lower dir/file 
labels read-only to the client processes in the policy, which was 
desired for the container use case.

You'd need to solve those problems in some way.

> The lower privileged application access to the directory cache inherited 
> by other callers troubles me (not for Android, but in general) and feels 
> troublesome (flush out the directory cache? how to tag the privileges 
> associated with the current instance of the directory cache?). Some 
> operations (eg: delete a file for incoming, create mknod in upperdir) 
> are special cases requiring the checking of caller credentaisl to 
> function (not a problem for Android as the caller that deletes a file 
> just so happens to have the necessary privileges).
> 
> Also, mount namespaces (in upper, lower, etc), how will they affect this 
> all, is there a need for more attention to this as well?
> 
> -- Mark

