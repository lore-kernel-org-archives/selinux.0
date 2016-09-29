MIME-Version: 1.0
In-Reply-To: <9f04db8c-6e09-d5c8-9f95-b3f7805edbd7@tycho.nsa.gov>
References: <1474573685-124428-1-git-send-email-bowgotsai@google.com>
 <f213e1a4-5a68-dff2-b1b6-354410ef7fe1@tycho.nsa.gov>
 <CAMFYTWcz6y9whm8_z4rwQBVtcK_YniTycwu-+zsSiqrYn-kj_A@mail.gmail.com>
 <9f04db8c-6e09-d5c8-9f95-b3f7805edbd7@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 29 Sep 2016 10:06:11 -0400
Message-ID: <CAFftDdr=sodunXnQoszCOe6P9s4oxrxWC0Vn6eVu5Fde-cEZMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol, checkpolicy: Update Android.mk
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Bowgo Tsai <bowgotsai@google.com>, Daniel Cashman <dcashman@google.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Sep 29, 2016 at 9:28 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 09/28/2016 10:17 PM, Bowgo Tsai wrote:
>> OK, please ignore these patches, will update new ones.
>> I'll update the top-level Android.mk if we still want to keep Android.mk
>> upstream.
>>
>> However, I was thinking the same thing: it seems better to only keep
>> Android.mk files in Android tree.
>> For other *.c/*.h files, keep these files up-to-date in the upstream as
>> well.
>>
>> If no one objects to this, I'll prepare two patches.
>>
>>  1. Update secilc/secilc.c
>>  2. Delete all Android.mk files in the upstream
>
> SGTM

SGTM
