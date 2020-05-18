Return-Path: <SRS0=hs+S=7A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C575C433DF
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 20:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E959F20849
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 20:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DCkLVQEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgERUnG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 May 2020 16:43:06 -0400
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:46506
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726270AbgERUnG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 May 2020 16:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589834585; bh=ZaPSmBKZ5df8a3P62XIc9RvmXw+rVidjI0jKXOkwTBg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=DCkLVQEEaYNRDpG+PniSrj9nNrJIqec0rKl9GORELi5pFHh+Q48MvdMFZ13UuDiMXV9mjbSqxX0wfnKBTtZXbGiF54hIWjqyL6C4dL8YXcoEyCVl2J1G7NDyontPFFevsfK9SFblk1TdmFeIhx8T3e/5Z8jp0E1+OZFok8WrQMLgQefG3u7pLXqsGLsScOE2OKeHXUaefylDu9VkbtiZWLwmmMFHZ4rX3brPKhXKGfbfmCwsAHePqMlmp48CowlUxMwOSqww8tBvoqcoFtD2E/RfEZdfcHZre5m7a7tQ09ujPoahsc7g1qx2l1/GuIeedgKgZ4s/DCTjQaULwAWUyA==
X-YMail-OSG: QQ2Pmo8VM1nzKZV9eSey2PDRZnytyVUgJQ2i9k9DIzz1Dw18W7cY4uOaGLKZXd5
 BeUNrPjKKYXeTvsFBPY5c1jdheJ7qlGd7K7M9N8b1lxVLHiR0SfJfhbE51j838rUynK_tS3FZQeg
 i1EpvUdNsrcacmsUl_kKekQF4NrGU_Ul2w_rGjaM7D8sbf6yW7CR7GCk45SZpRR4Lj7slvN6vPpG
 R.ydB1i_6YLAG.CI7MZiL1wcub9eIvC3otX6nOlFV5X6RD7mfhuRjgXVzYDlqVN8KU4Ok5BqG05I
 0hJQolU9rJHtuUcbHR0mS5xgCppWUv_9KGnUFEc8fqiynY8XknioXRAjh2a3SXA7qSfQ7MZdvo2.
 noiaItbqU2eX7uhmk0gfVVHYBVgp7WBC1RiKa9TtAnRPuSgKpcPundNk_1_l6bT8nyZCeoQFpH11
 trkRRbpyacF4lDMC__GSuMkadkTshskcSghUm8ja.t30bK_utaEW_YP7TgFJZ.Kkgsv0y38Tevfi
 ZcCxgGBHXx3eX7at7walf4KYyRDtLztNJYbn0GoOfEwfUckjyXDu1Ucmm1Tw_.qqjiOh7pcoPjjn
 2Zw5jOD1BdZqJf8a8Civ5iCP49XAzssMzFi49VVX97v.DbAPsR4QwMnxxUH6g.n8Vsf392jQZnMN
 rsp.qNwHJgLNoAApXk0c0YIfuSkt.mNCOgHdy5kXE6HJ_gTm9g2YWd.hydP313wzp68O2gFk_KOO
 ALMKPcFOLYA9Z3OdL5e8HzLlrQrxzYBlOleMneytyIcKvHZaSdqljg0cudUxO8duGjTmL8AjuixV
 d.Cm6ZDD0bIZAZN2WMmvDMpDnG.o_wGAdJCD9KKfPUeDZRflqdZnSB0HjREFnB700h5klvyfMGoM
 LD3xysyYlJp7PCWKiRFOBFaHCVOk5sfjbGDkn0LSrCej8J8Tn5XoAjmAmCYXBb_GifE6jkBnpP0l
 hEWLbDh80EOhJSDxJoYoLlSJaXEGcwNDv8WZWAGgfe.6VgUb.4zzLnRGU89epG4gosdCASePzd5Z
 hZZIGIKqxHgioKOshypXDExsN4usO5EHUO_ZprzKIj31Y7FoBv4f5NZBYmhevVh9aXb_W6sQ69_g
 w11_PFHUJZUCUOrqMXztfAQB4FAYQ_jivzXdDFckYd7rsBO82hcd9S_3Ux5AHfL34R7JJPbJrtY8
 JmWFAKjOz483zg59L6Mw2dG04EjkrhL4yAneccZAvnF3Gl.RLxuuhmgHPVfvXgwnNUVTyF3wMx3C
 GIYTvXWwdsIreLZILQj5RyPAvdvadmjHFHdUr8CWxslZwLuIX2KclrSDquMFzzZ_bL8HT2mjRkGJ
 efOuzkd7bD7724rnTIewiUi7a6DajKvD1rCjRR1lokwygC88upiL6joUiqtvWPvBirQMfKn._JfE
 7Q_Gd50W2KDDyMcQGmA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 May 2020 20:43:05 +0000
