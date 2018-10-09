Return-Path: <SRS0=wI+O=MV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8C0C64EAD
	for <selinux@archiver.kernel.org>; Tue,  9 Oct 2018 13:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2D92086D
	for <selinux@archiver.kernel.org>; Tue,  9 Oct 2018 13:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="pF0ETCYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2D92086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=crunchydata.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeJIVJz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:09:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39067 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeJIVJz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Oct 2018 17:09:55 -0400
Received: by mail-qt1-f195.google.com with SMTP id e22-v6so1640457qto.6
        for <selinux@vger.kernel.org>; Tue, 09 Oct 2018 06:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=egCdMmH+mRDtIlTXoq+K0/2mu2ns7V2lHag0Wuv0Uaw=;
        b=pF0ETCYFBGPboebWWNnZCXoLpM5PmZheK3f2JremK0QkxaIPohMmcMx2GVW/ZtdhFm
         fDSwWKI3avcX9xnGmLM3tt9gvSAY75k7xgYheWFHWdPyAQaUunY9ON0P3dGHwi2c2bcm
         y1cIkYJkGacB44lIWqgRZUGuPOfsmoXPbdM0wN1UhL8EEHKZq1/wHcxF//6RUwSuHPdL
         eUd1SyoscIpQR6cqDuXG/Qn1Q92EverLP0ct8iKpwV3Bertrz9eVL5/4kzKld0G8T+gZ
         ag65Ic/a0M8vumBLJiliNWCqVCnIBZSahERUSD751fN/F9kr6e/V2W7JnO8eFxuz1tR4
         NSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=egCdMmH+mRDtIlTXoq+K0/2mu2ns7V2lHag0Wuv0Uaw=;
        b=JPrAMSHm+dHsXW00St4tyI3BHGK0t0tR2Fdxz76gIyC/DaXhvQiZDpaSxzxO4yFmqS
         MjIBRCjd8zqrZbQOWM88s3n1AQcqjSxwDFTlThGX0NEYFFcIJN7FDt5V3FKwbeF7d1dE
         wCzPhkN2+EOzylowGoeabgfHRiojTsN2xa0/8fOL4ZusOm1wdId8GZ9Ethy77jNhH2LJ
         dyFkTTlQx5irLerIkyLm12MXa4pOcNEaUMmqLeJKi64BaHL4htLRCCSee6UyrLS6eDcH
         yxXQZWLzcSr03tJzZRHnzzzl6jyi9au2+UhDFBrhS0bFe84ZxUBJBhod+ge+7vjULqBJ
         eAjw==
X-Gm-Message-State: ABuFfoiiz4I5JGxt4fCFdswrWlrQE/AK6CDLuuztdx4cPCSYeh0Ry2pa
        AjkSci/sTmtIpRd9XlUxqsjyMA==
X-Google-Smtp-Source: ACcGV60NF4dQ0BGeX60ALha9OWNOZKUAyus1VBDVWvb2KfTRkxAMG0aumVA5PnK6iEPWPSlFiXiV8A==
X-Received: by 2002:ac8:544f:: with SMTP id d15-v6mr149644qtq.353.1539093171291;
        Tue, 09 Oct 2018 06:52:51 -0700 (PDT)
Received: from [10.0.1.161] (pool-68-134-6-138.bltmmd.fios.verizon.net. [68.134.6.138])
        by smtp.gmail.com with ESMTPSA id t15-v6sm9941344qke.74.2018.10.09.06.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 06:52:50 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] libsemanage: improve semanage_migrate_store import
 failure
From:   Yuli Khodorkovskiy <yuli.khodorkovskiy@crunchydata.com>
In-Reply-To: <CAFftDdpY5o7ABVPi_-+9SZJGmMDT-OOHmUwfxh0e7DT=1i88Xw@mail.gmail.com>
Date:   Tue, 9 Oct 2018 09:52:49 -0400
Cc:     Chris PeBenito <pebenito@ieee.org>,
        Jason Zaman <jason@perfinion.com>, selinux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A93E8484-5EB6-4141-B71E-DD2E78EAEC68@crunchydata.com>
References: <20181004194108.29485-1-yuli@crunchydata.com>
 <CAFftDdpNVByPh+fGgVbnd-hR_C=k7RtNM8GUVxLC2bftvfQjtg@mail.gmail.com>
 <20181005143239.GC3445@baraddur.perfinion.com>
 <2b4b322c-c9ae-e12b-1119-02a4d0bfa732@ieee.org>
 <CAFftDdoSdwWwmU+8oT_ugzhSzYvAHQ6BCTzcBUr36snLbJfKpw@mail.gmail.com>
 <CAFftDdpY5o7ABVPi_-+9SZJGmMDT-OOHmUwfxh0e7DT=1i88Xw@mail.gmail.com>
