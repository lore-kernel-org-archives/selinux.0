Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D629EC001B0
	for <selinux@archiver.kernel.org>; Wed, 19 Jul 2023 18:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjGSSm1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jul 2023 14:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjGSSmX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jul 2023 14:42:23 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B289B2110
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 11:42:18 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-55ae2075990so4227708a12.0
        for <selinux@vger.kernel.org>; Wed, 19 Jul 2023 11:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bzdzb-com.20221208.gappssmtp.com; s=20221208; t=1689792137; x=1690396937;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=24YQEIIx5ckDO5hbBboZHh9qW28N5LZjTda2642ZzwU=;
        b=umuD1kBhJh6oDGSWTBmGU0PQvPr+g6lMXix3gG4aT6VOgY0qPdG+KQIlHH/ObOXEvY
         p/wKGcQdiwNlGvO7oiTGBDDI30CiBu5+nrtXG96uIrp9nIjSS+moaEcqttKX/qRUVNnN
         TYHWVVolyt7DCh8aX8lnuo77fyoQN3NiMzOGcMALd9QhneGHZ1/GYXQhPeu4JwUKxBl2
         jAwhnA/Y7+4DAGcHmHbOadpWQ9OzUobTWR0A795u/zD7hJJsd+O9imImzFg9DeGuzj3m
         WSqo8AK5cBqdRvvE749IdtFLq9ChpeBCJ3oOUh83axNZoY3X0nPIVg6HogIM2rvtJaSs
         Kezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689792137; x=1690396937;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=24YQEIIx5ckDO5hbBboZHh9qW28N5LZjTda2642ZzwU=;
        b=P9qMRK5m5Lp4lBxJ/X4gtP2AwSoAR48Mpy923itwXF1k5R9eyhuYoM8exDkYZPylMD
         x28Q3HH9eLf5q1c9hNozER0zaPqOEtiddYcAn9mwSC8DC6FzxRaLEZSSKMYMC9elMpe7
         iEh7064ST1b8lCpivBLIdwSnBSu+DhZSHkviotfirbJirwgdX6WRRSDlIDE3yAKBFIWk
         1OB9sBlo4J+IMjHx+57txOtsp5QskWe427XzZuS/aLv9lLkO7bNEGm7Q+ac0K3Zgsi9v
         yJHynbSIYg9WiT7Ol+CNnhJ8vJkjBZfRJapDHiXorp6iZ8CBA5eYqPdd35DgQLpG72Yt
         7QgQ==
X-Gm-Message-State: ABy/qLbdd/Ft6pSgetB27d7hpk/o2IF9Iy6bCwGJaSqs+nBPuNJ5KICY
        BMaYPa46Nu9xFpuNmC9l3JwQDCWMIxPWuQGWgBlwxLkWX4M3pAYpNLUTNw==
X-Google-Smtp-Source: APBJJlGUAG1Q9kYZsEYn6zrixfX/3YFxIlodZJ9n09LdnJ5w7LvFkDaY9SGYA6sqnUEaDNfwCzbwuQnLFQjlraKWI74=
X-Received: by 2002:a17:90b:4017:b0:262:ecd9:ed09 with SMTP id
 ie23-20020a17090b401700b00262ecd9ed09mr15071236pjb.33.1689792137148; Wed, 19
 Jul 2023 11:42:17 -0700 (PDT)
MIME-Version: 1.0
From:   Brett Anderson <brett@bzdzb.com>
Date:   Wed, 19 Jul 2023 14:42:01 -0400
Message-ID: <CAPQCZivM+qGve5eUekri3_iEzAPE5o3ymqOunYMjQJ=4mRwPUg@mail.gmail.com>
Subject: SELinux Mascot/Logo
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello!

I made an SELinux logo for my own purposes and figured I would share
it with you in case you would like to use it. I'm putting this into
the public domain and you can do with it as you see fit; attribution
would be cool, but not required.

https://imgur.com/a/khkSEux.png

Cheers!
