Return-Path: <SRS0=4X/7=3D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89676C33CB3
	for <selinux@archiver.kernel.org>; Tue, 14 Jan 2020 23:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A31F24656
	for <selinux@archiver.kernel.org>; Tue, 14 Jan 2020 23:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="S4/SxxSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgANXGA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jan 2020 18:06:00 -0500
Received: from sonic306-9.consmr.mail.bf2.yahoo.com ([74.6.132.48]:39580 "EHLO
        sonic306-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728746AbgANXGA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jan 2020 18:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579043158; bh=L58bwoyBzCOKNSdPJbpgHsHMnN/Jn3KqRPkRQWVxpZ4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=S4/SxxSjnBFEij42ysR97NtZkvfO91wChD8zH4zziPP0WvQQJRwgDkL+4W33YEiTG8Nh7vGx6IRvGtHnk+uVgvQsfe2rP3bH/haXbcLQe1illXV3C898PSitWh9+YNp1lfVPbibFyxO/e0uuoUb2urpmRzebx5M3KXJ5IEeGKPiild2RhNTEgOH3/zKEZdijqP/bH0D9QGH3XoMY/w0UjkmGZeiP8zXISH+0JFl4ecG88kWZtI4P4NHRkbaaaDLixvv28nwVZdtd3q0KrKUZE4c1dC7zHTVJDx6HCZUcNnX8+KBSNi37R1CIBipuoEvZ5bO9QtQJMRXWSSvA3488iQ==
X-YMail-OSG: 4f9y1RcVM1k9RRReJ_hILbK0pHKWn8eo8OasgI1jgRtKT3y7g1WXkMz.INXzpoG
 aEzValkiMuXbVofr0pNB.llOIYEs8W.oFS5iclyJqEUQEN2bQcTy3Z6ujpYUJYjScFcUs46lwOXI
 B8CWujVWFzWRUncBRP7O48ODn7rn1JxrDmEPSKkR_foNVfs9G0dva9pc1YLWqwtXtec9kAE99rdS
 1lDLSh4EhAmZX7706fbXGDhT.kOjgaDxlLPV37my5zD.v6z9PeOB4L83ivEXBAg5M38k9wqoWj01
 3ex2VeQO7H_f4rzbsWhbWOetUg2.bhcyZSNYdjd7uqGh9_pySiMdcOMRBuRkJOmjG.s0yhaoPO7T
 LAv8n0.FO9DSEwyFsodnGb0z0tfNBtzMs3x9uWyRM8HXw5OWUZs_jrNWs6BnlbKN7ocHPy80KbsF
 fu87TT1k4IXiRIEacQf06hOBDJdWlBuCHmqUxF19okXSGinu9TDeMveYCHjtD9KzrnshyKdtTmMJ
 E0BBYIvrkMILfNVr6STuP3Wrj0BzqyCcZtjD8HTYGgihjx6mY2g_5DXJ1I1_dhP8hxq6d3bEVCQz
 Tbtr3GM_RR.wRC18uTCY3MMppLwSn1tSt78vM6z.1nIIoWtJHdnTYAcIY1HEPJ_RyCd78d8Uzer3
 5y9VYnEee1obPJYc3o5fdxqy4EWDzBMPOTmgLYZOHECmua4UYafFHp8MDABlWCTxYUs8LbDBsnRi
 b9pqmlJMqnCUHtZgNggknxlPdAebZ06h4NdOvX3R60Is179.7I7ds3miSUPAp1edX8WrT0hoBiOl
 FR6teTqwwSd85a_dJypIVgQeTa8XiDcwYHlXiGMWkXv8KzIcIX.h64nw5TUsw6HI3J9M6P9yt3CV
 IlEJcye5.yzrUy8uTIaMlruEG5FtPRcw8rEU9OBmbEBqUVD7uTVe6EfH4sWVPJvUMwunV2lZCrgs
 Fe45o.jpd9LClMH6aohqGScpTmJMvyUZ7o25dq7zPsPeeO2V2m9oMr6vbouHYD1uHpQ5HkjZXDoC
 P50w7jCkOLaF9MUXGH2JP7VHKL3ilxz.vq7Z07XZLO1Go2qQva5JK9c1pkir63iMjCTZcCg3Lcax
 R8PsACFNBM_rlLaGjTama296hYgxj4WntjY1Pf8LYSxT7Z4547AclDZUWnKOCTr_t5JFZjGtj4pN
 .oXGpjIHMicTQ_QcC2dpJisDMsXyvGHNT8VuThiQYUug8X89jvzCdaQAAPZKkXqhYKn2lbGZtjlt
 DsPcaddephl1vlwZVDIYzKImCB8iQZYHgZPGyNHht.upbBFfyxs0R5cbY7kvY0mRYW_OaNPUSdOA
 .87vobpsP.qG_FwLbROIrs095ZPD0CxwRno9ocUll6VOnLPRJWtkyjBnU5bdQKcvRGXNq9HzV_MN
 d1gzM3CNGTdwAM.6SMZBD_caKxtyNcHIN0nKUnzS7y716g2N4b7jCjSrqLctCcGhQS5gC_XMxJbq
 IoeVztPjNXV0EVPsQj806L8qyAYLNMgYproOmg5rpTv9yzt8iOR2RpK4EUIMmQ9lN8LUW7Pm4gQ-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Tue, 14 Jan 2020 23:05:58 +0000
Received: by smtp432.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d719e289febf502e36855def414175da;
          Tue, 14 Jan 2020 23:05:54 +0000 (UTC)
Subject: Re: [RFC PATCH] selinux: implement move_mount hook
To:     Stephen Smalley <sds@tycho.nsa.gov>, paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com, dhowells@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        richard_c_haines@btinternet.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200113161800.63865-1-sds@tycho.nsa.gov>
 <a5839718-8b75-8a8b-189b-bd19e4c85219@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <3af9d34d-63df-11a6-d358-79f257711b4f@schaufler-ca.com>
Date:   Tue, 14 Jan 2020 15:05:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <a5839718-8b75-8a8b-189b-bd19e4c85219@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/14/2020 6:33 AM, Stephen Smalley wrote:
> On 1/13/20 11:18 AM, Stephen Smalley wrote:
>> commit 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")
>> introduced a new move_mount(2) system call and a corresponding new LSM
>> security_move_mount hook but did not implement this hook for any existing
>> LSM.  This creates a regression for SELinux with respect to consistent
>> checking of mounts; the existing selinux_mount hook checks mounton
>> permission to the mount point path.  Provide a SELinux hook
>> implementation for move_mount that applies this same check for
>> consistency.  We may wish to consider defining a new filesystem
>> move_mount permission and/or a new dir(ectory) move_mount permission
>> and checking it in this hook in the future.
>>
>> Fixes: 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>
> NB I cc'd lsm list on this patch just as a heads-up/reminder that this hook hasn't been implemented for any security modules AFAICT, not just SELinux.  I see that there was some discussion of this in the past with a trivial patch proposed by Tetsuo to just disable the syscall when TOMOYO or AppArmor is enabled, but no action seems to have been taken,
> https://lore.kernel.org/linux-security-module/5802b8b1-f734-1670-f83b-465eda133936@i-love.sakura.ne.jp/
> https://lore.kernel.org/linux-security-module/1565365478-6550-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/
>
> The move_mount syscall does check may_mount() and hence requires CAP_SYS_ADMIN for the user namespace associated with the mount namespace, so both SELinux and AppArmor would at least restrict the use of this syscall to processes allowed CAP_SYS_ADMIN by policy, but TOMOYO doesn't implement the capable hook either so move_mount is entirely unrestricted by it at present.  Looks like Smack doesn't implement any mount checking so it doesn't care about move_mount (especially since it requires CAP_SYS_ADMIN already).

That's correct. Smack provides controls on subjects and objects. It leaves
the mundania of privilege to the capabilities mechanism.

>
>> ---
>>   security/selinux/hooks.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 0606e107fca3..244874b103ff 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -2766,6 +2766,19 @@ static int selinux_mount(const char *dev_name,
>>           return path_has_perm(cred, path, FILE__MOUNTON);
>>   }
>>   +static int selinux_move_mount(const struct path *from_path,
>> +                  const struct path *to_path)
>> +{
>> +    const struct cred *cred = current_cred();
>> +
>> +    /*
>> +     *  TBD: Check new FILESYSTEM__MOVE_MOUNT permission to
>> +     *  from_path->dentry->s_sb and/or new DIR__MOVE_MOUNT
>> +     *  permission to from_path?
>> +     */
>> +    return path_has_perm(cred, to_path, FILE__MOUNTON);
>> +}
>> +
>>   static int selinux_umount(struct vfsmount *mnt, int flags)
>>   {
>>       const struct cred *cred = current_cred();
>> @@ -6943,6 +6956,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>>       LSM_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
>>       LSM_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
>>   +    LSM_HOOK_INIT(move_mount, selinux_move_mount),
>> +
>>       LSM_HOOK_INIT(dentry_init_security, selinux_dentry_init_security),
>>       LSM_HOOK_INIT(dentry_create_files_as, selinux_dentry_create_files_as),
>>  
>
>
