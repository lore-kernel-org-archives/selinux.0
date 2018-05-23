Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4NJc0k1029053
 for <selinux@tycho.nsa.gov>; Wed, 23 May 2018 15:38:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID04.oob.disa.mil (Postfix) with SMTP id 40rjTy4h0cz3t8K1
 for <selinux@tycho.nsa.gov>; Wed, 23 May 2018 19:37:58 +0000 (UTC)
Received: from USFB19PA16.eemsg.mil (unknown [192.168.16.16])
 by USFBF3ID04.oob.disa.mil (Postfix) with ESMTP id 40rjTy0gTRz3t8Jy
 for <selinux@tycho.nsa.gov>; Wed, 23 May 2018 19:37:58 +0000 (UTC)
Received: by mail-wm0-f68.google.com with SMTP id m129-v6so12205120wmb.3
 for <selinux@tycho.nsa.gov>; Wed, 23 May 2018 12:37:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSC-nrFTGVvTXZ7=WbRXaxNZ9XFOf_wOeHscovncELdMg@mail.gmail.com>
References: <20180522113752.11936-1-richard_c_haines@btinternet.com>
 <489d60bc-40c8-dac7-e00a-f8c0b7b96ea5@tycho.nsa.gov>
 <CAHC9VhSC-nrFTGVvTXZ7=WbRXaxNZ9XFOf_wOeHscovncELdMg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 23 May 2018 15:37:53 -0400
Message-ID: <CAHC9VhR1SeqwOazNM03j2TrfWH1cnC4Fm_6hVzXjrqKcAWG0Rg@mail.gmail.com>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 Richard Haines <richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [RFC V4 PATCH 1/1] selinux-testsuite: Add binder tests
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, May 22, 2018 at 3:52 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Tue, May 22, 2018 at 10:35 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 05/22/2018 07:37 AM, Richard Haines wrote:
>>> Add binder tests. See tests/binder/test_binder.c for details on
>>> message flows to test security_binder*() functions.
>>>
>>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>>
>> Passes for me with 4.17-rc5 on F28 and properly skipped on earlier Fedora/RHEL.
>>
>> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
>
> Unfortunately none of my test kernels are compiled with
> CONFIG_ANDROID_BINDER* at present, but it fails cleanly for me, and I
> trust Stephen gave the binder checks a good look.  I'll merge this now

FYI, due to some technical difficulties Richard's patch was merged
with the wrong attribution.  I've fixed it now, but you may see that
there was a forced update next time you pull from the
selinux-testsuite repo, you can disregard this message.

Sorry for the noise.

-- 
paul moore
www.paul-moore.com
