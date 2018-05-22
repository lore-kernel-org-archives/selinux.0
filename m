Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4MJqmBN001584
 for <selinux@tycho.nsa.gov>; Tue, 22 May 2018 15:52:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id a8-v6so2828963wmg.5
 for <selinux@tycho.nsa.gov>; Tue, 22 May 2018 12:52:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <489d60bc-40c8-dac7-e00a-f8c0b7b96ea5@tycho.nsa.gov>
References: <20180522113752.11936-1-richard_c_haines@btinternet.com>
 <489d60bc-40c8-dac7-e00a-f8c0b7b96ea5@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 22 May 2018 15:52:24 -0400
Message-ID: <CAHC9VhSC-nrFTGVvTXZ7=WbRXaxNZ9XFOf_wOeHscovncELdMg@mail.gmail.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [RFC V4 PATCH 1/1] selinux-testsuite: Add binder tests
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, May 22, 2018 at 10:35 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 05/22/2018 07:37 AM, Richard Haines wrote:
>> Add binder tests. See tests/binder/test_binder.c for details on
>> message flows to test security_binder*() functions.
>>
>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>
> Passes for me with 4.17-rc5 on F28 and properly skipped on earlier Fedora/RHEL.
>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Unfortunately none of my test kernels are compiled with
CONFIG_ANDROID_BINDER* at present, but it fails cleanly for me, and I
trust Stephen gave the binder checks a good look.  I'll merge this now
...

>> +brexit:

I found this bit particularly amusing considering your email domain :)

-- 
paul moore
www.paul-moore.com