Received: by smtp405.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 4cb43f4b09468ed915d9936384691d5b;
          Mon, 18 May 2020 20:42:59 +0000 (UTC)
Subject: Re: [PATCH v17 20/23] Audit: Add a new record for multiple subject
 LSM attributes
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, linux-audit@redhat.com,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
References: <20200514221142.11857-1-casey@schaufler-ca.com>
 <20200514221142.11857-21-casey@schaufler-ca.com>
 <CAEjxPJ67cA_A-Oh72EGgmCrP6k9x0PuaU2q7UL9eOc+J6Do0zQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <9cabbb54-69e6-91e6-88f8-e76d53da2a77@schaufler-ca.com>
Date:   Mon, 18 May 2020 13:42:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ67cA_A-Oh72EGgmCrP6k9x0PuaU2q7UL9eOc+J6Do0zQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15960 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/18/2020 11:02 AM, Stephen Smalley wrote:
> On Thu, May 14, 2020 at 7:30 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> Create a new audit record type to contain the subject information
>> when there are multiple security modules that require such data.
>> This record is emitted before the other records for the event, but
>> is linked with the same timestamp and serial number.
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: linux-audit@redhat.com
>> ---
> With this patch, I see userspace audit records like this one:
>
> type=3DSYSTEM_BOOT msg=3Daudit(1589816792.181:103): pid=3D789 uid=3D0
> auid=3D4294967295 ses=3D4294967295 subj=3D? subj=3Dsystem_u:system_r:in=
it_t:s0
> msg=3D' comm=3D"systemd-update-utmp"
> exe=3D"/usr/lib/systemd/systemd-update-utmp" hostname=3D? addr=3D?
> terminal=3D? res=3Dsuccess'
>
> I'm guessing that userspace is appending the second subj=3D field when
> it sees subj=3D? or otherwise is missing subj=3D information?

I haven't looked at the userspace code, but I expect you're right.
It looks like there will need to be some change in the userspace
for the multiple LSM case. The "completion" shown here isn't correct,
because it only fills in one of the subject attributes, not both.

> Then we have kernel audit records like this:
>
> type=3DPROCTITLE msg=3Daudit(1589816791.959:101): proctitle=3D2F7362696=
E2F617564697463
> 746C002D52002F6574632F61756469742F61756469742E72756C6573
> type=3DSYSCALL msg=3Daudit(1589816791.959:101): arch=3Dc000003e syscall=
=3D44
> success=3Dyes exit=3D1056 a0=3D3 a1=3D7fff9ccc98a0 a2=3D420 a3=3D0 item=
s=3D0
> ppid=3D773 pid=3D783 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D=
0 fsuid=3D0
> egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 comm=3D"audit=
ctl"
> exe=3D"/usr/sbin/auditctl" subj=3D? key=3D(null)
> type=3DUNKNOWN[1420] msg=3Daudit(1589816791.959:101):
> subj_selinux=3Dsystem_u:system_r:unconfined_service_t:s0
> subj_apparmor=3D=3Dunconfined
> type=3DCONFIG_CHANGE msg=3Daudit(1589816791.959:101): auid=3D4294967295=

> ses=3D4294967295 subj=3D? op=3Dadd_rule key=3D(null) list=3D1 res=3D1
> type=3DUNKNOWN[1420] msg=3Daudit(1589816791.959:101):
> subj_selinux=3Dsystem_u:system_r:unconfined_service_t:s0
> subj_apparmor=3D=3Dunconfined
>
> where we are getting multiple copies of the new record type, one for
> each record type that had subj=3D?.

While obviously wasteful, the type=3D1420 behavior is consistent with
the subj=3D? behavior, which is to duplicate the subj=3D value. I know
we've got enough hobgoblins in the audit system that we don't need
to add any more in the name of a foolish consistency.

> Not sure what it is the audit folks want here.

I doubt that redundant type=3D1420 records are a good idea, but having
seen some of the other active threads about useless fields I am not
going to assume what is most appropriate.

> This is with multiple LSMs enabled; need to confirm that no change
> occurs if only one is enabled.

