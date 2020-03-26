Return-Path: <SRS0=8enA=5L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690EEC43331
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 16:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301232083E
	for <selinux@archiver.kernel.org>; Thu, 26 Mar 2020 16:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKAP5Mxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgCZQVz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:21:55 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:36923 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZQVz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Mar 2020 12:21:55 -0400
Received: by mail-io1-f49.google.com with SMTP id q9so6680125iod.4
        for <selinux@vger.kernel.org>; Thu, 26 Mar 2020 09:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GgKBSEKRqGfqtCUVohtV67s5NSzEDBBx1swh8AzMhgY=;
        b=XKAP5MxjgkqULODzuwlLFWO5rreFn1RA1RlFq8SQ3FcnhdpX6lFRtKU7oMFtGKI2jS
         KwUKWVpeOuGzLyLU+qzVdqMAPXbWweUXu4b8uytOjJ5QD8db1bzhMaJikhnx15sg0pIj
         2bbJXUc45G3EcAoi/3SVUX4Q/LDnbRMM5GTrMnS+k8Idpf/Gu8dXyKsTBuGltp/saZlo
         /RvAjY3/93zyXkq5LFFwTYAqLxFgddmL6IWzp3V/ry8HT5ptWICq9kK611TPz7+2W++6
         8nHvBy1FDIGMWw9YnIVAAoBLSYNP7QpNvon3vjrY7QhkoLTu2i6Ap/WvjoSMSqpUTd+F
         FLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GgKBSEKRqGfqtCUVohtV67s5NSzEDBBx1swh8AzMhgY=;
        b=uMzwNAUy/R3XvGJeowZKMTpI5rmoUykOCwk0I7zLgDefMQAXdgZx9kBTO3zkKIBK2U
         SCJamCUsn3SalMzkP2miflkYMZBPFHkHcqbIYD1uWgq6QiJDsH6LaYwIRSxABBvoe0LO
         Recp7/vA8OWMTb4FXYqu9Tu6wcExQnwbY1CJA6cRDkvo6wlEcK56WkqLx7esdnrFGGaY
         tKg/rXWfjrP8B/IHifKxA7ZQGo5gcjiPwyaRrskOGJg6LMjW++8+TPDKSaM8VDOpZcMH
         XNPlWwLVw68VYGDwxvcwNLc6E08XqNt6QFUmCUwpjyr/AsD4CyuViXMxupd85wIuDjCp
         QXxw==
X-Gm-Message-State: ANhLgQ2XQpThoigCP1lIZTgk/iJVRxzB62c7R8Y0um3kuRg/hAwQ6+nG
        U6zrtBz0N6UZlA6IwGN3+0MXX9wrnKt9QE2ZCAYPFQ/z0l0=
X-Google-Smtp-Source: ADFU+vvHWd05caDG+f9JyusjWHe58TZqKCmjYDyErBuWp9Bve03blWdX1XqeJrtH3nFTWYQHP5OKvrI455Ssi8WGgaA=
X-Received: by 2002:a02:bb11:: with SMTP id y17mr8886190jan.130.1585239713219;
 Thu, 26 Mar 2020 09:21:53 -0700 (PDT)
MIME-Version: 1.0
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 26 Mar 2020 11:21:42 -0500
Message-ID: <CAFftDdr=2ji0=dG2Jc2A=rTcu215ETkeEkBxnp3UMeXzp=VRkA@mail.gmail.com>
Subject: PR 193 sitting for uClibC fix
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This PR:
https://github.com/SELinuxProject/selinux/pull/193

Has been sitting forever. I looked through the mailing list and didn't
see any patches hit the list,
we should either close it, or merge it.

Thoughts? If we need it to hit the list, can I grab it and sign-off on
it and post it?

Bill
