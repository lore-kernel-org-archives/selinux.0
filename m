Return-Path: <SRS0=2KQY=46=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B657AC10DCE
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 14:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F0C206FA
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 14:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5r+mmLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgCMOWQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:22:16 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39546 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMOWP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Mar 2020 10:22:15 -0400
Received: by mail-ot1-f66.google.com with SMTP id a9so10247585otl.6
        for <selinux@vger.kernel.org>; Fri, 13 Mar 2020 07:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GBqOn3wGXHDfCgMQyiHRMQQIVib1twiSuECc/L1tXOU=;
        b=r5r+mmLbB9OJZyymu4tghYYK5lLjemRatoPYM7pLaZpPWjuSKvWoLDAsIA6m8E9c0Y
         iamiuLyNqDobvPdvhTjYMRmwwmPdPOfOWS7Dd8tVlGa7hdmTloS3rtIz67pKl9wktbAJ
         M6nicIQoVs/fKm1Uo/0DpvhkVFW/do4553h1m27KJ1Ls+T4sNozIzysiT/S1/SuTqvPL
         n09/zXqD6ze9FHSMC+WEBK2Hzyy5//UGA8dDmZrSCt9fxmBfhr8O1JvPAs171H7jo5rg
         juruNDf3/r0xBrcCD7z93TjNiOvTd5+MxR7+i9JORI+7a5oXeVLdDJhIyKh8XTtoMpcp
         wcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GBqOn3wGXHDfCgMQyiHRMQQIVib1twiSuECc/L1tXOU=;
        b=h92mm8YuLok5WsRIWoQ6H5qGuicInC9o01WzK9hK3ag+Zp56lgHRvi6lLvw6r0adCv
         4ZL9Xb544cpK6/T1vQiSbW8Lh99eGxWurCVU/8FHCvjNd5uDL22rOS9QbieRbOmy/yYT
         dYxnMACGGRvx+HOm7uagjBhTiCVwEf4NsZMTuCjWOcH32jb4Us+8la9lX8V/L7WbQGIG
         /Iqv1iPDXFcFuKYZuRppQ4q8Bcb0dk3uErdPgXl8gFatqmOFpRXwyhmRIhFqIEwmikhI
         W5RIMd9gSjqw8gipVj7yr+p79wuN1y/JFJl0QZlz7dodLXjEtWKe4bo3kptzYLiHsXwC
         GE7g==
X-Gm-Message-State: ANhLgQ2pelmsJOzldwIF5P3tPgACJxJ4YzgCuSsourfHQ7CH9l/1Yw1N
        noQtzYK3jA/1LyI/roAv+vlINEgOkELYSNd3/0A=
X-Google-Smtp-Source: ADFU+vsStVtIHlbvI9BddnvBbyGU6h7QMf04XMuc8QUWUBHeW/lq1Z19Xe93x1UQwYadLH37pqtl9KIqfNIm453AaXE=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr11408624otl.162.1584109334777;
 Fri, 13 Mar 2020 07:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200313134047.27338-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200313134047.27338-1-stephen.smalley.work@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 13 Mar 2020 10:23:08 -0400
Message-ID: <CAEjxPJ5kicrU0W9dEBu_Vu2POEyvt63Q0pyiKkQr-NHZnV1DBA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: add unprivileged sandboxing capability
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="0000000000002fc88c05a0bd32eb"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--0000000000002fc88c05a0bd32eb
Content-Type: text/plain; charset="UTF-8"

On Fri, Mar 13, 2020 at 9:41 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Example
> -------
> Note, this example requires the separate selinux userspace patch to
> be applied, built, and installed to support the extensions to secilc
> and the new sebox command below.
>
> $ sudo semodule -cE base
> $ sudo vi base.cil
> <add "sandbox" to (class security (....))>
> $ sudo semodule -i base.cil
>
> $ cat ./definesandboxclass.cil
> (class sandbox (load_policy unload_policy))
> (classorder (unordered sandbox))
> $ sudo semodule -i definesandboxclass.cil
>
> $ cat ./unconfinedcansandbox.cil
> ; allow unconfined_t to sandbox itself
> (allow unconfined_t unconfined_t (security (sandbox)))
> (allow unconfined_t unconfined_t (sandbox (load_policy unload_policy)))
> $ sudo semodule -i unconfinedcansandbox.cil
>
> $ cat ./no-tmp.cil
> ; some boilerplate required by current limitations in secilc
> ; is omitted here to keep this text simple and readable,
> ; see the follow-up message for the full no-tmp.cil file.
> (class dir (read getattr open search))
> (class file (getattr))
> (classorder (dir file))
> (type unconfined_t)
> (type tmp_t)
> (deny unconfined_t tmp_t (dir (read getattr open search)))
> (deny unconfined_t tmp_t (file (getattr)))

Attached is the complete no-tmp.cil file.
The boilerplate is just a reflection of the current prototype status
of the implementation
and it should be possible to omit it in the future.

--0000000000002fc88c05a0bd32eb
Content-Type: application/vnd.ms-artgalry; name="no-tmp.cil"
Content-Disposition: attachment; filename="no-tmp.cil"
Content-Transfer-Encoding: base64
Content-ID: <f_k7q9srm90>
X-Attachment-Id: f_k7q9srm90

OyBUaGlzIGluZm9ybWF0aW9uIGlzIE5PVCBjb21waWxlZCBpbnRvIGEgc2FuZGJveCBwb2xpY3ks
IGl0IGlzIGhlcmUganVzdCB0bwo7IG1ha2UgdGhlIGNpbCBjb21waWxlciBoYXBweS4gRm9yIG5v
dywgd2UgbGVhdmUgaXQgaGVyZSB3aXRoIGR1bW15IGluZm9ybWF0aW9uLgooc2lkIFNJRCkKKHNp
ZG9yZGVyIChTSUQpKQoodXNlciBVU0VSKQoocm9sZSBST0xFKQooY2F0ZWdvcnkgQ0FUKQooY2F0
ZWdvcnlvcmRlciAoQ0FUKSkKKHNlbnNpdGl2aXR5IFNFTlMpCihzZW5zaXRpdml0eW9yZGVyIChT
RU5TKSkKKHNlbnNpdGl2aXR5Y2F0ZWdvcnkgU0VOUyAoQ0FUKSkKKHJvbGV0eXBlIFJPTEUgdG1w
X3QpCih1c2Vycm9sZSBVU0VSIFJPTEUpCih1c2VybGV2ZWwgVVNFUiAoU0VOUykpCih1c2VycmFu
Z2UgVVNFUiAoKFNFTlMpKFNFTlMgKENBVCkpKSkKKHNpZGNvbnRleHQgU0lEIChVU0VSIFJPTEUg
dG1wX3QgKChTRU5TKShTRU5TKSkpKQo7IHN0YXJ0IG9mIHJlYWwgY29udGVudAooY2xhc3MgZGly
IChyZWFkIGdldGF0dHIgb3BlbiBzZWFyY2ggcm1kaXIpKQooY2xhc3MgZmlsZSAoZ2V0YXR0cikp
CihjbGFzc29yZGVyIChkaXIgZmlsZSkpCih0eXBlIHVuY29uZmluZWRfdCkKKHR5cGUgdG1wX3Qp
CihkZW55IHVuY29uZmluZWRfdCB0bXBfdCAoZGlyIChyZWFkIGdldGF0dHIgb3BlbiBzZWFyY2gp
KSkKKGRlbnkgdW5jb25maW5lZF90IHRtcF90IChmaWxlIChnZXRhdHRyKSkpCg==
--0000000000002fc88c05a0bd32eb--
