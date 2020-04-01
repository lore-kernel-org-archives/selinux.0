Return-Path: <SRS0=rNkQ=5R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABDFC43331
	for <selinux@archiver.kernel.org>; Wed,  1 Apr 2020 15:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0339F20776
	for <selinux@archiver.kernel.org>; Wed,  1 Apr 2020 15:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="QvOin/S9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbgDAP1l (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:27:41 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:39556 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732504AbgDAP1l (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Apr 2020 11:27:41 -0400
Received: by mail-qt1-f175.google.com with SMTP id f20so312253qtq.6
        for <selinux@vger.kernel.org>; Wed, 01 Apr 2020 08:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ScfrebZedeJs9OCztOHm0rCDLieR+99/eUMWPNw0f+A=;
        b=QvOin/S9OzXh06cFygSlXL6C3V9HklPGxo8OgpFLWiwem8wBo6eyKYk836UoqbHOTK
         bJhPi6uzfNe9ndVuiyxd60RzgGNWxl9/emZb1VtzhpnfVXmZ9m+ALMvpeB2tG4ObC4Bi
         UcnjTvJoVIEGQxjUBhHdoowzOSs5EEfBf9b6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ScfrebZedeJs9OCztOHm0rCDLieR+99/eUMWPNw0f+A=;
        b=U2OokRX1EuqJlatYZZwugpAEroMCg4JHiN1wsjAxtQaW8vw6ph5QkHw61dGzrAJ9Zh
         73YB3t0RQ7RLBqOukJDuCwpULojvua2wu4ZJtDR4X9497ZRVxBLx3iw0GPCzpNwulIjf
         LjbIeaO+Qqe8yOa21umo7U6Qgi+HKhy6O6mACmw2V8LTG61+R99ixk4BCzvEpBmQ4vce
         diiiEmIbVR8i5pdBxh++lR4OMbfl2ADmUvH1mBFubr439GfsMjEBgwSty8VJiT+Ttw4Q
         HZDedm5reaNrx7zTwRtYfnQLULslS+Oai6ivWYh45iMwMlNgKgS0RvIhC8Po6glAWe3I
         VIgQ==
X-Gm-Message-State: ANhLgQ3aTQlmaB1/4STvW5RSAwEWxWL2Zaw3WVVExZ35GlUAAeLXkI+Y
        bGdpl2NhIAnTAr7Osjt69Vhyng6xpxc=
X-Google-Smtp-Source: ADFU+vvSqdwydNIcg0pVAz2BOseS/hsJHFUYDsy/Yg7n1UurcAU25P9vyqPhq63elsvljjh2m7K8ng==
X-Received: by 2002:ac8:3feb:: with SMTP id v40mr10671654qtk.147.1585754858637;
        Wed, 01 Apr 2020 08:27:38 -0700 (PDT)
Received: from fedora.pebenito.net (pool-108-15-23-247.bltmmd.fios.verizon.net. [108.15.23.247])
        by smtp.gmail.com with ESMTPSA id o16sm1560205qki.110.2020.04.01.08.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 08:27:38 -0700 (PDT)
To:     SElinux list <selinux@vger.kernel.org>,
        refpolicy <selinux-refpolicy@vger.kernel.org>
From:   Chris PeBenito <pebenito@ieee.org>
Subject: ANN: SETools 4.3.0
Message-ID: <70175949-68b6-65da-f1a3-dc514ecf2fe1@ieee.org>
Date:   Wed, 1 Apr 2020 11:27:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

SETools 4.3.0 is now available:

https://github.com/SELinuxProject/setools/releases/tag/4.3.0

Changes since 4.2.2:

   * Revised sediff method for TE rules. This drastically reduced memory
     and run time.
   * Added infiniband context support to seinfo, sediff, and apol.
   * Added apol configuration for location of Qt assistant.
   * Fixed sediff issue where properties header would display when not
     requested.
   * Fixed sediff issue with type_transition file name comparison.
   * Fixed permission map socket sendto information flow direction.
   * Added methods to TypeAttribute class to make it a complete Python
     collection.
   * Genfscon now will look up classes rather than using fixed values
     which were dropped from libsepol.

-- 
Chris PeBenito
