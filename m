Return-Path: <SRS0=dzGL=MU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD37C677D4
	for <selinux@archiver.kernel.org>; Mon,  8 Oct 2018 16:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594292089D
	for <selinux@archiver.kernel.org>; Mon,  8 Oct 2018 16:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcULNF2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594292089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbeJHX25 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:28:57 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42775 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeJHX25 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Oct 2018 19:28:57 -0400
Received: by mail-ot1-f68.google.com with SMTP id h26-v6so20480518otl.9
        for <selinux@vger.kernel.org>; Mon, 08 Oct 2018 09:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ASh5BZab5VeSEIMXKy/TvXMjCRXEy2DxNOSpdDcIPnc=;
        b=LcULNF2jH2BTGE17/fAvVzI/bwfa3+1ApqlZ8BxcRwWoZYmoWuSqqEPxVVBQCj8A9L
         Rp8sN4hX+2iawQZ2WvTUo9wcjeAS98diJMtyn7D9LDzCycyHIct71+QDNvUczRXWOa5f
         30NwRA7oMvU0Hq5Fd7vwQRcjqUaKSIoK6EN20Gb2/sRg8Hmd6oYr0U8KpvIgcYvGqJZ6
         wFuJ7inFihYV8mUhfbd2dPeWGTdSdvYAk2Eqj3zTWzHb12Evu8SsbYzVXhF8M9ce/EPG
         uhjBrtIfA8svlw4VBB8zDf5iLoEx+QzuOcsVATh4uzuFnjDB0cMN2FwjIWTEsGkiszlx
         1xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ASh5BZab5VeSEIMXKy/TvXMjCRXEy2DxNOSpdDcIPnc=;
        b=s7RMmwg3+xdT4V9GfPyC125WU4xDtUMifFwplWeDbEqP8GZeQr4ct4vHAcgSnnKeT/
         grvqY0QkIXKVdI7X/ccStRPkOBC4JMbnENlWPCDO9fNJkOmkESMLCPGGM3B4eLqku1jO
         DSlNPqguAVLEVpvn3RJ1xnFgNCfjIl81RioOnVFsZCbYzhGLVi1Mw8izMPnNWf1saOcJ
         InIewcRPtTTHRZ/FeMUQfIX2DBtOKTI/1IVCtMuO9orhKe2/NBkX+cHfa/pidbzQsYx3
         mAW9PBwa3cR8r7DZ9Oto3OEJXR6WMTIdwkqARtW4rD+9phlHqcvD7nAyqN857tJKyDsR
         qDJA==
X-Gm-Message-State: ABuFfogW95gtvSO1ArSVVUDVrNh8320ip9IDs5GtssEUdZIXRmZGhixA
        HmXkP6gazi3JcYjIpg5OFBS7BcScKe3bn2xoZtE=
X-Google-Smtp-Source: ACcGV61ck+91ETmnS2IdMQrINnCFhNdNtCAOB6ZTsorn2eO29vfV0PsTOzPLvPFz83FtCHyiofABFimbs5kEyma5YSA=
X-Received: by 2002:a9d:206c:: with SMTP id n99-v6mr14644247ota.142.1539015388355;
 Mon, 08 Oct 2018 09:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181004194108.29485-1-yuli@crunchydata.com> <CAFftDdpNVByPh+fGgVbnd-hR_C=k7RtNM8GUVxLC2bftvfQjtg@mail.gmail.com>
 <20181005143239.GC3445@baraddur.perfinion.com> <2b4b322c-c9ae-e12b-1119-02a4d0bfa732@ieee.org>
 <CAFftDdoSdwWwmU+8oT_ugzhSzYvAHQ6BCTzcBUr36snLbJfKpw@mail.gmail.com>
In-Reply-To: <CAFftDdoSdwWwmU+8oT_ugzhSzYvAHQ6BCTzcBUr36snLbJfKpw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 8 Oct 2018 09:16:17 -0700
Message-ID: <CAFftDdpY5o7ABVPi_-+9SZJGmMDT-OOHmUwfxh0e7DT=1i88Xw@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: improve semanage_migrate_store import failure
To:     Chris PeBenito <pebenito@ieee.org>
Cc:     Jason Zaman <jason@perfinion.com>, selinux <selinux@tycho.nsa.gov>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Weird Gmail removed my text box for plain text mode in Gmail,
re-sending since it got
filtered out of the mailing list.

On Mon, Oct 8, 2018 at 9:09 AM William Roberts <bill.c.roberts@gmail.com> wrote:
>
> Yuli,
> If you respin this with just import error looks like its a go.
> Bill
>
> On Fri, Oct 5, 2018 at 12:53 PM Chris PeBenito <pebenito@ieee.org> wrote:
>>
>> On 10/05/2018 10:32 AM, Jason Zaman wrote:
>> > On Fri, Oct 05, 2018 at 07:13:23AM -0700, William Roberts wrote:
>> >> On Thu, Oct 4, 2018 at 12:46 PM Yuli Khodorkovskiy <
>> >> yuli.khodorkovskiy@crunchydata.com> wrote:
>> >>
>> >>> The python module import error in semanage_migrate_store was misleading.
>> >>> Before, it would print that the module is not installed, even though
>> >>> it is in fact on the system.
>> >>>
>> >>> Now the python module import failure is correctly reported if the module
>> >>> is not installed or the exact reason for failure is reported to the user.
>> >>>
>> >>> Signed-off-by: Yuli Khodorkovskiy <yuli@crunchydata.com>
>> >>> ---
>> >>>   libsemanage/utils/semanage_migrate_store | 6 ++++--
>> >>>   1 file changed, 4 insertions(+), 2 deletions(-)
>> >>>
>> >>> diff --git a/libsemanage/utils/semanage_migrate_store
>> >>> b/libsemanage/utils/semanage_migrate_store
>> >>> index 2e6cb278..50eb59ef 100755
>> >>> --- a/libsemanage/utils/semanage_migrate_store
>> >>> +++ b/libsemanage/utils/semanage_migrate_store
>> >>> @@ -15,10 +15,12 @@ sepol = ctypes.cdll.LoadLibrary('libsepol.so.1')
>> >>>   try:
>> >>>          import selinux
>> >>>          import semanage
>> >>> -except:
>> >>> +except ImportError:
>> >>>          print("You must install libselinux-python and libsemanage-python
>> >>> before running this tool", file=sys.stderr)
>> >>>          exit(1)
>> >>> -
>> >>> +except Exception as e:
>> >>> +       print("Failed to import libselinux-python/libsemanage-python: %s"
>> >>> % str(e))
>> >>> +       exit(1)
>> >>>
>> >>
>> >> We should really only be handling exceptions we reasonably expect and
>> >> discourage
>> >> the usage of catching raw Exception, especially considering not-catching
>> >> this will
>> >> cause the runtime to print a stack trace, the error and exit non-zero.
>> >>
>> >> We probably only need the except ImportError change and can drop the second
>> >> hunk.
>> >>
>> >> Does anyone disagree with this?
>>
>> For this case, I agree that ImportError is the only thing that should be
>> caught.
>>
>> > Agreed. catching Exception is bad cuz it also catches KeyboardInterrupt
>> > and stuff like that.
>>
>> That's not correct.  Catching BaseException would catch
>> KeyboardInterrupt.  Catching Exception would not.  See the Python
>> builtin exception hierarchy:
>>
>> https://docs.python.org/3/library/exceptions.html#exception-hierarchy
>>
>> IMO catching Exception has valid uses.
>>
>> --
>> Chris PeBenito
