Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADBBC0015E
	for <selinux@archiver.kernel.org>; Tue, 15 Aug 2023 11:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjHOL6m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Aug 2023 07:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237028AbjHOL6a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Aug 2023 07:58:30 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951E11BFC
        for <selinux@vger.kernel.org>; Tue, 15 Aug 2023 04:57:59 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bc9254a1baso4641914a34.2
        for <selinux@vger.kernel.org>; Tue, 15 Aug 2023 04:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692100677; x=1692705477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckRh0rScrDr9jXiEWBkSBaOe4pLKuZneY5EV2B4+ycE=;
        b=i3kCXsQTXvPArJ5onOm7Yvf/xAoHA6YQ61fkqN0cwJ21+5pZ00bPTDD+GEFjKNiqnR
         3osiUWKkdtvi6z8ijSoM7nrCz0XoYLlNiu9D8j1faYkfthrEEVRm7cqG3LUcJ+ooEvjN
         GU5EvcttpARSNKwWrLKT7bf8rSuM4vapkWvNuN7dnwZ7HtdVHpWChqfljLh5KUwcAvm5
         P0lQNhEpFoZuXX8ZSu204+JeC05/2/yuVJ18L9xEEy77+UYlWZQ2cozGm1+o3ege0GOP
         eE+GR3lTINljjI4TAoloFGVHgn1fAcWf1RhzEnAlDaBvVmEEHOnjMU3hSRhWee207/Qm
         K0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692100677; x=1692705477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckRh0rScrDr9jXiEWBkSBaOe4pLKuZneY5EV2B4+ycE=;
        b=ZftGIdgzJgc47NVRoZvv0Q3Ns+YWVz7hxO1XaL8lQJU3lhVAyIn9W2ZelXOnkkcq7k
         t8TrOBTHCzbrtjeMccGG70cq+Dd1OQdSAqljl0nSxtkQfJhdhnTDGV4nSk2FfpSvVHTz
         WSY4llXJbIVWHYBtRshzVBeoL+gpNV4AaWucF122+BHUV8EHn2oMzpjRNJTDnn46uz4N
         cNHHhUxejmfqU4r1Tkp5DSLmUbbn+xHLo4bTfp2QWdsMcKKHN8i56ZCTxjc3x8i+ugyD
         wa1TXiEWugMhdt/iB2qORSgN/ijSOVVshdlhkgGvkPODgp6th6yE4Dd/RTsuVdvem+gH
         111w==
X-Gm-Message-State: AOJu0YxVIkYrPfMNYhPONzWDDY46+Exsg9xxp27Oz4oJObJM3lQRrHFS
        cAuF5gD6alqKTCPBaaPbZ17tUoEZEauR+XCurVpgdeUr
X-Google-Smtp-Source: AGHT+IH/TR6Jwa1EsDM50ddUqftLofD5wbGWiZ1fKcEwaebCBo55FWApZPHq+8VCkIzW2oZR/TK6K9j6vzWrp1QBhOw=
X-Received: by 2002:a9d:6a14:0:b0:6b9:a926:4a12 with SMTP id
 g20-20020a9d6a14000000b006b9a9264a12mr13521077otn.28.1692100677083; Tue, 15
 Aug 2023 04:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <CACzUrp6nZ_YL0gM1i4fUpPqHtnyNniwCFJbG2bFseGSUmZ3MKg@mail.gmail.com>
In-Reply-To: <CACzUrp6nZ_YL0gM1i4fUpPqHtnyNniwCFJbG2bFseGSUmZ3MKg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 15 Aug 2023 07:57:45 -0400
Message-ID: <CAEjxPJ7x9CQ=nyOW5y9OsWPTNhXnWOQaFf4X9O4DPLadVXhQcw@mail.gmail.com>
Subject: Re: AWS RHEL Image / SplunkWeb / SELinux
To:     Alan Ma <alanma@gwmail.gwu.edu>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 14, 2023 at 9:41=E2=80=AFPM Alan Ma <alanma@gwmail.gwu.edu> wro=
te:
>
> Hello SELinux experts,
>
> I have one odd RHEL 8 AWS host that refuses to allow me to run on port 80=
00 for Splunk to run it's Web application when SElinux is enforcing or perm=
issive. I have another host with the same AMI and VLAN that works flawlessl=
y.
>
> I have reviewed all Splunk, and Firewalld configurations.
>
> The host is not throwing any deny or errors in var/log/audit or /messages=
.
>
> The only time SplunkWeb loads is when SELinux is disabled.
>
> The browser will throw an error when SELinux is enabled.
>
> I suspect this maybe a bug as Splunk and SELinux had a known compatibilit=
y issue almost 20 years ago.
>
> However, those old fixes no longer work.
>
> I appreciate and look forward to everyone's response. Thank you in advanc=
e.

Can you provide the following information from the host in question:
1. semanage port -l | grep 8000
2. sestatus -v
3. Check for any log or audit messages at all (not just avc messages)
around the time of the failure in journalctl -b output (assuming you
trigger the error again after the most recent boot).
