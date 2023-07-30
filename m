Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A70C001DC
	for <selinux@archiver.kernel.org>; Sun, 30 Jul 2023 20:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjG3UdA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 30 Jul 2023 16:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjG3Uc6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 30 Jul 2023 16:32:58 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FCD113
        for <selinux@vger.kernel.org>; Sun, 30 Jul 2023 13:32:57 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bc57401cb9so808991a34.0
        for <selinux@vger.kernel.org>; Sun, 30 Jul 2023 13:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690749176; x=1691353976;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtHSSHTSpp5yRjGTp1nfl+H3jc4Vu5E/WPsv1chvl+I=;
        b=neyuE6FQ/Xa+l1NofkcW7PZiPoe/mhtnoUgYHne2xJphBDBN0VTECkRJO5IRGTh+Ce
         NqNplTBfPEbdD4pR3402vihrV+FG5HCAVMSeN+6G9yY71HTxbPcXZwmIs4vHLUMOg2yh
         a+yiOabLdQNMPCO91WH+HNJvUK0NX8/8klDIj5xLX2EsknpTciyf3hDr/w50YCHO1Ecj
         A5P9rR8qbVBsj2MKkOVNBFu0MnOiW56ZKciqk86JFR72RaJWVzVVNEDmcO9c2WjpZMHw
         W5GNAAtSmuDBDFGF0XQ7SeqjfnLTlQu126K1Cvd/GJIFMkFkbRKAMkKTf28NTpCv627B
         PsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690749176; x=1691353976;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UtHSSHTSpp5yRjGTp1nfl+H3jc4Vu5E/WPsv1chvl+I=;
        b=W9+Z2nNEqhFGt6y1W23Jt5tbUjEIl++tLXFD0Fp8krETSzvXVDd7MFthrtP0AVJfdj
         e3sFfKvikTABSr6fRJHlWyofyidP0OpQQRwUgqxc23RXeW+qK6aoJe8UPXwwYSpjPaCa
         YRcKEFdK4NN4N4KcRIjTreLbndEcdXARjwluA/yHzCMj1uLWREjKdpEqkt6/bVNEiOmG
         p5meXDvX1FJEDexCq2SkSZlH5hNoHnx2uk70aKGkXeheDE1eNt8xRBaoZm/aLillr6Qk
         vKM0oPa3V0a81lUuCgTGpUYLGQnumbXz16ZS7yYthC+GeGZzSNVzP67MsCzaQN5XyPbR
         2XJw==
X-Gm-Message-State: ABy/qLYI0GKm1qxGRWUVsJP87PQKZWE2RG5LLwK5BiG7jZEmb46edfdn
        VF0zj2/VGlj/DFvikE0w24452MkXohg=
X-Google-Smtp-Source: APBJJlGm4nYImhSOSR9BBNlHTN+LGPZAxuSNkJEA/yo6+GjNtlOjEByggRTTpIRoCksqJRfC/KRLDg==
X-Received: by 2002:a05:6820:2201:b0:560:b01a:653d with SMTP id cj1-20020a056820220100b00560b01a653dmr4376705oob.0.1690749176294;
        Sun, 30 Jul 2023 13:32:56 -0700 (PDT)
Received: from [172.31.250.1] (192-063-109-134.res.spectrum.com. [192.63.109.134])
        by smtp.gmail.com with ESMTPSA id b11-20020a4a98cb000000b00566383daeaasm3735155ooj.32.2023.07.30.13.32.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 13:32:55 -0700 (PDT)
Message-ID: <5d5fdc57-6bf3-ec9a-b71b-b17e259f55d7@gmail.com>
Date:   Sun, 30 Jul 2023 15:32:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     SElinux list <selinux@vger.kernel.org>
From:   Ian Pilcher <arequipeno@gmail.com>
Subject: Network ports - multiple types?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I've been playing with network port types, and I've just discovered that
it appears to be possible to assign more than one type to a network
port (e.g. udp/1900).

# semanage port -a -t fdf_port_t -p udp 1900
ValueError: Port udp/1900 already defined

# semanage port -m -t fdf_port_t -p udp 1900

# semanage port -l | grep 1900
fdf_port_t                     udp      1900, 3483
ssdp_port_t                    tcp      1900
ssdp_port_t                    udp      1900

And, sure enough, my FDF service is now able to bind to udp/1900.

I was not previously aware of this feature, and my internet searches
aren't turning up anything about it.  I'd just like to confirm that this
is expected behavior (as it just seems really weird).  Are there any
caveats to doing this?

-- 
========================================================================
Google                                      Where SkyNet meets Idiocracy
========================================================================
