Return-Path: <SRS0=GWJJ=7B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96402C433E0
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 00:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AEA020756
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 00:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eT0/88DB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgESAQi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 May 2020 20:16:38 -0400
Received: from sonic309-28.consmr.mail.ne1.yahoo.com ([66.163.184.154]:41828
        "EHLO sonic309-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726284AbgESAQh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 May 2020 20:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589847396; bh=DlDwV3R9EV7zpitP70pUfPifYopakRHlIfL6UPmKrH0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=eT0/88DBAZBMNfCxPgp7YrnpyM0PZX+S2CDSMSQMUFVdp94D4AO6AFCYlyh/EvBnMzG835QU1uC6lpuMgv47Iys1voHXTebzo+mtYYgarqQJoCqQGObmNx291RQaLXIPStIf4aZUFony5LQmvfVNo+wgjvf291GCXjFpf1xAoCJzpf/xfS1gZV4Ddb/dfwP1JPtKg9FxZtZRk1KW1QttY2ANI5qqX+QASGidEZUn5RgOVF6BsUy2Ro+KYaSIcb/3yHbiv8n4lBRiTwTBoP81l8IgPwQvOSdqnmvoQWSV8nf6VGvZRfc9IVzD2B1VC7bYhzSIZJAyGJkEjAoQW9iJ1w==
X-YMail-OSG: 9A_lv8MVM1lsONPCRm45pW.7pJtSwwHnmkvGYM5kvgzs7Nu8k4mhAZ4wroi0dXo
 hC9239F8hD6qQhvTFrwRVrSbgQr4vFm5ncSS8T1cm4TDv7NzN.WZmkxzQFDTVl6Z45dVUOAmrtDm
 y1n11vm6J33EOUeQ2lkT6clPPZsTl3.r1qpidBpGH4hnRlDr9JkODk_goCZpXFPENh6UaeNlj.yo
 5FZkkMER9k6QR60glaIFL.xE4ec_rsfUdpa94FSs6KoYkc2OUPWTtghA79ZhdtU10mZYw0FBYIQl
 8vv6lVp_jLoKp0wK6gAVD7PedTvJ4C.s9y1V49WwKORNmMKjM3s6qjcFYU25HP8IJMvCCa._JubD
 4CfYbjXe.znwqjXHx3mRklleubxETdXb3HYn2O8epHTGPY8NNhpbhfDHuH5yJcHgrGrPoeXO77C_
 47ZIhsnXUFK9Y7Z8pYRMSfi8TOqX1DvVB78_7uHxzFalpq3.hd8RNCfkvupuEEzVOfou8fihbwiD
 WPNfCYbitblVWZcNuf3qG6bvRrXXpTGARRNYo6RDhw1ltc3iwmc4S5.sdOYVOgdTDc9UAKBH9IzW
 TQyW_.HcFP3upUfq_FcAhLgZRd.H9ynFZulZSXqLyoZ3j0_S1gTor_8BOuf3ZC40pVEjkwoRhv2E
 qsbH72KzbwE9qsMy6DWX5x1MtKDn3Y4sjIoW.rILJuiXdRO6W3BOxf92Fx.qryosJZ_4cmRdquGR
 cQyMuUOaDgvIsSHMvvJBv4zg8GUvXzGy.wvtgfJFVdTG_43t17Svw88X2Fu8rAxOqjeEj6RnGcFy
 G.UYrBpGtIVpOfzVJns9qxktHn_IYKwOVAff.k4Jdx0VvZNZw7enUPwlrIpST1AvMkWrG8.QV4X_
 jk5dnjcyNDq4fZWvqq41TGhkUj5RkMui06DpJdD5e472fDHcfMxHTuD5Ysg6hbcqUE2gV2MXIoTt
 8M1lqrHsR.q8QYSf6BCkVCHJF9sXUampymclBK.KHc0RpuGu1KrmdUzW9vM.UVxYqXHuwVfmyfY.
 vKsKZUds2Nj3_K.ewtoPRzq8NcgInWhXVWqkkJK99S85_RX3BY5Znymu2eGQVOhL.MN2Qr4mx6Nh
 5nvUXRMw9_K6Dccd3YtGWgcdq279dkFuV.v5uIwUsr9esG9QnmQ0Cs.dACMp.L6AslVz.QkR0whw
 iKzag_x6wDWPlQonsapO8mWitKQm4ip5lflRQyhMmJHiAIEmjiChsyP0Ko2vCS5hJGOxVSBsNNwn
 ViWaj07SYUqBzFLz7U5U75eWHGsq2T6LqPwzdpysqj3bQq1vZ2hjtpYJ0_xrqdbPaKLVaewfnfbw
 0fGrXgN35xCHKOVNSyqkgRZsIttB8ot3yi5yW1mOByi7nm_yDWwbFu0ERggmssx4jhXuwSiPddYM
 wy0zmEhuQaLiMQQE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 19 May 2020 00:16:36 +0000
Received: by smtp414.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 641f2f288b5f82f12c5d2f54f5ca24f8;
          Tue, 19 May 2020 00:16:35 +0000 (UTC)
Subject: Re: [PATCH v17 20/23] Audit: Add a new record for multiple subject
 LSM attributes
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>, linux-audit@redhat.com,
        Steve Grubb <sgrubb@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200514221142.11857-1-casey@schaufler-ca.com>
 <20200514221142.11857-21-casey@schaufler-ca.com>
 <CAEjxPJ67cA_A-Oh72EGgmCrP6k9x0PuaU2q7UL9eOc+J6Do0zQ@mail.gmail.com>
 <9cabbb54-69e6-91e6-88f8-e76d53da2a77@schaufler-ca.com>
 <CAHC9VhRGopG0=DbEZArz2X2yfEQ1pOqoSLRMn9ABe5JYZB2Y8Q@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <774a37e3-3469-d606-a468-a57892b44645@schaufler-ca.com>
Date:   Mon, 18 May 2020 17:16:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRGopG0=DbEZArz2X2yfEQ1pOqoSLRMn9ABe5JYZB2Y8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15960 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/18/2020 3:21 PM, Paul Moore wrote:
> On Mon, May 18, 2020 at 4:43 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> On 5/18/2020 11:02 AM, Stephen Smalley wrote:
>>> On Thu, May 14, 2020 at 7:30 PM Casey Schaufler <casey@schaufler-ca.c=
om> wrote:
>>>> Create a new audit record type to contain the subject information
>>>> when there are multiple security modules that require such data.
>>>> This record is emitted before the other records for the event, but
>>>> is linked with the same timestamp and serial number.
>>>>
>>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>> Cc: linux-audit@redhat.com
>>>> ---
>>> With this patch, I see userspace audit records like this one:
>>>
>>> type=3DSYSTEM_BOOT msg=3Daudit(1589816792.181:103): pid=3D789 uid=3D0=

>>> auid=3D4294967295 ses=3D4294967295 subj=3D? subj=3Dsystem_u:system_r:=
init_t:s0
>>> msg=3D' comm=3D"systemd-update-utmp"
>>> exe=3D"/usr/lib/systemd/systemd-update-utmp" hostname=3D? addr=3D?
>>> terminal=3D? res=3Dsuccess'
>>>
>>> I'm guessing that userspace is appending the second subj=3D field whe=
n
>>> it sees subj=3D? or otherwise is missing subj=3D information?
>> I haven't looked at the userspace code, but I expect you're right.
>> It looks like there will need to be some change in the userspace
>> for the multiple LSM case. The "completion" shown here isn't correct,
>> because it only fills in one of the subject attributes, not both.
> Wait, didn't we agree on a a "subj=3D? subj_selinux=3DXXX
> subj_apparmor=3DYYY subj_smack=3DZZZ" format?  It looks like there are =
two
> 'subj' fields in the record above which is bad, don't do that please.

That's not something that's coming from the kernel.
I'll check again, but I think that everyplace in the kernel that
produces a subj=3D has been trained to create a type=3D1420 record
instead.

>
>>> Then we have kernel audit records like this:
>>>
>>> type=3DPROCTITLE msg=3Daudit(1589816791.959:101): proctitle=3D2F73626=
96E2F617564697463
>>> 746C002D52002F6574632F61756469742F61756469742E72756C6573
>>> type=3DSYSCALL msg=3Daudit(1589816791.959:101): arch=3Dc000003e sysca=
ll=3D44
>>> success=3Dyes exit=3D1056 a0=3D3 a1=3D7fff9ccc98a0 a2=3D420 a3=3D0 it=
ems=3D0
>>> ppid=3D773 pid=3D783 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D=
0 fsuid=3D0
>>> egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 comm=3D"aud=
itctl"
>>> exe=3D"/usr/sbin/auditctl" subj=3D? key=3D(null)
>>> type=3DUNKNOWN[1420] msg=3Daudit(1589816791.959:101):
>>> subj_selinux=3Dsystem_u:system_r:unconfined_service_t:s0
>>> subj_apparmor=3D=3Dunconfined
>>> type=3DCONFIG_CHANGE msg=3Daudit(1589816791.959:101): auid=3D42949672=
95
>>> ses=3D4294967295 subj=3D? op=3Dadd_rule key=3D(null) list=3D1 res=3D1=

>>> type=3DUNKNOWN[1420] msg=3Daudit(1589816791.959:101):
>>> subj_selinux=3Dsystem_u:system_r:unconfined_service_t:s0
>>> subj_apparmor=3D=3Dunconfined
>>>
>>> where we are getting multiple copies of the new record type, one for
>>> each record type that had subj=3D?.
>> While obviously wasteful, the type=3D1420 behavior is consistent with
>> the subj=3D? behavior, which is to duplicate the subj=3D value. I know=

>> we've got enough hobgoblins in the audit system that we don't need
>> to add any more in the name of a foolish consistency.
> You need to provide a bit more reason why we need byte-for-byte
> duplicate records in a single event.  As it currently stands this
> looks like something we definitely don't want.

The CONFIG_CHANGE record already duplicates the subj=3D information
in the SYSCALL record. I just maintained the duplication. You're
right, it's silly to have two identical type=3D1420 records for the event=
=2E
I will have to come up with a mechanism to prevent the duplication.
with luck, there's already a similar case for some other record.

>
> --
> paul moore
> www.paul-moore.com

