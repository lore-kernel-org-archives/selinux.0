Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4060CC5519F
	for <selinux@archiver.kernel.org>; Wed, 18 Nov 2020 12:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC63920867
	for <selinux@archiver.kernel.org>; Wed, 18 Nov 2020 12:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="NMUQBi++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgKRMN6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Nov 2020 07:13:58 -0500
Received: from mailomta9-re.btinternet.com ([213.120.69.102]:21157 "EHLO
        re-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727179AbgKRMN5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Nov 2020 07:13:57 -0500
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20201118121354.OCGT31866.re-prd-fep-049.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Wed, 18 Nov 2020 12:13:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1605701634; 
        bh=s0rgbHTKRNFXZlBe+AvEIefg/19rOMLB5l1wehOvo88=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:MIME-Version;
        b=NMUQBi++Cu651UN+ZgSslqKGex5Fw3WzMNxyc3jfncayn5/Ecn5WEf5YcWOX5lL/1VoQUTguvv9dt+HovmD5Xu5glRdnIv9fF601Th2mN/b3VFskfxe+KhSt0ukpNpKIspPHphEzb4QUSURfJrZgKl/7rMymMX09B78fiqg/3QJZWI9hF10MNBqfj9hPj0ckxQoci7NiBn+y5OoilExWiDkjw/4uMxgfzDCsNqM7sBkpDTI4gVhth8/E30fmxrtq7yte2W6ky5EjPdqZZZ5dZSACr5sfMoKMuqNI4rosBDoqH9JBygpAb7Q++Bc3hOWYwiMTLZkDpOG2Uojc4yviQw==
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=richard_c_haines@btinternet.com
X-SNCR-Rigid: 5ED9C74D1AB1DBD7
X-Originating-IP: [213.122.112.104]
X-OWM-Source-IP: 213.122.112.104 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrudefhedgfeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeevtdejtdfgtddvtdejiedthfeftedvteeileefgfejteefgffhkedvlefgveehteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrdduvddvrdduuddvrddutdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduleekngdpihhnvghtpedvudefrdduvddvrdduuddvrddutdegpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeoughhohifvghllhhssehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeolhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhr
        tghpthhtohepoehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeoohhmohhsnhgrtggvsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehsthgvphhhvghnrdhsmhgrlhhlvgihrdifohhrkhesghhmrghilhdrtghomheqpdhrtghpthhtohepoehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from [192.168.1.198] (213.122.112.104) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C74D1AB1DBD7; Wed, 18 Nov 2020 12:13:54 +0000
Message-ID: <94c4635aeda654beffee1dc9fa51f68d8981514d.camel@btinternet.com>
Subject: Re: [PATCH] vfs: fix fsconfig(2) LSM mount option handling for btrfs
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        linux-fsdevel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 18 Nov 2020 12:13:46 +0000
In-Reply-To: <20201118102342.154277-1-omosnace@redhat.com>
References: <20201118102342.154277-1-omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2020-11-18 at 11:23 +0100, Ondrej Mosnacek wrote:
> When SELinux security options are passed to btrfs via fsconfig(2)
> rather
> than via mount(2), the operation aborts with an error. What happens
> is
> roughly this sequence:
> 
> 1. vfs_parse_fs_param() eats away the LSM options and parses them
> into
>    fc->security.
> 2. legacy_get_tree() finds nothing in ctx->legacy_data, passes this
>    nothing to btrfs.
> [here btrfs calls another layer of vfs_kern_mount(), but let's ignore
>  that for simplicity]
> 3. btrfs calls security_sb_set_mnt_opts() with empty options.
> 4. vfs_get_tree() then calls its own security_sb_set_mnt_opts() with
> the
>    options stashed in fc->security.
> 5. SELinux doesn't like that different options were used for the same
>    superblock and returns -EINVAL.
> 
> In the case of mount(2), the options are parsed by
> legacy_parse_monolithic(), which skips the eating away of security
> opts because of the FS_BINARY_MOUNTDATA flag, so they are passed to
> the
> FS via ctx->legacy_data. The second call to
> security_sb_set_mnt_opts()
> (from vfs_get_tree()) now passes empty opts, but the non-empty ->
> empty
> sequence is allowed by SELinux for the FS_BINARY_MOUNTDATA case.
> 
> It is a total mess, but the only sane fix for now seems to be to skip
> processing the security opts in vfs_parse_fs_param() if the fc has
> legacy opts set AND the fs specfies the FS_BINARY_MOUNTDATA flag.
> This
> combination currently matches only btrfs and coda. For btrfs this
> fixes
> the fsconfig(2) behavior, and for coda it makes setting security opts
> via fsconfig(2) fail the same way as it would with mount(2) (because
> FS_BINARY_MOUNTDATA filesystems are expected to call the mount opts
> LSM
> hooks themselves, but coda never cared enough to do that). I believe
> that is an acceptable state until both filesystems (or at least
> btrfs)
> are converted to the new mount API (at which point btrfs won't need
> to
> pretend it takes binary mount data any more and also won't need to
> call
> the LSM hooks itself, assuming it will pass the fc->security
> information
> properly).
> 
> Note that we can't skip LSM opts handling in vfs_parse_fs_param()
> solely
> based on FS_BINARY_MOUNTDATA because that would break NFS.
> 
> See here for the original report and reproducer:
> https://lore.kernel.org/selinux/c02674c970fa292610402aa866c4068772d9ad4e.camel@btinternet.com/
> 
> Reported-by: Richard Haines <richard_c_haines@btinternet.com>
> Fixes: 3e1aeb00e6d1 ("vfs: Implement a filesystem superblock
> creation/configuration context")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  fs/fs_context.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 

Tested-by: Richard Haines <richard_c_haines@btinternet.com>

Ran the selinux-testsuite with the 'Add btrfs support for filesystem
tests' patch [1] installed, plus the NFS './tools/nfs.sh' tests. All
passed okay.

[1]
https://lore.kernel.org/selinux/20201103110121.53919-1-richard_c_haines@btinternet.com/


> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index 2834d1afa6e80..cfc5ee2e381ef 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -106,12 +106,28 @@ int vfs_parse_fs_param(struct fs_context *fc,
> struct fs_parameter *param)
>         if (ret != -ENOPARAM)
>                 return ret;
>  
> -       ret = security_fs_context_parse_param(fc, param);
> -       if (ret != -ENOPARAM)
> -               /* Param belongs to the LSM or is disallowed by the
> LSM; so
> -                * don't pass to the FS.
> -                */
> -               return ret;
> +       /*
> +        * In the legacy+binary mode, skip the
> security_fs_context_parse_param()
> +        * call and let the legacy handler process also the security
> options.
> +        * It will format them into the monolithic string, where the
> FS can
> +        * process them (with FS_BINARY_MOUNTDATA it is expected to
> do it).
> +        *
> +        * Currently, this matches only btrfs and coda. Coda is
> broken with
> +        * fsconfig(2) anyway, because it does actually take binary
> data. Btrfs
> +        * only *pretends* to take binary data to work around the
> SELinux's
> +        * no-remount-with-different-options check, so this allows it
> to work
> +        * with fsconfig(2) properly.
> +        *
> +        * Once btrfs is ported to the new mount API, this hack can
> be reverted.
> +        */
> +       if (fc->ops != &legacy_fs_context_ops || !(fc->fs_type-
> >fs_flags & FS_BINARY_MOUNTDATA)) {
> +               ret = security_fs_context_parse_param(fc, param);
> +               if (ret != -ENOPARAM)
> +                       /* Param belongs to the LSM or is disallowed
> by the LSM;
> +                        * so don't pass to the FS.
> +                        */
> +                       return ret;
> +       }
>  
>         if (fc->ops->parse_param) {
>                 ret = fc->ops->parse_param(fc, param);


