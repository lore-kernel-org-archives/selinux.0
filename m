Return-Path: <SRS0=VZrA=O4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61142C43387
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 15:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC7F20449
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 15:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="ooqjXZKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbeLSPoF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:44:05 -0500
Received: from uhil19pa12.eemsg.mail.mil ([214.24.21.85]:24293 "EHLO
        uhil19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbeLSPoF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Dec 2018 10:44:05 -0500
X-EEMSG-check-008: 368282561|UHIL19PA12_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 19 Dec 2018 15:44:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1545234243; x=1576770243;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+GriTODyfiGn19XtUXvV5z9M+ESSwDrX5O4qmF2aALU=;
  b=ooqjXZKpvKwapdAkzzxtv1TltTbCYT4QMf53MBs4lTI0l5LlZWX9FH7W
   1eGYiiESW9hhPxaf6HI+ul1Xfq15n5I+UdvO8zAZY5wA+INC3Fa+nTEDn
   99GnPynOG6UTgaCsxT4nF77yef0jUcpAR+CcwOOBcXflCUusaWLxlhg5d
   D2ttt8Ctd/MHYtSipPITXvtHM4b2v7QHS3NRDHiNrbCj8lEd+jmn9lb7l
   Ra9nzRfRlLlsuC8rYTlN7rPAyWymysKMnMg6Ur10U39l2u4ZaAmsPjeus
   fOJJ5WWRUvX4oQpYvrkLakYW4Iecrk+Eg8gSGgCHPLyF1vJtdIkAw2LhG
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,373,1539648000"; 
   d="scan'208";a="21873728"
IronPort-PHdr: =?us-ascii?q?9a23=3Aivx3CRK6lZ/0sIems9mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXKvz4rarrMEGX3/hxlliBBdydt6oUzbKO+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxlLiTanfb9+MAi9oBnMuMURnYZsMLs6xA?=
 =?us-ascii?q?HTontPdeRWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjTbxFFzsmKH?=
 =?us-ascii?q?w65NfqtRbYUwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr0vRz?=
 =?us-ascii?q?+s87lkRwPpiCcfNj427mfXitBrjKlGpB6tvgFzz5LIbI2QMvdxcLndfdcHTm?=
 =?us-ascii?q?RfWMhfWTFKDoelY4cRE+YNOOBVpJT/qVQTtxuzHRSiCv3hyjFIhXH406M13O?=
 =?us-ascii?q?sjHg7a0wItBM4OvXbOodnpKKsfX+K4wa/VxjvDdfNW3jL95ZDVfBA9v/6MRb?=
 =?us-ascii?q?JwftTXyUIyCg3Fi0+fqYjhPzyL1uUGrm+W7/F9WuK0kGMntwFwrSSvxscrkI?=
 =?us-ascii?q?XJgJkVxUre+SV2x4Y1O8S1RUhmatCnCJtdrzyWOoR5T884Q2xkpTw2xqMJtJ?=
 =?us-ascii?q?KlZiQG1ZIqzAPFZfOdaYiH+BfjWf6UITd/mX1qZqqyhw238Ui80u38UdS00E?=
 =?us-ascii?q?pSoipFjNbMsncN2gTP6sedUPt9/1qh2S2V2wDP6uBLPUA0la3BJ54n3rEwjY?=
 =?us-ascii?q?YcvV7GHi/3nEX6lK6WdkM69ei08+nrf7rrq5CGO4J0lw3yKLoil8OhDegiLw?=
 =?us-ascii?q?QCR22b9v691L3n8035WrJKjvgun6nCrZ/aPt8WprK5AgBJ0oYj7AyzDzG90N?=
 =?us-ascii?q?sCh3UHI1VFeAyfg4jzJ17OOOz4Deu4g1m0izhrxvTGPrn7DprRNHTDirDhcq?=
 =?us-ascii?q?1j5E5G1Aoz1stS551RCr4bIfLzXlX9u8DfDh88Kwa02froCM1h1oMCXmKCGr?=
 =?us-ascii?q?eZMLjJvF+Q5eIvOPOAZI4QuDzlMfgq++bujWMlmV8aZaSpxoUYaHS5HvRgPk?=
 =?us-ascii?q?WYbmHhgskOEWgUpAoyVu/qh0OYUT5VeXmyW7gw5jYhCIKpFY3DXJyigKSd3C?=
 =?us-ascii?q?enGZ1bfm5HClGIEXfsdoWLQfIMZDiOLcN7iDwEUqOuRJE71RGyrw/30LtnLu?=
 =?us-ascii?q?zI+iIGsZLvzsR65+rWlUJ6yTshMMWZ12CESilOmWkFXSMtlPR1oEh5jFzFy6?=
 =?us-ascii?q?9yjuZEDvRc4vpIVkExMpuKi6RCAszoWwnCNuyVRVegQty8DS15Gsoq68cNeA?=
 =?us-ascii?q?B8HoPxoArE2n+RH7INl7GNTKcx+6bY0mm5c91x0F7axaIhiB8gWcIJOmq40P?=
 =?us-ascii?q?0svzPPDpLExh3K352hcr4RiWuUrj+O?=
X-IPAS-Result: =?us-ascii?q?A2CFAAAjZhpc/wHyM5BkGQEBAQEBAQEBAQEBAQcBAQEBA?=
 =?us-ascii?q?QGBZYFbKYFoJ4N9lBVPAQEBBoEILYkVDpA1OAGEQAKCayI4EgEDAQEBAQEBA?=
 =?us-ascii?q?gFsKII2JAGCYQEBAQEDIxVBEAsOBwMCAiYCAiE2BgEMBgIBAReCSD+BagMID?=
 =?us-ascii?q?agtgS+FQIJDDYIdgQuLNBd4gQeBOIFtfoJXhTKCNSICiSWGejeQKzMJjjGDK?=
 =?us-ascii?q?wYYkVksiRyGDIwLIYFWKwgCGAghD4MngicXjjshAzABgQQBAY1gAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 19 Dec 2018 15:44:02 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id wBJFhulh019401;
        Wed, 19 Dec 2018 10:43:57 -0500
Subject: Re: [PATCH 1/2] Makefile: fix _FORTIFY_SOURCE redefined build error
To:     William Roberts <bill.c.roberts@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Cc:     selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>,
        James Carter <jwcart2@tycho.nsa.gov>
References: <1544736761-7920-1-git-send-email-william.c.roberts@intel.com>
 <a31ecb59-e330-08c8-95d3-8c9fe5a4022d@tycho.nsa.gov>
 <877d53f9-3296-368c-979f-cf73cfc50ebb@tycho.nsa.gov>
 <CAFftDdofWyE747=fFUXj8v8bN3aipgguWVziDpOhd9_VVsasmQ@mail.gmail.com>
 <CAFftDdr+1zWpGeBgpfhQ02fbfhCD2F5_F0mUTB2zQobKpANg8g@mail.gmail.com>
 <20181219091224.GA1887@ncase>
 <CAFftDdpvykcTgD=-QMBf9==3BgQpAhgfjcfRA5u8HpYNEJLYEg@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <53afe8e8-3f96-e36e-341b-2c8a71f02ebf@tycho.nsa.gov>
Date:   Wed, 19 Dec 2018 10:46:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAFftDdpvykcTgD=-QMBf9==3BgQpAhgfjcfRA5u8HpYNEJLYEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/19/18 10:42 AM, William Roberts wrote:
> On Wed, Dec 19, 2018 at 1:12 AM Patrick Steinhardt <ps@pks.im> wrote:
>>
>> Hi,
>>
>> On Tue, Dec 18, 2018 at 08:03:54AM -0800, William Roberts wrote:
>>> Patrick,
>>>
>>> Hoping you could maybe weigh in on your choice for bypassing the
>>> compiler driver with -Wp and not setting _FORTIFY_SOURCE to something
>>> like 1 or 2?
>>>
>>> I'm seeing this issue on Ubuntu 16.04.5:
>>> <command-line>:0:0: error: "_FORTIFY_SOURCE" redefined [-Werror]
>>>
>>> gcc version:
>>> gcc (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609
>>>
>>> My thought is to undef/redef _FORTIFY_SOURCE in CFLAGS and set the
>>> level to 2. Setting CFLAGS via the env/make arg will override this
>>> behavior
>>> and use CFLAGS as is.
>>
>> I used "-Wp" simply because it was existing previously, so I just
>> stuck to what was there already. The original issue I had was
>> that Gentoo Hardened, as Jason notes, already defines
>> _FORTIFY_SOURCE as part of the compiler spec. Due to that, I was
>> seeing a lot of warnings.
>>
>> So I set the flag to a simple define without setting a specific
>> value, which _seemed_ to let the issue go away. But going back to
>> the initial issue, this didn't seem to have solved it correctly.
>> Dunno what I've been doing back then to not see the warnings
>> after my change anymore, but I noticed that they have resurface
>> recently.
>>
>> So I guess the real fix would be to redefine the value by first
>> undef'ing it and then redefining it to the desired value. And I
>> do agree that in that case, we should simply revert to
>> _FORTIFY_SOURCE=2.
>>
>> Patrick
>>
>>> On Fri, Dec 14, 2018 at 8:02 AM William Roberts
>>> <bill.c.roberts@gmail.com> wrote:
>>>>
>>>> On Fri, Dec 14, 2018 at 6:32 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>>
>>>>> On 12/14/18 8:43 AM, Stephen Smalley wrote:
>>>>>> On 12/13/18 4:32 PM, bill.c.roberts@gmail.com wrote:
>>>>>>> From: William Roberts <william.c.roberts@intel.com>
>>>>>>>
>>>>>>> Certain builds of gcc enable _FORTIFY_SOURCE which results in the error:
>>>>>>> <command-line>:0:0: warning: "_FORTIFY_SOURCE" redefined
>>>>>>> <command-line>:0:0: note: this is the location of the previous definition
>>>>>>>
>>>>>>> Correct this by undefining it first and redefining it. Also, the previous
>>>>>>> command line option was using -Wp which passing the value *AS IS* to the
>>>>>>> pre-processor rather than to the compiler driver. The C pre-processor has
>>>>>>> an undocumented interface subject to change per man 1 gcc. Just use the
>>>>>>> -D option as is.
>>>>>>
>>>>>> See commit ca07a2ad46be141dad90d885dd33a2ac31c6559a ("libselinux: avoid
>>>>>> redefining _FORTIFY_SOURCE") for why we don't specify a value for
>>>>>> _FORTIFY_SOURCE here.  Not sure about the -Wp,-D vs -D rationale.
>>>>
>>>> I'm not 100% convinced that the patch is the best solution or the commit message
>>>> is describing the problem correctly. I could also be understanding it
>>>> wrong here.
>>>> The man page is saying not to bypass the compiler driver via -Wp, and I don't
>>>> see a good reason for it either.
>>>>
>>>> See my comments below, they feed back into this.
>>>>
>>>>>
>>>>> I guess the issue here is that we want to provide sane defaults for
>>>>> building without breaking the build when others specify their own
>>>>> definitions and without weakening those definitions.  By undefining and
>>>>> re-defining, it seems like we might weaken existing builds that were
>>>>> specifying 2.
>>>>
>>>> We conditionally assign to CFLAGS via ?= operator. Thus, CFLAGS and the
>>>> corresponding addition of EXTRA_CFLAGS which contains the undef/def
>>>> is not appended. CFLAGS specified via the environment or as an argument to
>>>> make will cause this assignment not to occur (via ?= semantics) and whatever
>>>> they specify for CFLAGS is sent to CC.
>>>>
>>>> Here is some sample output:
>>>> make CFLAGS='-D_FORTIFY_SOURCE=2'
>>>> cc -D_FORTIFY_SOURCE=2 -I../include -D_GNU_SOURCE -DNO_ANDROID_BACKEND
>>>>   -fPIC -DSHARED -c -o stringrep.lo stringrep.c
>>>>
>>>> With that said, *i think its safe* to bump it back to '-D_FORTIFY_SOURCE=2'
> 
> I agree that 2 is the better value. I'll re-roll these to use 2. No
> one seems to be complaining
> on using the -D/-U options.

The only alternative that I could see would be to just drop 
FORTIFY_SOURCE altogether from the upstream Makefile and defer setting 
of it entirely to the packagers...

> 
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: William Roberts <william.c.roberts@intel.com>
>>>>>>> ---
>>>>>>>    libselinux/src/Makefile   | 2 +-
>>>>>>>    libselinux/utils/Makefile | 2 +-
>>>>>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
>>>>>>> index 977b5c8cfcca..ee55bd0dbff7 100644
>>>>>>> --- a/libselinux/src/Makefile
>>>>>>> +++ b/libselinux/src/Makefile
>>>>>>> @@ -64,7 +64,7 @@ ifeq ($(COMPILER), gcc)
>>>>>>>    EXTRA_CFLAGS = -fipa-pure-const -Wlogical-op
>>>>>>> -Wpacked-bitfield-compat -Wsync-nand \
>>>>>>>        -Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc
>>>>>>> -Wsuggest-attribute=const \
>>>>>>>        -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure
>>>>>>> -Wtrampolines -Wjump-misses-init \
>>>>>>> -    -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
>>>>>>> -Wp,-D_FORTIFY_SOURCE
>>>>>>> +    -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
>>>>>>> -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
>>>>>>>    else
>>>>>>>    EXTRA_CFLAGS = -Wunused-command-line-argument
>>>>>>>    endif
>>>>>>> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
>>>>>>> index d06ffd66893b..64ab877015c6 100644
>>>>>>> --- a/libselinux/utils/Makefile
>>>>>>> +++ b/libselinux/utils/Makefile
>>>>>>> @@ -30,7 +30,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k
>>>>>>> -Wformat-security -Winit-self -Wmissi
>>>>>>>              -Wformat-extra-args -Wformat-zero-length -Wformat=2
>>>>>>> -Wmultichar \
>>>>>>>              -Woverflow -Wpointer-to-int-cast -Wpragmas \
>>>>>>>              -Wno-missing-field-initializers -Wno-sign-compare \
>>>>>>> -          -Wno-format-nonliteral
>>>>>>> -Wframe-larger-than=$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE \
>>>>>>> +          -Wno-format-nonliteral
>>>>>>> -Wframe-larger-than=$(MAX_STACK_SIZE) -U_FORTIFY_SOURCE
>>>>>>> -D_FORTIFY_SOURCE=1 \
>>>>>>>              -fstack-protector-all --param=ssp-buffer-size=4
>>>>>>> -fexceptions \
>>>>>>>              -fasynchronous-unwind-tables -fdiagnostics-show-option
>>>>>>> -funit-at-a-time \
>>>>>>>              -Werror -Wno-aggregate-return -Wno-redundant-decls \

