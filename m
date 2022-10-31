Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C6CFA3740
	for <selinux@archiver.kernel.org>; Mon, 31 Oct 2022 10:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiJaK0y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Oct 2022 06:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiJaK0w (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Oct 2022 06:26:52 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD5C2DE3
        for <selinux@vger.kernel.org>; Mon, 31 Oct 2022 03:26:50 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 29VAQm5s077943;
        Mon, 31 Oct 2022 19:26:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Mon, 31 Oct 2022 19:26:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 29VAQlDJ077940
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 31 Oct 2022 19:26:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <feaa5cbc-342e-3863-e761-e7ac8b08d314@I-love.SAKURA.ne.jp>
Date:   Mon, 31 Oct 2022 19:26:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: LSM stacking in next for 6.1?
Content-Language: en-US
To:     Kees Cook <kees@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, linux-audit@redhat.com,
        Mimi Zohar <zohar@linux.ibm.com>, keescook@chromium.org,
        SElinux list <selinux@vger.kernel.org>
References: <791e13b5-bebd-12fc-53de-e9a86df23836.ref@schaufler-ca.com>
 <cc14bbde-529e-376c-7d27-8512ec677db3@schaufler-ca.com>
 <ff43e254-0f41-3f4f-f04d-63b76bed2ccf@I-love.SAKURA.ne.jp>
 <1a9f9182-9188-2f64-4a17-ead2fed70348@schaufler-ca.com>
 <2225aec6-f0f3-d38e-ee3c-6139a7c25a37@I-love.SAKURA.ne.jp>
 <5995f18c-5623-9d97-0aa6-5f13a2a8e895@I-love.SAKURA.ne.jp>
 <77ec837a-ff64-e6f0-fe14-a54c1646ea0b@canonical.com>
 <0fcc5444-a957-f107-25a1-3540588eab5a@I-love.SAKURA.ne.jp>
 <11564f69-3bba-abf7-eb46-06813ff4a404@schaufler-ca.com>
 <98ab33d6-6c91-9c0a-8647-22f6bdede885@I-love.SAKURA.ne.jp>
 <aa201ed7-9ca1-9507-08cc-156f280ee5f4@schaufler-ca.com>
 <3266c2c2-cd7e-bc0f-0fc4-478a63d6ee77@I-love.SAKURA.ne.jp>
 <f7548061-e82d-9a39-ed15-0d32551b4099@canonical.com>
 <53b07579-82f5-404e-5c2c-de7314fff327@I-love.SAKURA.ne.jp>
 <aa5424f3-05a6-530b-bf5f-19e5421f8f3f@canonical.com>
 <2c48a481-391f-85c7-be4f-13bbc1553aac@I-love.SAKURA.ne.jp>
 <AB202AC7-9C8D-4109-B4EA-87A7BC1BADF8@kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <AB202AC7-9C8D-4109-B4EA-87A7BC1BADF8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2022/10/31 1:37, Kees Cook wrote:
>> You have only three choices:
>>
>>  (1) allow assigning LSM ID integer value to all LSM modules (regardless of
>>      whether that module was merged into upstream kernel)
> 
> We are not hardware manufacturers.
> 

Excuse me? We are not talking about whether we are hardware manufacturers.
We are talking about the policy for assigning identifier.

I don't like how LSM IDs are assigned, for Casey said

  >> If the upstream kernel assigns an LSM id for all LSM modules including out-of-tree
  >> and/or private LSM modules (that's why I described that the upstream kernel behaves
  >> as if a DNS registerer), we can assign LSM id = 100 to "belllapadula" from A and
  >> LSM id = 101 to "belllapadula" from B, and both "belllapadula" modules can work
  >> without conflicts by using LSM id. Of course, this implies that we need to preserve
  >> unused space in lsm_idlist[LSMID_ENTRIES] etc. for such LSM modules (if we use
  >> fixed-sized array rather than a linked list).
  > 
  > Of course the upstream kernel isn't going to have LSM IDs for out-of-tree
  > security modules. That's one of many reasons loadable modules are going to
  > have to be treated differently from built-in modules, if they're allowed
  > at all.

at https://lkml.kernel.org/r/7263e155-9024-0508-370c-72692901b326@schaufler-ca.com and
Paul confirmed

  >> Currently anyone can start writing new LSM modules using name as identifier. But
  >> you are trying to forbid using name as identifier, and trying to force using integer
  >> as identifier, but that integer will not be provided unless new LSM modules get
  >> upstream.
  > 
  > That is correct.  In order to have a LSM identifier token the LSM must
  > be upstream.

at https://lkml.kernel.org/r/CAHC9VhT2Azg1F-G3RQ4xL7JgA3OAtHafzS1_nvUyEUFsCJ9+SA@mail.gmail.com .

If we can agree that the upstream kernel never refuse to assign LSM IDs to whatever
LSM modules, I'm OK that we introduce LSM ID integer value itself.



My next concern is that we are trying to use fixed sized capacity as LSMID_ENTRIES,
commented

  On 2022/10/13 19:04, Tetsuo Handa wrote:
  > On 2022/09/28 4:53, Casey Schaufler wrote:
  >> +	if (lsm_id > LSMID_ENTRIES)
  >> +		panic("%s Too many LSMs registered.\n", __func__);
  > 
  > I'm not happy with LSMID_ENTRIES. This is a way towards forever forbidding LKM-based LSMs.

at https://lkml.kernel.org/r/9907d724-4668-cd50-7454-1a8ca86542b0@I-love.SAKURA.ne.jp , for

  struct lsm_id *lsm_idlist[LSMID_ENTRIES] __lsm_ro_after_init;

may cause out-of-tree LSM modules to fail to use the slot.

It is a strange hack that users have to enable in-tree LSM modules or rewrite the
definition of LSMID_ENTRIES in order to use out-of-tree (either built-in or loadable)
LSM modules, for LSMID_ENTRIES is defined based on only in-tree LSM modules.

  #define LSMID_ENTRIES ( \
        1 + /* capabilities */ \
        (IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
        (IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
        (IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
        (IS_ENABLED(CONFIG_SECURITY_IMA) ? 1 : 0) + \
        (IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
        (IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
        (IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
        (IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
        (IS_ENABLED(CONFIG_SECURITY_LOCKDOWN) ? 1 : 0) + \
        (IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
        (IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))

Although built-in out-of-tree LSM modules would be able to rewrite LSMID_ENTRIES definition
because users will rebuild the whole kernel, loadable out-of-tree LSM modules would not be
able to rewrite LSMID_ENTRIES definition because users will not rebuild the whole kernel.
It is still effectively a lock out for loadable out-of-tree LSM modules even if the problem
of assigning LSM ID integer value is solved.

