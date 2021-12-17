Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA0FC433F5
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 18:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhLQSWZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhLQSWY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 13:22:24 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79906C061574
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:22:24 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id r26so4861252oiw.5
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WMKkQmcPD7czqqYpf0pCVgfhY2jBq6TSRvc672yWZxo=;
        b=nNwXd71WeSStY/9CHeXFqbp3Z32ovg2/lSuzLcLr9js5IOQWxQCZrDKN8I9MmdNWIt
         pmU6htjZLxbs1QZ+ahjxmmoAG2TmQr43Uvs+Mos+MCTWu4truC/U5NTBoulMJGmZ5mNS
         DC6m9/7sH7aJKA1ex5CWzQ0HE7tM7ijpdIBcfsXQ5EPNJ1xAB9V6CS6kmxVzvX7dgZ81
         TzHxP4pGRuRreChFVGcyoHAqqSpsMsVa/NSKuhCBchmUU0Kp8W/RKApFofFJwS/TJok/
         otXzo73QuT3MxDwhKolcu/9NHkjz1oFoUWc5nTl0sTUJdUbxcWiHA2RLTTzlb2HaB6Mq
         uLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WMKkQmcPD7czqqYpf0pCVgfhY2jBq6TSRvc672yWZxo=;
        b=UutScBdWnm/0fVt3SKY8Vt0Wb50jr6NrQo09MFNzjSi18z6LFHDaRyQqg0hci2/iUv
         9btTwbsemrcpD7MPY7CIfbpJ5D/eHns8JMXKjgYjr4vq0xBHVu42L3sKlAoHCWTPZicP
         W0SA9LTsPZoS51nJlSgmSbXhi9x7blRf22K6lJ2DqHCr7ToqfqK8EPObmql4J3I8sDyQ
         G/ldm37ijl/jQ8JfBzjsCWomZ0I4/gKWVJbDIT0figR4Ac50bK1Msgd2HfKKHMDdQ1Py
         6FNfL4pCuVcd+mEoScz8/xfyK/Ai1KWYsEBUdUphMFe1o6csjy7oMIZKJaYIgnl2eaKc
         j7Lg==
X-Gm-Message-State: AOAM533gRo6wDAseXEDNJKKVkCYfxdpm88UdUOCHGOl1Swyr8IiG1Rod
        b7EdVXQSPMl2CNud/h5E3qq0mhZ7ANT+WjK4bK5DO1nr
X-Google-Smtp-Source: ABdhPJz8ndvga9vYzISmGe1VRgUNhNCOgqoYpOzCj3criAmD8fxKF+fmMoVJa8IASCDwM4Siylxh3PXoyQWKoFGLXe0=
X-Received: by 2002:a05:6808:179d:: with SMTP id bg29mr8738741oib.138.1639765343810;
 Fri, 17 Dec 2021 10:22:23 -0800 (PST)
MIME-Version: 1.0
References: <20211217181913.336360-1-jwcart2@gmail.com>
In-Reply-To: <20211217181913.336360-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 17 Dec 2021 13:22:12 -0500
Message-ID: <CAP+JOzSPuHcm3EwfLS+5MOm4-BcFfnXZZfQQJkvx1o9KZZMs+g@mail.gmail.com>
Subject: Re: [PATCH 00/16] Refactor and fix assertion checking
To:     SElinux list <selinux@vger.kernel.org>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: multipart/mixed; boundary="000000000000d54ed705d35b9e03"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--000000000000d54ed705d35b9e03
Content-Type: text/plain; charset="UTF-8"

If you want to test any of this, attached is a policy to do that.
Jim

