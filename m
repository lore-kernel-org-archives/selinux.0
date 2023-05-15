Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEF6C77B7D
	for <selinux@archiver.kernel.org>; Mon, 15 May 2023 07:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbjEOH63 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 May 2023 03:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239355AbjEOH4f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 May 2023 03:56:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E87E5E;
        Mon, 15 May 2023 00:55:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B02776136A;
        Mon, 15 May 2023 07:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4D3C433D2;
        Mon, 15 May 2023 07:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684137305;
        bh=GGdXABU/W294z2dz02XJk9M2U2KkDKc5eHvI9rMuB34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IicAj9RdI3pzCJbc+9esIPILMu3vFaLdLbJ3i4KInRUfgshHs1466v4vgWYlmxQ1e
         DZu2ksv86KSQAOtGc7wUsjeZUd7ktER7/alCxD49YRLFIyNA2UWoxFru+KrgZQuayG
         MZGqQFUC9ku81RPTauWqA2iZpvwd5DvvuTEEvDCsyxfBBFVq7TlWDJ2Hkdc7qw3tJG
         W/yd6nbF9CLO9Df9i5lw1plJuRqQynvNJI7K3+yZ67vDo0O4NX22MXbAQGbR7hQOo4
         lF0DYoVPDuGH+R6e2SVtr91laXvyZKBYUs5fGdaM4xln7vy5bUZLwnMOrrOC+pSlhr
         lAaDMBNuD02mw==
Date:   Mon, 15 May 2023 09:54:53 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 7/9] kernel: use new capable_any functionality
Message-ID: <20230515-anhalten-begleichen-b85fa6b38195@brauner>
References: <20230511142535.732324-1-cgzones@googlemail.com>
 <20230511142535.732324-7-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511142535.732324-7-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 11, 2023 at 04:25:30PM +0200, Christian Göttsche wrote:
> Use the new added capable_any function in appropriate cases, where a
> task is required to have any of two capabilities.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
