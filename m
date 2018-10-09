Return-Path: <SRS0=wI+O=MV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C9CC64EB8
	for <selinux@archiver.kernel.org>; Tue,  9 Oct 2018 15:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E21921479
	for <selinux@archiver.kernel.org>; Tue,  9 Oct 2018 15:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUnr9clb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E21921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeJIWTR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:19:17 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36854 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIWTR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Oct 2018 18:19:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id x4so552167otg.3
        for <selinux@vger.kernel.org>; Tue, 09 Oct 2018 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=21NW44R7GeM48hCujZLUWZir6h8kMzSHPDcxGmU13oo=;
        b=pUnr9clb0Rdgd6SOhYz0QTPWTtvQobtIJcqG1lVjQBBK3dB4GbE/B5EqPaRtSa0g7w
         5B3wSNmXYYHC07tmc60ncX/TtO7nOt5OcthV1zQu87tezavLV423IbHyBBrYXILfR3xS
         WPLSsdf+p2u6gY0BUkdIBVDchtoOvMsHlz/ypHcegwSO2UqzPDqSt63QNnNIULZSEZOv
         4298Zq3TlZyQ4ryZ2indvSZgAV/XkDZ72JazOkjl5NeZg5h2HgREYV5sEjhdd5s8dbwU
         kNfcwW7JmBVXKDtl1LAbaePsusJsa/t5AGB6THDo7Eu3heqW1iBonqESjd6oltJOukFs
         XfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=21NW44R7GeM48hCujZLUWZir6h8kMzSHPDcxGmU13oo=;
        b=Xz58QiWhy5Jbqw7414viZsB/p6lvZNGdbS1K/KTuvjq3jdc3xRsJwqwycZHAd/ezcB
         V2BF4hqTznwlIUrHajMDhCk7zggu5BIXJHlJjaDOH7+OcBVFRDqkO1JUTkgBBBfgYX3f
         74K4Iqy/rs7oSySNK3Lv8jiC/NP6f1Uvyx15XcUnO+woCFIuXNJKgnjS/YAUIG/kYGlv
         n4TlFWfNYoNG09kU6qhHInqYUxlC6RPtTWzw3/Vcj4rB4/NmzWvFgrd8qVVI+IoV8KnS
         OvEgs9gKt8rVGADs1zLiIcQeWRsnyO4nO51bYR+wIdz1PDaE0T0kLc1izUh8VpWL4OUM
         AOQA==
X-Gm-Message-State: ABuFfojXjkZD+bFchHsWMX2rcn05If7MHvLRH45UZ6uU5JQYDLHi07x+
        DTzRhdibyXXo4b8sfnF3OXxxKYl0MSWrlO/WHtA=
X-Google-Smtp-Source: ACcGV62CnYBgVyCXGCZkJsTCIutfVqxXC8edJRfS2KLP8vZgCd0+ZriVZewlKisNOIFrJqe68ms3GYhV5nBYu6mC5Xc=
X-Received: by 2002:a9d:5915:: with SMTP id t21-v6mr17410145oth.217.1539097315393;
 Tue, 09 Oct 2018 08:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181004194108.29485-1-yuli@crunchydata.com> <CAFftDdpNVByPh+fGgVbnd-hR_C=k7RtNM8GUVxLC2bftvfQjtg@mail.gmail.com>
 <20181005143239.GC3445@baraddur.perfinion.com> <2b4b322c-c9ae-e12b-1119-02a4d0bfa732@ieee.org>
 <CAFftDdoSdwWwmU+8oT_ugzhSzYvAHQ6BCTzcBUr36snLbJfKpw@mail.gmail.com>
 <CAFftDdpY5o7ABVPi_-+9SZJGmMDT-OOHmUwfxh0e7DT=1i88Xw@mail.gmail.com> <A93E8484-5EB6-4141-B71E-DD2E78EAEC68@crunchydata.com>
In-Reply-To: <A93E8484-5EB6-4141-B71E-DD2E78EAEC68@crunchydata.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 9 Oct 2018 08:01:43 -0700
Message-ID: <CAFftDdp=EpmLHVWgxfya-NBONT=uaS=dkuUGCSRv7vpBGkb6hA@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: improve semanage_migrate_store import failure
To:     yuli.khodorkovskiy@crunchydata.com
Cc:     Chris PeBenito <pebenito@ieee.org>,
        Jason Zaman <jason@perfinion.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 9, 2018 at 6:52 AM Yuli Khodorkovskiy
<yuli.khodorkovskiy@crunchydata.com> wrote:
>
>
>
> > On Oct 8, 2018, at 12:16 PM, William Roberts <bill.c.roberts@gmail.com>=
 wrote:
