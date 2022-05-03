Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733D0C433F5
	for <selinux@archiver.kernel.org>; Tue,  3 May 2022 20:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiECUHi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 May 2022 16:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiECUHe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 May 2022 16:07:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB18403C6;
        Tue,  3 May 2022 13:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=QwbxKW/u1C+Gw4rhvaiXK5OBQkHPMzPp/1lAC0EgVgY=; b=hXj3RdTJQJZS0m9a+3dmdiPVYD
        9AKTxlTpaHHH1tc1UZSwB9gfZPqmaH0wTyJiwX+X6NaqIsC+O79vyuLbKIcmbsH27MRBPvYT5Y1nF
        Gl6bSq+z3ErnocVhEJByW/YhiHi0FsUfD3d9ila4PNOUDiyefh778CeGp5qpDEbcgH9dPlCfyLW8Q
        a1XWRMdD6YT00hXthG7QDbIVZXp3Yu1r/ZudW5qHaKwjC9xN4lvFEB/n8na/BAslEfYfS53d+JWaz
        9XRD/fKaHQcuvfyUAI0UEwwefl+Gr0WzgBNLXKmA7zKmsbFqZIrKfIuTVqOmjCcriK/BDYjleZbPk
        eKnzBIQg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlykU-007U4h-AT; Tue, 03 May 2022 20:03:54 +0000
Date:   Tue, 3 May 2022 13:03:54 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     =?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        John Stultz <jstultz@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] firmware_loader: use kernel credentials when reading
 firmware
Message-ID: <YnGKqjE+KydNnWRw@bombadil.infradead.org>
References: <20220502004952.3970800-1-tweek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220502004952.3970800-1-tweek@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 02, 2022 at 10:49:52AM +1000, Thiébaud Weksteen wrote:
> Device drivers may decide to not load firmware when probed to avoid
> slowing down the boot process should the firmware filesystem not be
> available yet. In this case, the firmware loading request may be done
> when a device file associated with the driver is first accessed. The
> credentials of the userspace process accessing the device file may be
> used to validate access to the firmware files requested by the driver.
> Ensure that the kernel assumes the responsibility of reading the
> firmware.
> 
> This was observed on Android for a graphic driver loading their firmware
> when the device file (e.g. /dev/mali0) was first opened by userspace
> (i.e. surfaceflinger). The security context of surfaceflinger was used
> to validate the access to the firmware file (e.g.
> /vendor/firmware/mali.bin).
> 
> Previously, Android configurations were not setting up the
> firmware_class.path command line argument and were relying on the
> userspace fallback mechanism. In this case, the security context of the
> userspace daemon (i.e. ueventd) was consistently used to read firmware
> files. More Android devices are now found to set firmware_class.path
> which gives the kernel the opportunity to read the firmware directly
> (via kernel_read_file_from_path_initns). In this scenario, the current
> process credentials were used, even if unrelated to the loading of the
> firmware file.
> 
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> Cc: <stable@vger.kernel.org> # 5.10

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