On Fri, Dec 17, 2021 at 1:19 PM James Carter <jwcart2@gmail.com> wrote:
>
> The first 13 patches refactor and cleanup the neverallow and
> neverallowxperm checking code to make it easier to understand.
>
> The last 3 patches fixes errors in the assertion checking code.
>
> This series is to prepare for adding not-self support to assertion
> checking.
>
> James Carter (16):
>   libsepol: Return an error if check_assertion() returns an error.
>   libsepol: Change label in check_assertion_avtab_match()
>   libsepol: Remove uneeded error messages in assertion checking
>   libsepol: Check for error from check_assertion_extended_permissions()
>   libsepol: Use consistent return checking style
>   libsepol: Move check of target types to before check for self
>   libsepol: Create function check_assertion_self_match() and use it
>   libsepol: Use (rc < 0) instead of (rc) when calling ebitmap functions
>   libsepol: Remove unnessesary check for matching class
>   libsepol: Move assigning outer loop index out of inner loop
>   libsepol: Make use of previously created ebitmap when checking self
>   libsepol: Refactor match_any_class_permissions() to be clearer
>   libsepol: Make return value clearer when reporting neverallowx errors
>   libsepol: The src and tgt must be the same if neverallow uses self
>   libsepol: Set args avtab pointer when reporting assertion violations
>   libsepol: Fix two problems with neverallowxperm reporting
>
>  libsepol/src/assertion.c | 193 +++++++++++++++++++++------------------
>  1 file changed, 102 insertions(+), 91 deletions(-)
>
> --
> 2.31.1
>

--000000000000d54ed705d35b9e03
Content-Type: text/plain; charset="US-ASCII"; name="policy_test.conf"
Content-Disposition: attachment; filename="policy_test.conf"
Content-Transfer-Encoding: base64
Content-ID: <f_kxapxu5w0>
X-Attachment-Id: f_kxapxu5w0

