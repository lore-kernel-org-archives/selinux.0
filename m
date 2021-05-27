Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879C1C4708B
	for <selinux@archiver.kernel.org>; Thu, 27 May 2021 17:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B59A61028
	for <selinux@archiver.kernel.org>; Thu, 27 May 2021 17:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbhE0RHT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 May 2021 13:07:19 -0400
Received: from sonic314-26.consmr.mail.ne1.yahoo.com ([66.163.189.152]:37550
        "EHLO sonic314-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236849AbhE0RHS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 May 2021 13:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1622135145; bh=u6GFmi+eR/n6StK0dBZVA4kg5kqcQ+rdt27+dzUPMSY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=LzIfXZDhVVO3+lwYBv4uijVD57J0InMgaa8oQyIDdp9mNCvkOdqqvnpH64tRUpM7r+ynE0WM+MmQyvoxqQGn9hla3CNM1ZboB/XCO9OlEtnaxjqvOnqijHSyZLAx0D0eVWWjc/2J0pz629YCFzBTobM+zAG9kRZhtvkVKG9BPFH2ycdTgwNxbNkWX30L9O/iUFdZqNaPwLNlXLRcZwEwAZ4dmebReC01FqZ9sNPmJgzwrrBs6sXMXw30J4Gqf7t+kxRAUq20ISiZEWuHeMifttBdJpX612miCbWqLNHKtNyTayK4OR3A1yerkQMH1qZD3i9f8sqPWcgj4qKn1Y6MVA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1622135145; bh=08uRjCsKqwdhED+AiXT157umYagvOotTU14AzAHm47G=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=k3PpNoqaONkI1NDpbGXghESgMn7Hy9Yupo0EDvq0aAEZClOn0xWCFk8ZfgpzojJhoS7MuXcOx0eunLK2AuP7Vw/ACIFTO4m7IvVnDOX0mLQjaGGhQ/tAydAobyRxS2onP5y98UESrhA37AiBaykvpcTi0Wqs5qG2PlV32UxADsQpVrSyPutwkk9dhYu6jn6+Nzf0mghAQ4RZbIKIGmDGTa3/+MNwtTM33NebQJHNaAXEpNxPY8wn3huLvN5oBzDaQPg6lVybhNkIGsGjd47xTyYnGlVboryrVCzEkhLJoQu0r7IGp+jkxQEZi8p9x2KXYcULSOfL70zAk7EKIBCFBw==
X-YMail-OSG: kZeDwyYVM1lBd1VM68_pFsknsPOh1hM.D1R1B7qpYS1RwvXP7gPDsghr70SVXcx
 8Df4h8OSB_ZJFNAe8E4yBIEi_gEa63EeXlvS1zzVUtRb.QyS4OBCRSaPzbWVbAH1S24diAqUZr4s
 XrhDtHA1Vbvj_5e94RlW.t_6BJx.xiqnOmqHO87XDWkrsr2et9ajk_MQVg8k.89R3OMPimN9ZAZq
 4RFETPxNUcVXoGlD6nrLwduwJyNUVI5C99dkJGbXGFnt3YTnBtfS6l5KgirxP.94ttM2H.ib0rKz
 uHRzQ5OY0BbSpp_HAh8biMRLYiiSzCDCMcPJPxWtbnH..Kiwy5zvCndVzrBK0q2fzCqvzcG3Tvaf
 DyYvC2DOsHw21q1Voapnqj4d6_xFtYVV7VMa3N1HVUFirEDP3BoMcf36i0Xb7ewm8H3vK67BlO.q
 1wXU_Pa5dSQRDU1Tt7T0gIXbpHYScsqUOFJRyZSMWiHi92jVrDa_hcqMEknPxzs3UkU0587LjKjN
 A.704sZraZY7l_QnbBMnAqmbGfExVPlDeT063YlUUH3oy4twWTTNCQ9TD8CEboNi21lqBai_Ij9I
 MiQ8ElT8RHFMFedRbASoXcQg_FRq.YCCC6VD4GwI4RafxpvVnOKNJ2fzWfkvsbWSTvd5rMWLer6L
 KUINNJhgRqGAIKjieTlzpE_aWimPrH6G1sCPBNCXqyzZ4Ax47EJv.t6aPLlmcOe0HGx7xKV4yR9g
 oVynDSXenZeBosen4JmX9j9gJN2AvMMSpBeX0UCAuHHghvHEpkJBaJ9HPkwdwC3y7YASVsi7TY6.
 QlC1vaIhQjocopndchr4tSVPPxneBOS9rB9HU1jm9yNRMKjrRi2QboxM8kfV8EbT9EUo4EbONJg7
 4CzSN.ClplIotVB6GZcvfe9luvWl0q.oMCGGzqMywD1iWDXN3jY6oJ3sE2cW1nWp548NzmAzy0jK
 vT4B.yMfRe5Q.jU7OfyPQy4PXt0e9Bohb2pu6oJneb4EbyKWSxUOR3_59I2oe1WCHl_7b_MoXwQb
 dfqp1GTdl8y.Twf7R5in1fErSZ22LfHWIVkPHarQIwRt2Nwz6zWYLWhoFvYPcL20UdXAxslXRza8
 GgyRSsqOR1Q37XWl7_Qpw4MIk2Ob4unTQiX8MGdoPUaKAF6i0hxgUm2MUIs2WAM2YmpmBSCHpJRU
 J3pRDkyCuXVhDVZpw8Y_WNQPXD5VaP3il2kmvtcmu4ExJ5kk4Dn_WZaipaSDJ.Kor2tWHJOKSZpE
 iwjm5jyaOEmV0kp5yptjngnqhsuwlYmB9l2l9YPgv.0XYzFPiYpMnhGGsRUjKw41XWV6YhnWC.NQ
 J_oVoRKF3oGFqNayuTGoEnEXjtz59IAyOjACVe88SI36ShRhqCkM3CTVuwiYGDFgB8uyOeHoTYPt
 hIwNOYByAYqudzPOBfGrbYRjA.9aZjD6ihf0ZVzPWmHFRw9a922AMqb74jLDC0taIh5EOpSl0We4
 1pf_yya8wadT7iitac7WyAy_L5vtQ27BeCDyz2td0i1EAFAYDaLFPM_ScGIkxPHYpO8OwcYPLtCn
 DdhoR4WeoNPukx0QtQj77mx38V1d7Om6rWqm_8U2suOkpi_4P.jmf.yQvqx5hfOPJFr_ObYehnI4
 il9JPlN73A7u820qCInWD77NKI3YriXNdexRQF7yQMu.MKRdto_VbnHTdxNILn5EgdYU2a5iLVmk
 67intGBPxhwEgPRbFxHCuc304uXkjrnpDPGXdwm7UM3YK0amS6Dkd9StAFseyrF9JOZfx2eD.AzG
 FUoCCZIVgCNW7inPmJeH5ZzCOvvnC3vX3UBKfDSFGg7B.tV0h_xaNn6CeLnyXRGPKdKjk5JDYVcb
 J1qpthYZBTWohhKlF0p.GagfzCpFVa5PF.7T4ErN6Mn2TThYjIZu5JMs5fmWZ3fWYD5Cs1k4OLs4
 5wWXJJxNIRkPMGmx.MycsdwHc4FthYYy_QLtnkSg6TN_bdo1KqMkbxWpzDJaL733FjdRJTEbx4Lb
 774wvzmjMAIo4HLsoDFPVFTaT9ScPSnx8DEvKgwWQiLjGrwsZovmmT2QzaDv94H7K_z99XydC1t.
 8LDZrOqQudjUNQfdIaHC5SRgfwGWLH0U0_ulaV4QnBnRCZJmLANxKc.XelXeD.gLsysDSoDRX0cz
 hkyE5EYkFDMiW6JJORPtR57c7JlraHCw32Bg2RA2LqqIl51cSNG.mHal1yFzlqG6Ic_XKubhex9E
 cQqs632ZOWgBkp0EEznqylG79sne2ut0IQG42K1mXbjtFKlNx_BAM5fvV4JAbJHU16Hfh3bzumco
 zGCDh049H5eJHJ8O.ENiv_JOTsvrwgm7To1Vb0T45sO.MbUAK3_e4SG7lClODVhFEvDmHvVs_1AL
 37G7NVVr1BD.iSIQmdlB4bg7YRNndqo6ceesjQAyarg_YkmAAbcKS6PSbZ9MBK.UN1Rb8yxoKQED
 cPaKPnYtGRhSUR18CaVNzratk29mVNYAejgNfHnB9r3SzMJCIhkc4RN1C8xFtpwKOv1p1CAig.Om
 nXdP6hZh_uEptab6YlPkHSp1eOWQ5bFth7htSF6_akpbmFUkXQP_J9mSaqsFVW5_5ry1ecOuyULy
 zgVf2T83YkNZEOQdbOvTxrAooDrBYqgeGIsxknJxhknufj7XdrNN8gG3nUrP0JACfD.0LSFeEKCO
 DSGOxEsU7JAp6p4szCY9CND0SSrTC3AyA5VtgIeThQ53JgxvzEqDwyqubgsF25WUABPaicUdoz_U
 MV7GnOQoYxkiTq9Ozeocj4Euxr2.3UMYGbVtc0.nawcjGM3vuxd5qDxwrC4iZoyopgK4.qzHC5yC
 UdOI38OdAxj79itnMStFxX6bXK2R.YFQhzmCJbiuLNkVD58xyoD3JLqw-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 27 May 2021 17:05:45 +0000
Received: by kubenode575.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 6fc88eb2aa808b1b1f97e6646d642118;
          Thu, 27 May 2021 17:05:41 +0000 (UTC)
Subject: Re: [pcmoore-selinux:working-io_uring 9/9]
 security/smack/smack_lsm.c:4702:5: warning: no previous prototype for
 function 'smack_uring_override_creds'
To:     Paul Moore <paul@paul-moore.com>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <202105270909.1fgRW8Wk-lkp@intel.com>
 <CAHC9VhRy=oD=B9G_ZZejPX0dL1+vsyLkYLs59vj-SJoeVMs53g@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <e061750d-9591-ac2c-5331-85456c3b4135@schaufler-ca.com>
Date:   Thu, 27 May 2021 10:05:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRy=oD=B9G_ZZejPX0dL1+vsyLkYLs59vj-SJoeVMs53g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.18368 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/27/2021 8:29 AM, Paul Moore wrote:
> On Wed, May 26, 2021 at 9:51 PM kernel test robot <lkp@intel.com> wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git working-io_uring
>> head:   1f25193a3f5495eefbc9826b1de1a008a2439351
>> commit: 1f25193a3f5495eefbc9826b1de1a008a2439351 [9/9] Smack: Brutalist io_uring support with debug
>> config: x86_64-randconfig-r013-20210526 (attached as .config)
>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 99155e913e9bad5f7f8a247f8bb3a3ff3da74af1)
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # install x86_64 cross compiling tool for clang build
>>         # apt-get install binutils-x86-64-linux-gnu
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/commit/?id=1f25193a3f5495eefbc9826b1de1a008a2439351
>>         git remote add pcmoore-selinux https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
>>         git fetch --no-tags pcmoore-selinux working-io_uring
>>         git checkout 1f25193a3f5495eefbc9826b1de1a008a2439351
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> security/smack/smack_lsm.c:4702:5: warning: no previous prototype for function 'smack_uring_override_creds' [-Wmissing-prototypes]
>>    int smack_uring_override_creds(const struct cred *new)
>>        ^
>>    security/smack/smack_lsm.c:4702:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>>    int smack_uring_override_creds(const struct cred *new)
>>    ^
>>    static
>>>> security/smack/smack_lsm.c:4739:5: warning: no previous prototype for function 'smack_uring_sqpoll' [-Wmissing-prototypes]
>>    int smack_uring_sqpoll(void)
>>        ^
>>    security/smack/smack_lsm.c:4739:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>>    int smack_uring_sqpoll(void)
>>    ^
>>    static
>>    2 warnings generated.
> FYI, Casey I took the liberty of making the Smack functions static (I
> had made the same mistake with the SELinux code).

Thank you. If there was any doubt, the Smack function declarations
were taken directly from the SELinux versions. 

