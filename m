Return-Path: <SRS0=Oqwf=4H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C124C3405F
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 17:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8B220801
	for <selinux@archiver.kernel.org>; Wed, 19 Feb 2020 17:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XLmzI6L9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgBSRuz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:50:55 -0500
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:43401
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726605AbgBSRuy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Feb 2020 12:50:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582134653; bh=dMHt3NVNLybpPuyWDQFYcjwpVBDVXKoI0HnyFMwmJiE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=XLmzI6L9KPB9e+s6CFqvs/lpKf1Q//kY22yBeBUzInjicFyARCMVa/MqCkULBzIxdXn9ITOaMGaFwPCI06z5iCDAPbuWRNrofYrF83te63rRsGi9ipnTRkDuP+vEmchh2Z/ec3IGAcuYq3y3KnywCDmnfxccar/QMjiH+zxkMiVHx8gc2wo/d7mGKgU/zI46SBQfl8uCNGUhgUvJQlVnZ7TWe7dzx7qZ2yQrYD//y9UXQMAPvjfUGAI81OzIMbgRlm1tiTKarPv8ky9m6kZIMkMU260swIInoIV4P9MUy338jCMouFrDcSu/GueV3Otg/huG1f1XjSZyWvm08kfqAw==
X-YMail-OSG: 6zKESHAVM1lVLwnMGHPAk.OYmuLC7T2Bo4hUUb8Y9KdkeFrZa3RyYEKh4d5ASUZ
 n4tOZBIXsV0y7QsjPuQI.6rdBOibAQjoeUHsbRzh_67iUFZl5MsAjph5iQnnlrdLBZzL2Cnu.iT8
 mfCIvvUasxB7mISn41JQmf30Yae49IxXvfTEw.z3tg.rwbguWtwtAxdEgruQi4pIiGh5VMo3g_XU
 Xo4t_r_sNJo0KOaiHCTxF56BRlD1jA.Nz24GcR94BQ9wx2ag6AYQAzdvSVWh8JbeZxP8bzaHq0jA
 ICSfGCaJO.0ziGZjLVm7IEVVbfzrq2cQqf4Fw6ruWcPd4QVsMyENtfMQtCszOqGexK3CZPa5oXoK
 vHuAzdY5s4FCj6LB8NPX3Qw0vE6iqg3gff5cGmC6y0N0IRgwttMcufp4LG4I6NeUN5VLJkDoR9EL
 CtmqGmXwLGtxSSPF93cHm35VQKg4FIACRGx3ZIl5ONuzpLYe6PhgeJBxzm929_BJeeEc2FN2Wm2v
 OUrQjfuOsD0xUHpzdWIusO1VIOt0cTfVLc8s781Yt.1OJL_a935YMsRz44KbbfCAjX6k.nLFut15
 Qzf6Qmb_VtGh9VRqRBLZcPl2BqadTPtyO8ihyByp0dJEzGUwabmLXl5XEDcMjzCC3yS0UCq4hTvp
 ufXqEoNsrAV4bRg4ORRQ73.ASKh5Az.rBZfE6O2gjcthJqUGFGPHZIsLlFuoQWyO4w5HZg0y39pH
 .hlEuA8RgDKTMZe7p3_rIKuDZu1T7dMv1JeVxp.jLF8kdZAx3OAHKwcmrhCX6KsWItAd_d0EYkH9
 xvAqXtNHzVVuA9At9UB5nwmYxH7NLm.sJpYom_42fINdve7.w6SBZlRMsbyZCWRNhWKB4GHb40rR
 TJR7r7CbKg7fzxH.PWjvMx2cnWZr9.JlRPYI7FhNfiW02YJs0nlFg5Qj1EpPJtDVpH6vnLuhXxI_
 d62.eaurhreE6ejWSB625rpPYZheUzx4xSGV5udRPTYG3R6dljm0qkrBJnNt4vOu6sqPyJLINdkY
 FxnQXLSPRqBw212m3fpdwTdqcl7YagH5GHhmjZD2FeE3HfL3WIz9z3nSWX3QxA9.cLtW35bsqkGy
 YnV2nCVhYE9uCYu2.jQ.waVcCsZwBxFgbvE6bczQIBvsQewr0iyP2GJBOEcADx33DLIWTA6QKCYP
 7s8Mg76q_mK7WypwiSlabFihD8wSkM4FZvpvk_rVdDGBv9t.1lsw2npa8JfyhEqstKXl9vuzeKul
 Wy8VoKRyj4jAfWEG9Vcw5Ri7f6oc2ZsdNBuZl7qf1vyhuez5bipwP4bcy.m0COugr8LjfVNrPde3
 OwjBltauE6xYnkzft8eBVnsIZbUgMi5nXPlpr4vCVuA74A3I45yMrAEUuszotHRopf2axflODB8y
 hqKCukP.OgiRXBgOM0aETOG0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 19 Feb 2020 17:50:53 +0000