> >
> > Weird Gmail removed my text box for plain text mode in Gmail,
> > re-sending since it got
> > filtered out of the mailing list.
> >
> > On Mon, Oct 8, 2018 at 9:09 AM William Roberts <bill.c.roberts@gmail.co=
m> wrote:
> >>
> >> Yuli,
> >> If you respin this with just import error looks like its a go.
> >> Bill
> >>
> >> On Fri, Oct 5, 2018 at 12:53 PM Chris PeBenito <pebenito@ieee.org> wro=
te:
> >>>
> >>> On 10/05/2018 10:32 AM, Jason Zaman wrote:
> >>>> On Fri, Oct 05, 2018 at 07:13:23AM -0700, William Roberts wrote:
> >>>>> On Thu, Oct 4, 2018 at 12:46 PM Yuli Khodorkovskiy <
> >>>>> yuli.khodorkovskiy@crunchydata.com> wrote:
> >>>>>
> >>>>>> The python module import error in semanage_migrate_store was misle=
ading.
> >>>>>> Before, it would print that the module is not installed, even thou=
gh
> >>>>>> it is in fact on the system.
> >>>>>>
> >>>>>> Now the python module import failure is correctly reported if the =
module
> >>>>>> is not installed or the exact reason for failure is reported to th=
e user.
> >>>>>>
> >>>>>> Signed-off-by: Yuli Khodorkovskiy <yuli@crunchydata.com>
> >>>>>> ---
> >>>>>>  libsemanage/utils/semanage_migrate_store | 6 ++++--
> >>>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/libsemanage/utils/semanage_migrate_store
> >>>>>> b/libsemanage/utils/semanage_migrate_store
> >>>>>> index 2e6cb278..50eb59ef 100755
> >>>>>> --- a/libsemanage/utils/semanage_migrate_store
> >>>>>> +++ b/libsemanage/utils/semanage_migrate_store
> >>>>>> @@ -15,10 +15,12 @@ sepol =3D ctypes.cdll.LoadLibrary('libsepol.so=
.1')
> >>>>>>  try:
> >>>>>>         import selinux
> >>>>>>         import semanage
> >>>>>> -except:
> >>>>>> +except ImportError:
> >>>>>>         print("You must install libselinux-python and libsemanage-=
python
> >>>>>> before running this tool", file=3Dsys.stderr)
> >>>>>>         exit(1)
> >>>>>> -
> >>>>>> +except Exception as e:
> >>>>>> +       print("Failed to import libselinux-python/libsemanage-pyth=
on: %s"
> >>>>>> % str(e))
> >>>>>> +       exit(1)
> >>>>>>
> >>>>>
> >>>>> We should really only be handling exceptions we reasonably expect a=
nd
> >>>>> discourage
> >>>>> the usage of catching raw Exception, especially considering not-cat=
ching
> >>>>> this will
> >>>>> cause the runtime to print a stack trace, the error and exit non-ze=
ro.
> >>>>>
> >>>>> We probably only need the except ImportError change and can drop th=
e second
> >>>>> hunk.
> >>>>>
> >>>>> Does anyone disagree with this?
> >>>
> >>> For this case, I agree that ImportError is the only thing that should=
 be
> >>> caught.
> >>>
> >>>> Agreed. catching Exception is bad cuz it also catches KeyboardInterr=
upt
> >>>> and stuff like that.
> >>>
> >>> That's not correct.  Catching BaseException would catch
> >>> KeyboardInterrupt.  Catching Exception would not.  See the Python
> >>> builtin exception hierarchy:
> >>>
> >>> https://docs.python.org/3/library/exceptions.html#exception-hierarchy
> >>>
> >>> IMO catching Exception has valid uses.
> >>>
> >>> --
> >>> Chris PeBenito
>
> The reason I went the path of catching general exception was the possibil=
ity
> of a missing symbol from _selinux.so. For example:
>
> Traceback (most recent call last):
>   File "libsemanage/utils/semanage_migrate_store", line 16, in <module>
>     import selinux
>   File "/usr/lib64/python2.7/site-packages/selinux/__init__.py", line 512=
, in <module>
>     SELABEL_CTX_ANDROID_SERVICE =3D _selinux.SELABEL_CTX_ANDROID_SERVICE
> AttributeError: 'module' object has no attribute =E2=80=98SELABEL_CTX_AND=
ROID_SERVICE'
>
> Should I just catch AttributeError as well and if more exceptions come up=
 in the future
> we can catch them directly?

Yes, especially when you're not doing anything better than the default
exception mechanism
itself. In fact you kill the stack trace without providing a better
diagnostic for users. So catch
Exceptions but provide something better then what the exception
mechanism is doing.
