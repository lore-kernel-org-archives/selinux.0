Return-Path: <SRS0=OcM+=VG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3272C73C46
	for <selinux@archiver.kernel.org>; Tue,  9 Jul 2019 16:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E63B205ED
	for <selinux@archiver.kernel.org>; Tue,  9 Jul 2019 16:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="K950Vt9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfGIQd5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Jul 2019 12:33:57 -0400
Received: from sonic310-22.consmr.mail.bf2.yahoo.com ([74.6.135.196]:42338
        "EHLO sonic310-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726318AbfGIQd5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Jul 2019 12:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562690035; bh=450XATkvD/Vqevc8O/AWiOpwscos3xewaorD9OcX+RU=; h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject; b=K950Vt9kNK+0webohErxUoNFu7CaHL6fJ79AJFqqixIAnutrIXFyWm/tvOWW4M8z/TUFFYpe0ktmcgpiqJjF0LvKdM6bpE/yUaFSJcJaizyUBjiTpPiww9X4NHZ2l5lyWr+dVVNTZS/F28VbJQsaV9Px0yTiTEsEcKSgOCjDcIPk0ee1QAUim//MMnPv3EUjalTLQZuf/2fgQuFlYXRoNT/17qVmaXhh7nsnf+BM7VK4P6tGZcpB7MwqASvZWgexbhAVIYXZbD1wgOEJNaShrLS+VPCATrFnccj4E9E6vjpJjCMCdF38RecVd+Lsi3UXobD4jvEVEcQErmSyS8+5xQ==
X-YMail-OSG: Ahk8kYgVM1lIs6d92dKsjLbNnXIaCR3SgeI6AScqQLUmsWttQI6ooDywFO.bDdN
 FwLQ5baGu8WYfqdB9_f7em6fNSobv76ScVh9oiBwZSntKnvcLg6CrXN76wWFxUDPOsldoKY9MLDu
 2SAoImtOIkRSxcRvqi5KYQYuQFYvWGoJnOn0KsKY2UHI2dwQxUI4Pj1MWzOBF6ZaDiQIbUNcmAfI
 qGa0XFKxxH3AmcpXqJkIqwXNw4NGFC.XwXuybTmrZKqTKeQsLWLCG_G5zFpvzQK0IvZMqYIeTgFh
 ncQKkZ.d1TeaIPAEgiEv3r5OyAx7HvLLnFDCLv2wrrvKy88dr4fCG9SD.1zkV4EuR69pK.Te.7S3
 lYuybgt3LDdlBqrengc6D_rryU7MwZb00Miz4wsNxgNbQJSy6pXWThY0weaFYI4FgLgBjnDnyMXX
 o8JROYgFgBbjk.S_6D_hMiYudqhj4vyNli07J2NIgGn0XwBXelU6z181.GAbVmiiqzmtBqYnXFFC
 0rW7gHxKaFhusl7GOQzrzvWAw9Ey4M.7KhUu1.1UowmJTKi9T1QquT18N_ZKpHIJC94GkqC_HUnH
 LGIzazxDZL9bIVUzY2n6Fc8_5tOPsET.7lihFKGz0dlpveFO1CEZXK8oeaPXV7UjldgH7xn1lWgj
 s2DRmByJZHnXmdCGmgYyaH8ggg8ywjq.HqlmvBm2a99bg2IKZAMWPB.M1pifJd9qgrA5J3SARZG9
 T6Gt003c0hANSyGVmb_nTIK3NMjSUbog4JR2zIVnedB__LPSpLJ3LhRARlaxqhfnO0nbyDtBaaJU
 EkCc2xCClCLjBNRbdp8IISTQLBdUNCRulQiu3U0PzfDl1BMVNZtLevs3KMiilplvhogNCQQxc9Ah
 VKtMDZy0GE7R5S4K4TBSsuuD80W_KSED5Us9jjUTGCyT7nFrISHCVzTPVEGKMMnOL0UV6e_4RDe2
 aG2u_KwJGnQXCWjhx6eh212tCjBcyEnN6Ot0eCdhlXV9wAdYE23G.guKMr5zrzsxFMy5Ey6s1A6h
 C3E1s9Q.Gz9.bd1ktck7svRJh6HnbpyhXpde4fcy8KNI9jYt69gjHH.gbAEh8JF8rHufOXtqIok1
 OvaXj8oqzTOHP8Mr5zegRUyIv7SU40NbhUd8SuZyVL9886QnU.jIJCsuqCvfDJrPsIW0bNP6B73t
 VWlTw8HdLkx11CoaWNHQvNzCXDNmu1ndtLslS5bPM9bUEid1TXWeXsNmN6CxnIJ3BXnQ..T9dpPl
 LWt5QW6exoOcfwM4pFxs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Tue, 9 Jul 2019 16:33:55 +0000
Received: by smtp418.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID df006fca287792004bba6df3e350b334;
          Tue, 09 Jul 2019 16:33:54 +0000 (UTC)
Subject: Re: RFC: BUG: overlayfs getxattr recursion leaves a poison sid.
To:     Mark Salyzyn <salyzyn@android.com>, linux-kernel@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Miklos Szeredi <miklos@szeredi.hu>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        kernel-team@android.com,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
References: <b5c3bc4a-eb39-d994-7723-947a464383a2@android.com>
Cc:     casey@schaufler-ca.com
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <7b6eb68e-44ae-5df8-9ebd-d334fc134938@schaufler-ca.com>
Date:   Tue, 9 Jul 2019 09:33:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b5c3bc4a-eb39-d994-7723-947a464383a2@android.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/9/2019 9:23 AM, Mark Salyzyn wrote:
> For EACCES return for getxattr, sid appears to be expected updated in parent node. For some accesses purely cosmetic for correct avc logging, and depending on kernel vintage for others (older than 4.4) the lack of the corrected sid in the parent overlay inode poisons the security cache and results in false denials.
>
> The avc denials would contain an (incorrect) unlabelled target references, we could fix this by copying up the sid to the parent inode. However the test (below) needs to refactored to the pleasure of the security, selinux and overlayfs maintainers. The security_socket_accept function is _close_, it will copy sid and class from the old socket to the new. Along those lines, we probably need to add a new security_copy_to_upper handler that takes the upper and lower dentries and ensures that the upper contains all the security information associated with the lower.

Please include the LSM (CCed) list on all LSM impacting discussions.
Your mailer mangled the patch. Please resend in plain text.

Thank you.

>
> Prototype adjustment (tested in 3.18 to ToT)
>
> int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name, { ssize_t res; const struct cred *old_cred; struct dentry *realdentry = ovl_i_dentry_upper(inode) ?: ovl_dentry_lower(dentry); old_cred = ovl_override_creds(dentry->d_sb); res = vfs_getxattr(realdentry, name, value, size); ovl_revert_creds(old_cred); + if (res == -EACCES) { + selinux_copy_sid(dentry, realdentry); return res; }
>
> . . .
>
> + void selinux_copy_sid(struct dentry *parent, struct dentry *child) + { + struct inode *pinode, *cinode; + struct inode_security_struct *pisec, *cisec; + + if (!parent || !child) + return; + pinode = parent->d_inode; + cinode = child->d_inode; + if (!pinode || !cinode) + return; + pisec = pinode->i_security; + cisec = cinode->i_security; + if (!pisec || !cisec) + return; + pisec->sid = cisec->sid; + } + EXPORT_SYMBOL_GPL(selinux_copy_sid);
>
> Sincerely -- Mark Salyzyn
>
>