Received: by smtp408.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7471373336754768b40cc8acd4e8b743;
          Wed, 19 Feb 2020 17:50:51 +0000 (UTC)
Subject: Re: SELinux support in virtio-fs
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Daniel Walsh <dwalsh@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, virtio-fs@redhat.com,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
References: <20200210160639.GA411895@stefanha-x1.localdomain>
 <bbcbd9a0-a036-1c1e-ed66-ac2aaca454a5@redhat.com>
 <CAFqZXNsL4nC4N2XKgMmTNJGCayJ1E=ppiKCBhv2yFCt39dLWqg@mail.gmail.com>
 <6df9b58c-fe9b-28f3-c151-f77aa6dd67e7@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <f8d5d438-8d99-dc06-fc66-3ca3a4dcfcbc@schaufler-ca.com>
Date:   Wed, 19 Feb 2020 09:50:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <6df9b58c-fe9b-28f3-c151-f77aa6dd67e7@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.15199 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/19/2020 8:44 AM, Stephen Smalley wrote:
> On 2/19/20 11:11 AM, Ondrej Mosnacek wrote:
>> On Wed, Feb 12, 2020 at 4:29 PM Daniel Walsh <dwalsh@redhat.com> wrote:
>>> On 2/10/20 11:06 AM, Stefan Hajnoczi wrote:
>>>> Hi Dan,
>>>> I've CCed the public virtio-fs mailing list because SELinux support in
>>>> virtio-fs has been asked about recently.
>>>>
>>>> It's time to figure out what level of SELinux support will be available
>>>> in virtio-fs.  The file system client shares most of its code with FUSE
>>>> and SELinux labels on files are currently not supported in FUSE.
>>>>
>>>> It would be possible to pass through extended attributes to the
>>>> virtiofsd daemon running on the host.  However, passing through xattrs
>>>> allows the client to relabel files on the host file system and this
>>>> could pose a security problem.  virtiofsd already allows the client to
>>>> set the uid/gid and permissions, but is passing through SELinux xattrs a
>>>> bad idea?
>>>>
>>>> virtiofsd is in a position to mangle extended attribute names
>>>> ("security.selinux" -> "virtiofs.security.selinux") in order to separate
>>>> guest SELinux labels from host SELinux labels.
>>>>
>>>> As someone who knows very little about SELinux I'm eager to hear what
>>>> you think would be a good approach.  Secure containers (e.g. Kata
>>>> Containers) are an important use case but virtio-fs can also be used as
>>>> the root file system for a guest (a scenario where full SELinux support
>>>> is needed).
>>>>
>>>> Thanks,
>>>> Stefan
>>>
>>> I am traveling right now.  We should add in the SELinux team, and I will
>>> be able to look at this on Friday.
>>
>> Cc'ing the upstream SELinux mailing list for more insight. Here is a
>> public archive of the full thread:
>>
>> https://www.redhat.com/archives/virtio-fs/2020-February/msg00005.html

Also adding the LSM mailing list. This could be interesting for
any security module that uses extended attributes.

>
> FWIW, there were previous attempts to add FUSE support for per-file SELinux labeling (rather than just a single genfscon-based or context= mount option label for all files in the mount) but there were problems:
>
> - deadlock during mount with userspace waiting for mount(2) to complete and the kernel blocked on requesting the security.selinux xattr of the root directory as part of superblock setup during mount [1] [2].
> [1] https://lore.kernel.org/selinux/1280234607.4789.6.camel@moss-pluto.epoch.ncsc.mil/
> [2] https://lore.kernel.org/selinux/20120824195928.22970.16209.stgit@paris.rdu.redhat.com/
>
> - there was an attempt to introduce distinctions based on filesystem "subtype" so that whitelisted fuse filesystems could have xattr support enabled when it was known that their userspace would handle mount(2) safely [3] but this was apparently always broken and later reverted [4].
> [3] https://lore.kernel.org/selinux/20130416225619.GA30164@sh-el5.eng.rdu2.redhat.com/
> [4] https://lore.kernel.org/selinux/20131213195520.11231.81980.stgit@localhost/.
>
> - there is the issue of trusting the fuse filesystem for its labeling information and for domain/context transitions.  At the least, we'd need a permission check to gate which contexts a fuse filesystem could supply (e.g. the filesystem associate check), and by default nosuid mounts disable domain transitions (although it is possible to selectively allow them via nosuid_transition now).  Also, if a non-init user namespace mount, even if policy is configured to use xattrs (SECURITY_FS_USE_XATTR), we flip to using mountpoint labeling (i.e. implicit context= mount with the context derived from the mounter's context and matching type_transition rule if any) and we don't permit use of context mount options.