To:     William Roberts <bill.c.roberts@gmail.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org



> On Oct 8, 2018, at 12:16 PM, William Roberts =
<bill.c.roberts@gmail.com> wrote:
>=20
> Weird Gmail removed my text box for plain text mode in Gmail,
> re-sending since it got
> filtered out of the mailing list.
>=20
> On Mon, Oct 8, 2018 at 9:09 AM William Roberts =
<bill.c.roberts@gmail.com> wrote:
>>=20
>> Yuli,
>> If you respin this with just import error looks like its a go.
>> Bill
>>=20
>> On Fri, Oct 5, 2018 at 12:53 PM Chris PeBenito <pebenito@ieee.org> =
wrote:
>>>=20
>>> On 10/05/2018 10:32 AM, Jason Zaman wrote:
>>>> On Fri, Oct 05, 2018 at 07:13:23AM -0700, William Roberts wrote:
>>>>> On Thu, Oct 4, 2018 at 12:46 PM Yuli Khodorkovskiy <
>>>>> yuli.khodorkovskiy@crunchydata.com> wrote:
>>>>>=20
>>>>>> The python module import error in semanage_migrate_store was =
misleading.
>>>>>> Before, it would print that the module is not installed, even =
though
>>>>>> it is in fact on the system.
>>>>>>=20
>>>>>> Now the python module import failure is correctly reported if the =
module
>>>>>> is not installed or the exact reason for failure is reported to =
the user.
>>>>>>=20
>>>>>> Signed-off-by: Yuli Khodorkovskiy <yuli@crunchydata.com>
>>>>>> ---
>>>>>>  libsemanage/utils/semanage_migrate_store | 6 ++++--
>>>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>>=20
>>>>>> diff --git a/libsemanage/utils/semanage_migrate_store
>>>>>> b/libsemanage/utils/semanage_migrate_store
>>>>>> index 2e6cb278..50eb59ef 100755
>>>>>> --- a/libsemanage/utils/semanage_migrate_store
>>>>>> +++ b/libsemanage/utils/semanage_migrate_store
>>>>>> @@ -15,10 +15,12 @@ sepol =3D =
ctypes.cdll.LoadLibrary('libsepol.so.1')
>>>>>>  try:
>>>>>>         import selinux
>>>>>>         import semanage
>>>>>> -except:
>>>>>> +except ImportError:
>>>>>>         print("You must install libselinux-python and =
libsemanage-python
>>>>>> before running this tool", file=3Dsys.stderr)
>>>>>>         exit(1)
>>>>>> -
>>>>>> +except Exception as e:
>>>>>> +       print("Failed to import =
libselinux-python/libsemanage-python: %s"
>>>>>> % str(e))
>>>>>> +       exit(1)
>>>>>>=20
>>>>>=20
>>>>> We should really only be handling exceptions we reasonably expect =
and
>>>>> discourage
>>>>> the usage of catching raw Exception, especially considering =
not-catching
>>>>> this will
>>>>> cause the runtime to print a stack trace, the error and exit =
non-zero.
>>>>>=20
>>>>> We probably only need the except ImportError change and can drop =
the second
>>>>> hunk.
>>>>>=20
>>>>> Does anyone disagree with this?
>>>=20
>>> For this case, I agree that ImportError is the only thing that =
should be
>>> caught.
>>>=20
>>>> Agreed. catching Exception is bad cuz it also catches =
KeyboardInterrupt
>>>> and stuff like that.
>>>=20
>>> That's not correct.  Catching BaseException would catch
>>> KeyboardInterrupt.  Catching Exception would not.  See the Python
>>> builtin exception hierarchy:
>>>=20
>>> =
https://docs.python.org/3/library/exceptions.html#exception-hierarchy
>>>=20
>>> IMO catching Exception has valid uses.
>>>=20
>>> --
>>> Chris PeBenito

The reason I went the path of catching general exception was the =
possibility=20
of a missing symbol from _selinux.so. For example:=20

Traceback (most recent call last):
  File "libsemanage/utils/semanage_migrate_store", line 16, in <module>
    import selinux
  File "/usr/lib64/python2.7/site-packages/selinux/__init__.py", line =
512, in <module>
    SELABEL_CTX_ANDROID_SERVICE =3D _selinux.SELABEL_CTX_ANDROID_SERVICE
AttributeError: 'module' object has no attribute =
=E2=80=98SELABEL_CTX_ANDROID_SERVICE'

Should I just catch AttributeError as well and if more exceptions come =
up in the future
we can catch them directly?=