Y2xhc3MgQ0xBU1MxCmNsYXNzIENMQVNTMgpjbGFzcyBDTEFTUzMKY2xhc3MgQ0xBU1M0CmNsYXNz
IENMQVNTNQpjbGFzcyBDTEFTUzYKc2lkIGtlcm5lbApjbGFzcyBDTEFTUzEgeyBQRVJNMUEgUEVS
TTFCIFBFUk0xQyBQRVJNMUQgfQpjbGFzcyBDTEFTUzIgeyBQRVJNMkEgUEVSTTJCIFBFUk0yQyBQ
RVJNMkQgfQpjbGFzcyBDTEFTUzMgeyBQRVJNM0EgUEVSTTNCIFBFUk0zQyBQRVJNM0QgfQpjbGFz
cyBDTEFTUzQgeyBpb2N0bCB9CmNsYXNzIENMQVNTNSB7IGlvY3RsIH0KY2xhc3MgQ0xBU1M2IHsg
aW9jdGwgfQpzZW5zaXRpdml0eSBTRU5TMTsKZG9taW5hbmNlIHsgU0VOUzEgfQpjYXRlZ29yeSBD
QVQxOwpsZXZlbCBTRU5TMTpDQVQxOwptbHNjb25zdHJhaW4gQ0xBU1MxIHsgUEVSTTFBIH0gKGgx
IGRvbSBoMiBhbmQgbDEgZG9tYnkgaDEpOwptbHN2YWxpZGF0ZXRyYW5zIENMQVNTMSAobDEgPT0g
bDIgb3IgbDEgaW5jb21wIGwyKTsKYXR0cmlidXRlIFRBVFRSMTsKYXR0cmlidXRlIFRBVFRSMjsK
dHlwZSBUWVBFMTsKdHlwZSBUWVBFMjsKdHlwZSBUWVBFMzsKdHlwZWF0dHJpYnV0ZSBUWVBFMSBU
QVRUUjEsIFRBVFRSMjsKdHlwZWF0dHJpYnV0ZSBUWVBFMiBUQVRUUjEsIFRBVFRSMjsKdHlwZWF0
dHJpYnV0ZSBUWVBFMyBUQVRUUjE7CgoKIyBUZXN0IHNlbGYgbmV2ZXJhbGxvdwoKI2FsbG93IFRZ
UEUxICAgIHNlbGYgOiBDTEFTUzEgUEVSTTFBOyAjIG5ldmVyYWxsb3cgdmlvbGF0aW9uCiNhbGxv
dyBUWVBFMSAgIFRZUEUxIDogQ0xBU1MxIFBFUk0xQTsgIyBuZXZlcmFsbG93IHZpb2xhdGlvbgoj
YWxsb3cgVFlQRTEgIFRBVFRSMSA6IENMQVNTMSBQRVJNMUE7ICMgbmV2ZXJhbGxvdyB2aW9sYXRp
b24KI2FsbG93IFRBVFRSMSAgIHNlbGYgOiBDTEFTUzEgUEVSTTFBOyAjIG5ldmVyYWxsb3cgdmlv
bGF0aW9uCiNhbGxvdyBUQVRUUjEgIFRZUEUxIDogQ0xBU1MxIFBFUk0xQTsgIyBuZXZlcmFsbG93
IHZpb2xhdGlvbgojYWxsb3cgVEFUVFIxIFRBVFRSMSA6IENMQVNTMSBQRVJNMUE7ICMgbmV2ZXJh
bGxvdyB2aW9sYXRpb24KI2FsbG93IFRBVFRSMSBUQVRUUjIgOiBDTEFTUzEgUEVSTTFBOyAjIG5l
dmVyYWxsb3cgdmlvbGF0aW9uCmFsbG93IFRZUEUxIFRZUEUyIDogQ0xBU1MxIFBFUk0xQTsgIyBO
T1QgYSBuZXZlcmFsbG93IHZpb2xhdGlvbgphbGxvdyBUWVBFMSBUWVBFMyA6IENMQVNTMSBQRVJN
MUE7ICMgTk9UIGEgbmV2ZXJhbGxvdyB2aW9sYXRpb24KYWxsb3cgVFlQRTIgVFlQRTEgOiBDTEFT
UzEgUEVSTTFBOyAjIE5PVCBhIG5ldmVyYWxsb3cgdmlvbGF0aW9uCmFsbG93IFRZUEUyIFRZUEUz
IDogQ0xBU1MxIFBFUk0xQTsgIyBOT1QgYSBuZXZlcmFsbG93IHZpb2xhdGlvbgphbGxvdyBUWVBF
MyBUWVBFMSA6IENMQVNTMSBQRVJNMUE7ICMgTk9UIGEgbmV2ZXJhbGxvdyB2aW9sYXRpb24KYWxs
b3cgVFlQRTMgVFlQRTIgOiBDTEFTUzEgUEVSTTFBOyAjIE5PVCBhIG5ldmVyYWxsb3cgdmlvbGF0
aW9uCm5ldmVyYWxsb3cgVFlQRTEgc2VsZiA6IENMQVNTMSBQRVJNMUE7CgojYWxsb3cgVFlQRTEg
ICAgc2VsZiA6IENMQVNTMSBQRVJNMUI7ICMgbmV2ZXJhbGxvdyB2aW9sYXRpb24KI2FsbG93IFRZ
UEUyICAgIHNlbGYgOiBDTEFTUzEgUEVSTTFCOyAjIG5ldmVyYWxsb3cgdmlvbGF0aW9uCiNhbGxv
dyBUWVBFMyAgICBzZWxmIDogQ0xBU1MxIFBFUk0xQjsgIyBuZXZlcmFsbG93IHZpb2xhdGlvbgoj
YWxsb3cgVFlQRTEgICBUWVBFMSA6IENMQVNTMSBQRVJNMUI7ICMgbmV2ZXJhbGxvdyB2aW9sYXRp
b24KI2FsbG93IFRZUEUyICAgVFlQRTIgOiBDTEFTUzEgUEVSTTFCOyAjIG5ldmVyYWxsb3cgdmlv
bGF0aW9uCiNhbGxvdyBUWVBFMyAgIFRZUEUzIDogQ0xBU1MxIFBFUk0xQjsgIyBuZXZlcmFsbG93
IHZpb2xhdGlvbgojYWxsb3cgVFlQRTEgIFRBVFRSMSA6IENMQVNTMSBQRVJNMUI7ICMgbmV2ZXJh
bGxvdyB2aW9sYXRpb24KI2FsbG93IFRZUEUyICBUQVRUUjEgOiBDTEFTUzEgUEVSTTFCOyAjIG5l
dmVyYWxsb3cgdmlvbGF0aW9uCiNhbGxvdyBUWVBFMyAgVEFUVFIxIDogQ0xBU1MxIFBFUk0xQjsg
IyBuZXZlcmFsbG93IHZpb2xhdGlvbgojYWxsb3cgVEFUVFIxICAgc2VsZiA6IENMQVNTMSBQRVJN
MUI7ICMgbmV2ZXJhbGxvdyB2aW9sYXRpb24KI2FsbG93IFRBVFRSMSAgVFlQRTEgOiBDTEFTUzEg
UEVSTTFCOyAjIG5ldmVyYWxsb3cgdmlvbGF0aW9uCiNhbGxvdyBUQVRUUjEgIFRZUEUyIDogQ0xB
U1MxIFBFUk0xQjsgIyBuZXZlcmFsbG93IHZpb2xhdGlvbgojYWxsb3cgVEFUVFIxICBUWVBFMyA6
IENMQVNTMSBQRVJNMUI7ICMgbmV2ZXJhbGxvdyB2aW9sYXRpb24KI2FsbG93IFRBVFRSMSBUQVRU
UjEgOiBDTEFTUzEgUEVSTTFCOyAjIG5ldmVyYWxsb3cgdmlvbGF0aW9uCiNhbGxvdyBUQVRUUjEg
VEFUVFIyIDogQ0xBU1MxIFBFUk0xQjsgIyBuZXZlcmFsbG93IHZpb2xhdGlvbgphbGxvdyBUWVBF
MSBUWVBFMiA6IENMQVNTMSBQRVJNMUI7ICMgTk9UIGEgbmV2ZXJhbGxvdyB2aW9sYXRpb24KYWxs
b3cgVFlQRTEgVFlQRTMgOiBDTEFTUzEgUEVSTTFCOyAjIE5PVCBhIG5ldmVyYWxsb3cgdmlvbGF0
aW9uCmFsbG93IFRZUEUyIFRZUEUxIDogQ0xBU1MxIFBFUk0xQjsgIyBOT1QgYSBuZXZlcmFsbG93
IHZpb2xhdGlvbgphbGxvdyBUWVBFMiBUWVBFMyA6IENMQVNTMSBQRVJNMUI7ICMgTk9UIGEgbmV2
ZXJhbGxvdyB2aW9sYXRpb24KYWxsb3cgVFlQRTMgVFlQRTEgOiBDTEFTUzEgUEVSTTFCOyAjIE5P
VCBhIG5ldmVyYWxsb3cgdmlvbGF0aW9uCmFsbG93IFRZUEUzIFRZUEUyIDogQ0xBU1MxIFBFUk0x
QjsgIyBOT1QgYSBuZXZlcmFsbG93IHZpb2xhdGlvbgpuZXZlcmFsbG93IFRBVFRSMSBzZWxmIDog
Q0xBU1MxIFBFUk0xQjsKCgojIFRlc3Qgc2VsZiBuZXZlcmFsbG93eHBlcm0KCmFsbG93IFRBVFRS
MSBUQVRUUjEgOiBDTEFTUzQgaW9jdGw7CmFsbG93eHBlcm0gVEFUVFIxIFRBVFRSMSA6IENMQVNT
NCBpb2N0bCAweDk0MDE7CgojYWxsb3d4cGVybSBUWVBFMSAgICBzZWxmIDogQ0xBU1M0IGlvY3Rs
IDB4OTQxMTsgIyBuZXZlcmFsbG93eHBlcm0gdmlvbGF0aW9uCiNhbGxvd3hwZXJtIFRZUEUxICAg
VFlQRTEgOiBDTEFTUzQgaW9jdGwgMHg5NDExOyAjIG5ldmVyYWxsb3d4cGVybSB2aW9sYXRpb24K
I2FsbG93eHBlcm0gVFlQRTEgIFRBVFRSMSA6IENMQVNTNCBpb2N0bCAweDk0MTE7ICMgbmV2ZXJh
bGxvd3hwZXJtIHZpb2xhdGlvbgojYWxsb3d4cGVybSBUQVRUUjEgICBzZWxmIDogQ0xBU1M0IGlv
Y3RsIDB4OTQxMTsgIyBuZXZlcmFsbG93eHBlcm0gdmlvbGF0aW9uCiNhbGxvd3hwZXJtIFRBVFRS
MSAgVFlQRTEgOiBDTEFTUzQgaW9jdGwgMHg5NDExOyAjIG5ldmVyYWxsb3d4cGVybSB2aW9sYXRp
b24KI2FsbG93eHBlcm0gVEFUVFIxIFRBVFRSMSA6IENMQVNTNCBpb2N0bCAweDk0MTE7ICMgbmV2
ZXJhbGxvd3hwZXJtIHZpb2xhdGlvbgojYWxsb3d4cGVybSBUQVRUUjEgVEFUVFIyIDogQ0xBU1M0
IGlvY3RsIDB4OTQxMTsgIyBuZXZlcmFsbG93eHBlcm0gdmlvbGF0aW9uCmFsbG93eHBlcm0gVFlQ
RTEgICBUWVBFMiA6IENMQVNTNCBpb2N0bCAweDk0MTE7ICMgTm90IGEgdmlvbGF0aW9uCmFsbG93
eHBlcm0gVFlQRTEgICBUWVBFMyA6IENMQVNTNCBpb2N0bCAweDk0MTE7ICMgTm90IGEgdmlvbGF0
aW9uCmFsbG93eHBlcm0gVFlQRTIgICBUWVBFMSA6IENMQVNTNCBpb2N0bCAweDk0MTE7ICMgTm90
IGEgdmlvbGF0aW9uCmFsbG93eHBlcm0gVFlQRTIgICBUWVBFMyA6IENMQVNTNCBpb2N0bCAweDk0
MTE7ICMgTm90IGEgdmlvbGF0aW9uCmFsbG93eHBlcm0gVFlQRTMgICBUWVBFMSA6IENMQVNTNCBp
b2N0bCAweDk0MTE7ICMgTm90IGEgdmlvbGF0aW9uCmFsbG93eHBlcm0gVFlQRTMgICBUWVBFMiA6
IENMQVNTNCBpb2N0bCAweDk0MTE7ICMgTm90IGEgdmlvbGF0aW9uCm5ldmVyYWxsb3d4cGVybSBU
WVBFMSBzZWxmIDogQ0xBU1M0IGlvY3RsIDB4OTQxMTsKCgojYWxsb3d4cGVybSBUWVBFMSAgICBz
ZWxmIDogQ0xBU1M0IGlvY3RsIDB4OTQyMTsgIyBuZXZlcmFsbG93eHBlcm0gdmlvbGF0aW9uCiNh
bGxvd3hwZXJtIFRZUEUxICAgVFlQRTEgOiBDTEFTUzQgaW9jdGwgMHg5NDIxOyAjIG5ldmVyYWxs
b3d4cGVybSB2aW9sYXRpb24KI2FsbG93eHBlcm0gVFlQRTIgICBUWVBFMiA6IENMQVNTNCBpb2N0
bCAweDk0MjE7ICMgbmV2ZXJhbGxvd3hwZXJtIHZpb2xhdGlvbgojYWxsb3d4cGVybSBUWVBFMyAg
IFRZUEUzIDogQ0xBU1M0IGlvY3RsIDB4OTQyMTsgIyBuZXZlcmFsbG93eHBlcm0gdmlvbGF0aW9u
CiNhbGxvd3hwZXJtIFRZUEUxICBUQVRUUjEgOiBDTEFTUzQgaW9jdGwgMHg5NDIxOyAjIG5ldmVy
YWxsb3d4cGVybSB2aW9sYXRpb24KI2FsbG93eHBlcm0gVFlQRTIgIFRBVFRSMSA6IENMQVNTNCBp
b2N0bCAweDk0MjE7ICMgbmV2ZXJhbGxvd3hwZXJtIHZpb2xhdGlvbgojYWxsb3d4cGVybSBUWVBF
MyAgVEFUVFIxIDogQ0xBU1M0IGlvY3RsIDB4OTQyMTsgIyBuZXZlcmFsbG93eHBlcm0gdmlvbGF0
aW9uCiNhbGxvd3hwZXJtIFRBVFRSMSAgIHNlbGYgOiBDTEFTUzQgaW9jdGwgMHg5NDIxOyAjIG5l
dmVyYWxsb3d4cGVybSB2aW9sYXRpb24KI2FsbG93eHBlcm0gVEFUVFIxICBUWVBFMSA6IENMQVNT
NCBpb2N0bCAweDk0MjE7ICMgbmV2ZXJhbGxvd3hwZXJtIHZpb2xhdGlvbgojYWxsb3d4cGVybSBU
QVRUUjEgIFRZUEUyIDogQ0xBU1M0IGlvY3RsIDB4OTQyMTsgIyBuZXZlcmFsbG93eHBlcm0gdmlv
bGF0aW9uCiNhbGxvd3hwZXJtIFRBVFRSMSAgVFlQRTMgOiBDTEFTUzQgaW9jdGwgMHg5NDIxOyAj
IG5ldmVyYWxsb3d4cGVybSB2aW9sYXRpb24KI2FsbG93eHBlcm0gVEFUVFIxIFRBVFRSMSA6IENM
QVNTNCBpb2N0bCAweDk0MjE7ICMgbmV2ZXJhbGxvd3hwZXJtIHZpb2xhdGlvbgojYWxsb3d4cGVy
bSBUQVRUUjEgVEFUVFIyIDogQ0xBU1M0IGlvY3RsIDB4OTQyMTsgIyBuZXZlcmFsbG93eHBlcm0g
dmlvbGF0aW9uCmFsbG93eHBlcm0gVFlQRTEgVFlQRTIgOiBDTEFTUzQgaW9jdGwgMHg5NDIxOyAj
IE5PVCBhIHZpb2xhdGlvbgphbGxvd3hwZXJtIFRZUEUxIFRZUEUzIDogQ0xBU1M0IGlvY3RsIDB4
OTQyMTsgIyBOT1QgYSB2aW9sYXRpb24KYWxsb3d4cGVybSBUWVBFMiBUWVBFMSA6IENMQVNTNCBp
b2N0bCAweDk0MjE7ICMgTk9UIGEgdmlvbGF0aW9uCmFsbG93eHBlcm0gVFlQRTIgVFlQRTMgOiBD
TEFTUzQgaW9jdGwgMHg5NDIxOyAjIE5PVCBhIHZpb2xhdGlvbgphbGxvd3hwZXJtIFRZUEUzIFRZ
UEUxIDogQ0xBU1M0IGlvY3RsIDB4OTQyMTsgIyBOT1QgYSB2aW9sYXRpb24KYWxsb3d4cGVybSBU
WVBFMyBUWVBFMiA6IENMQVNTNCBpb2N0bCAweDk0MjE7ICMgTk9UIGEgdmlvbGF0aW9uCm5ldmVy
YWxsb3d4cGVybSBUQVRUUjEgc2VsZiA6IENMQVNTNCBpb2N0bCAweDk0MjE7CgoKCnJvbGUgUk9M
RTE7CnJvbGUgUk9MRTEgdHlwZXMgVFlQRTE7CnVzZXIgVVNFUjEgcm9sZXMgUk9MRTEgbGV2ZWwg
U0VOUzEgcmFuZ2UgU0VOUzEgLSBTRU5TMTpDQVQxOwpzaWQga2VybmVsIFVTRVIxOlJPTEUxOlRZ
UEUxOlNFTlMxIC0gU0VOUzEK
--000000000000d54ed705d35b9e03--
