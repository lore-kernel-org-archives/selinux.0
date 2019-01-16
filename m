Return-Path: <SRS0=uPJ/=PY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5666C43387
	for <selinux@archiver.kernel.org>; Wed, 16 Jan 2019 14:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7696220657
	for <selinux@archiver.kernel.org>; Wed, 16 Jan 2019 14:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="oSMZurtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbfAPOqY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:46:24 -0500
Received: from ucol19pa12.eemsg.mail.mil ([214.24.24.85]:51585 "EHLO
        ucol19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbfAPOqX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Jan 2019 09:46:23 -0500
X-EEMSG-check-017: 676935198|UCOL19PA12_EEMSG_MP10.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.56,486,1539648000"; 
   d="scan'208";a="676935198"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by ucol19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Jan 2019 14:45:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547649949; x=1579185949;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=H/CJyKZ5qp8TbOyJXxsKni++aCfWANwEPHoYDmzW1gw=;
  b=oSMZurtEFEDVdICPmbW4TkNmB0xoWCQcOEvDRHtPjafWTSQy1B4qeXX3
   qEaoFt+iqx2xOrjbg2UyfcnwUuDkgDOTjAc6orFPDyYNaEfx29vZFZg9a
   m2M82MiWUTCtpg6p4fRJTop0WnEN8QFgTppn3CdIcdINLeJna4iN6Q4n6
   ZtGydZcVcFckKN5X3cFyuDKWoU8W9auAli1KpYSPPnUZjCGJHC1jKJByv
   xaMoSMLkoSmydccVVS4uxtbUEzvGQ2rLmZLen+pY/DvJvkgZKckyC3VQ0
   V6t8rf4O3EckbCf8JI5h4t7HTwjn35EIC7UHoabXD9eDj+AE5HlQatVPF
   w==;
X-IronPort-AV: E=Sophos;i="5.56,486,1539648000"; 
   d="scan'208";a="19573494"
IronPort-PHdr: =?us-ascii?q?9a23=3A6CreKhPYO6zEPITvvHIl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0I/T8rarrMEGX3/hxlliBBdydt6oUzbKO+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxlLiTanfb9+MAi9oBnMuMURnYZsMLs6xA?=
 =?us-ascii?q?HTontPdeRWxGdoKkyWkh3h+Mq+/4Nt/jpJtf45+MFOTav1f6IjTbxFFzsmKH?=
 =?us-ascii?q?w65NfqtRbYUwSC4GYXX3gMnRpJBwjF6wz6Xov0vyDnuOdxxDWWMMvrRr0vRz?=
 =?us-ascii?q?+s87lkRwPpiCcfNj427mfXitBrjKlGpB6tvgFzz5LIbI2QMvdxcLndfdcHTm?=
 =?us-ascii?q?RfWMhfWTFKDoelY4cRE+YNOOBVpJT/qVQTtxuzHRSiCv3hyjFIhXH406M13O?=
 =?us-ascii?q?sjHg7a0wItBM4OvXbOodnpKKsfX+K4wa/VxjvDdfNW3jL95ZDVfBA9v/6MRb?=
 =?us-ascii?q?JwftTXyUIyCg3Fi0+fqYjhPzyL1uUGrm+W7/F9WuK0kGMntwFwrSSvxscrkI?=
 =?us-ascii?q?XJgJkVxUre+SV2x4Y1O8S1RUhmatCnCJtdrzyWOoR5T884Q2xkpTw2xqMJtJ?=
 =?us-ascii?q?KlZiQG1ZIqzAPFZfOdaYiH+BfjWf6UITd/mX1qZqqyhw238Ui80u38UdS00E?=
 =?us-ascii?q?pSoipFjNbMsncN2gTP6sedUPt9/1qh2S2V2wDP6uBLPUA0la3BJ54n3rEwjY?=
 =?us-ascii?q?YcvV7GHi/3nEX6lK6WdkM69ei08+nrf7rrq5CGO4J0lw3yKLoil8OhDegiLw?=
 =?us-ascii?q?QCR22b9v691L3n8035WrJKjvgun6nCrZ/aPt8WprK5AgBJ0oYj7AyzDzG90N?=
 =?us-ascii?q?sCh3UHI1VFeAyfg4jzJ17OOOz4Deu4g1m0kjdrwPDGPrv7DpXPKXjDkK3ufb?=
 =?us-ascii?q?Bm60FCzgo+1sxQ6IhSCrEGJvLzW1P+u8bcDhMjLwO0xOPnAs1n1owCQWKPHr?=
 =?us-ascii?q?OZMKTKvF+T+O0vJ+iMZIkIuDfyMPUl+fHugmEjmVMHfqmmw4EXaHamEfRiOU?=
 =?us-ascii?q?mZZmDsgtgZG2cQogU+VPDqiEGFUTNLf3a9Rb885jUgBYK+F4jDW4StjKWE3C?=
 =?us-ascii?q?e8GZ1WfH5JBkqQHnfvcoXXE8sLPQCVIskpsDsEXL66RolpgROptAm8yb1nJ+?=
 =?us-ascii?q?zP9yswvpvl09507OTX0xo18GowR9+Q12CLUnFcgGwFXXk10bp5rEg7zU2Mle?=
 =?us-ascii?q?BAiuFcXflU4OlEGlMiPIPY5/RzFtS3XwXGZNrPQ1GjFIaIGzY0G+ktzscObk?=
 =?us-ascii?q?A1INCrihTOzmL+GLMOv6CaD5wztKTH1j7+INgrmCWO77Uok1RzGpgHDmahnK?=
 =?us-ascii?q?MqslGJX4M=3D?=
X-IPAS-Result: =?us-ascii?q?A2DiAABAQj9c/wHyM5BjGwEBAQEDAQEBBwMBAQGBZYFbK?=
 =?us-ascii?q?YFohCiTeUwBAQEBAQEGgQgtiTCJRocDOAGEQAKCUyI4EgEDAQEBAQEBAgFsK?=
 =?us-ascii?q?II6KQGCZwEFIwQRUQsYAgImAgJXBgEMCAEBgl8/gXUNqzR8M4VDhG+BC4s0F?=
 =?us-ascii?q?3iBB4E4gmuBJoZkglcCkEs5kQwJkg0GGJILLYlTkmshgVYrCAIYCCEPgyiCJ?=
 =?us-ascii?q?heOPCEDgTUBAYorAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 16 Jan 2019 14:45:49 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0GEjmv8002340;
        Wed, 16 Jan 2019 09:45:48 -0500
Subject: Re: Bug Report: bug if selinux_msg_queue_msgsnd & and
 selinux_msg_queue_msgrcv
To:     John Johansen <john.johansen@canonical.com>,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
References: <41e46a6c-a42f-a01e-60ce-c1afef70c303@canonical.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <81d7ef24-ddf9-8a54-fa63-0370b4584957@tycho.nsa.gov>
Date:   Wed, 16 Jan 2019 09:47:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <41e46a6c-a42f-a01e-60ce-c1afef70c303@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/16/19 5:14 AM, John Johansen wrote:
> kernel: 5.0-rc2
> 
> d8c6e85432944 ("msg/security: Pass kern_ipc_perm not msg_queue into the msg_queue security hooks")
> 
> appears to have introduced a bug into selinux_msg_queue_msgsnd and selinux_msg_queue_msgrcv
> 
> 
> specifically the portion of the patch that does
> 
> -       isec = msq->q_perm.security;
> +       isec = msq->security;
> 
> which leaves the code
> 	isec = msq->security;
> 	msec = msg->security;
> 
> however isec and msec are different size structures. specifically isec is an ipc_security_struct and msec is a msg_security_struct. Which are defined as
> 
> struct msg_security_struct {
> 	u32 sid;	/* SID of message */
> };
> 
> struct ipc_security_struct {
> 	u16 sclass;	/* security class of this object */
> 	u32 sid;	/* SID of IPC resource */
> };
> 
> where the msg->security field is allocated as an ipc_security_struct. Access the msec->sid would thus appear to overlay the isec->sclass.

The only thing that changed in that commit was directly passing 
&msgq->q_perm to the hook instead of passing msgq to the hook and then 
dereferencing msq->q_perm to reach the ipc security blob.

msg is a different object from msq with its own security blob (msg is an 
individual message; msq is the message queue).  isec and msec point to 
two different security blobs with different structures.

I don't see a problem offhand.
