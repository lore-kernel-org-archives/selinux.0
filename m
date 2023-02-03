Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B106C61DA4
	for <selinux@archiver.kernel.org>; Fri,  3 Feb 2023 22:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjBCWyI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Feb 2023 17:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjBCWyH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Feb 2023 17:54:07 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2D191EBCC
        for <selinux@vger.kernel.org>; Fri,  3 Feb 2023 14:54:05 -0800 (PST)
Received: from [192.168.1.10] (pool-96-241-71-43.washdc.fios.verizon.net [96.241.71.43])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1986B20C7DCC;
        Fri,  3 Feb 2023 14:54:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1986B20C7DCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675464845;
        bh=pEb/oPChLLjWdjOs1x1CsB96X0sbXZAOgMG5z1n15us=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=Q8zNbOk5YIyv/qXi6PJnVOLnPHbeBS+jezS/TQKEnAQw4kZivknJVyVAv5Iovdn9x
         fGaArtQ+WFtCFH1yFO5szL+8xesAq2Jn+9tDxjlowF1kr+f2u4K9kTsQrgthd4QmDc
         zvawM2cW+w7pX2ItiK8G+tqYlP2ATXx7tRWvQzcs=
Message-ID: <38c131c4-1cd5-b42a-9a30-5aa89646493c@linux.microsoft.com>
Date:   Fri, 3 Feb 2023 17:54:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Daniel Burgener <dburgener@linux.microsoft.com>
Subject: Re: [RFC PATCH 3/9] libsepol/cil: Add cil_tree_remove_node function
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
References: <20221215213429.998948-1-jwcart2@gmail.com>
 <20221215213429.998948-4-jwcart2@gmail.com>
Content-Language: en-US
In-Reply-To: <20221215213429.998948-4-jwcart2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/15/2022 4:34 PM, James Carter wrote:
> Add the function cil_tree_remove_node() which takes a node pointer
> as an input, finds the parent, walks the list of nodes to the node
> prior to the given node, and then updates that nodes next pointer
> to remove the given node from the tree.
> 
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>   libsepol/cil/src/cil_tree.c | 27 +++++++++++++++++++++++++++
>   libsepol/cil/src/cil_tree.h |  1 +
>   2 files changed, 28 insertions(+)
> 
> diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
> index 6376c208..73b4e135 100644
> --- a/libsepol/cil/src/cil_tree.c
> +++ b/libsepol/cil/src/cil_tree.c
> @@ -248,6 +248,33 @@ void cil_tree_node_destroy(struct cil_tree_node **node)
>   	*node = NULL;
>   }
>   
> +void cil_tree_remove_node(struct cil_tree_node *node)
> +{
> +	struct cil_tree_node *parent, *curr;
> +
> +	if (node == NULL || node->parent == NULL) {
> +		return;
> +	}
> +
> +	parent = node->parent;
> +
> +	if (parent->cl_head == node) {
> +		parent->cl_head = node->next;
> +		return;
> +	}
> +
> +	curr = parent->cl_head;
> +	while (curr && curr->next != node) {
> +		curr = curr->next;
> +	}
> +
> +	if (curr == NULL) {
> +		return;
> +	}
> +
> +	curr->next = node->next;
> +}
> +

Is there a reason this leaves it to the caller to call 
cil_tree_node_destroy()?  It just feels a little weird to leave the node 
unreachable without freeing.  It looks like both callers in the series 
(cil_process_deny_rule(s)) call cil_tree_node_destroy() immediately after.

-Daniel

>   /* Perform depth-first walk of the tree
>      Parameters:
>      start_node:          root node to start walking from
> diff --git a/libsepol/cil/src/cil_tree.h b/libsepol/cil/src/cil_tree.h
> index 5a98da55..e4b3fd04 100644
> --- a/libsepol/cil/src/cil_tree.h
> +++ b/libsepol/cil/src/cil_tree.h
> @@ -63,6 +63,7 @@ void cil_tree_children_destroy(struct cil_tree_node *node);
>   
>   void cil_tree_node_init(struct cil_tree_node **node);
>   void cil_tree_node_destroy(struct cil_tree_node **node);
> +void cil_tree_remove_node(struct cil_tree_node *node);
>   
>   //finished values
>   #define CIL_TREE_SKIP_NOTHING	0

