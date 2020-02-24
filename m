Return-Path: <SRS0=m/sx=4M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86364C38BE2
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 21:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE8C20CC7
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 21:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flj/47c9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgBXVPi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:15:38 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45336 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgBXVPi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Feb 2020 16:15:38 -0500
Received: by mail-ot1-f66.google.com with SMTP id 59so10061650otp.12
        for <selinux@vger.kernel.org>; Mon, 24 Feb 2020 13:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sm8kBQV/wJZZmCYf+YgQreubjknebdXXIDOO65h5FlQ=;
        b=flj/47c9eVwUFvDdQ21ldMh7sA4NU3fcfycx8NUs5xBL7hYHn3JgD4O4Zlc6i26QwH
         le9SoSFehKH+uf1sy5EoTHSpJbtQ8qd5tVuOgEpsUGBvOizrmkGu6Es3adHCf9wvqD39
         dutlfsta2WmP4PLqxuXS8JdXWn2XBgGtsKwW0iCAbSRMDSyFeaHIV6R0+wLQy1kDu9xr
         GrkvcoI3z8yOrUEb6r4OlGCsw9a7IhoWHaVtacXMnCblnWB+GIBaH4uft61lr2Bx1x6w
         Rk8QRqF1DeT5wGqZWKbziQ1YzI96K/1cbClgYlFJCFs0+SIuInTbzSkTiAch3rJj2ADZ
         RvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sm8kBQV/wJZZmCYf+YgQreubjknebdXXIDOO65h5FlQ=;
        b=EoBAJVgP99CO1qPsDBU1QQyOPlLat0TTGu9Q7HmR4mpwB3JfiTMRdaL69x8EutV6UH
         YRbVW3UPoipwi9xb1Z2HenEmgUOTlX4RlbKIZZpgKeucCiyOgtIldQh0z8JYuVYb/WSU
         L1H9q+leyBHcl+fN9wO/0jxmrVENGimwkq99XGxggnQjgg9G/wAGfu0VTdr92Im4On12
         Q+NOtONDLG5NC5wEulJwB09wbG/ss7YmmVa1Q3JIvJOJAplU4XVbC/BNGM2JWcTGi7A1
         35SZdYPQHFfGt+VAl7Bz+dn+pmtEuOdWCEPFhGMSDbZDv5j76gtyWUsYuk2XAs3objH5
         FnZw==
X-Gm-Message-State: APjAAAXVm3wWXLeyJEJMexH2bsa1oZpsCDVv3oM9X0qHuKfJ4sJuifOR
        piOsMA/hqtopHstOx+ECWABJxdo2mlS0eMVo2LWjIg==
X-Google-Smtp-Source: APXvYqwPfTfNdffIS9eObd/0phyAtk5HNVn6I5pHAs2knynx+/3DbFU+IEF7vaPI9xCko4MoY5wpcs2la1XHKAXbyhg=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr42613733otl.162.1582578937651;
 Mon, 24 Feb 2020 13:15:37 -0800 (PST)
MIME-Version: 1.0
References: <20200224141524.407114-1-richard_c_haines@btinternet.com> <20200224141524.407114-2-richard_c_haines@btinternet.com>
In-Reply-To: <20200224141524.407114-2-richard_c_haines@btinternet.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 24 Feb 2020 16:17:01 -0500
Message-ID: <CAEjxPJ7HXQGdWX5KHs42OEGVR9doSD_FpUAH0TR+U96DPu4ukQ@mail.gmail.com>
Subject: Re: [RFC V2 PATCH 1/2] selinux-testsuite: Use native filesystem for
 tests - Part 1
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, sds@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 24, 2020 at 9:16 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Use the filesystem type that the selinux-testsuite is running from to be
> used for tests/filesystem. Tested types: ext4, xfs, vfat and nfs.
>
> If testing locally -f <fs_type> can be used to test a specific type.
>
> For NFS the following example shows how this should be run:
>     ./tools/nfs.sh filesystem -v -e -f ext4

That example doesn't make much sense to me. If I'm running
./tools/nfs.sh I want to exercise (labeled) nfs, not ext4.

>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---

> diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
> index 09f9d4a..c7d6fc1 100644
> --- a/policy/test_filesystem.te
> +++ b/policy/test_filesystem.te
> @@ -6,6 +6,28 @@
<snip>
> +# Lots of searches required, however this covers up the unlabeled_t NFS bug
> +#files_search_all(filesystemdomain)
> +
> +#
> +########## NFS BUG 'unlabeled_t rules' NFS BUG ########################
> +# Ref: https://bugzilla.redhat.com/show_bug.cgi?id=1625955
> +# These rules can be commented out to cause the NFS bug when using:
> +#     mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
> +# And:
> +#     mount -t nfs -o vers=4.2,fscontext=system_u:object_r:test_filesystem_file_t:s0
> +#           localhost:$TESTDIR /mnt/selinux-testsuite
> +#
> +allow test_filesystem_no_getattr_t unlabeled_t:dir { search };
> +allow test_filesystem_no_mount_t unlabeled_t:dir { search };
> +allow test_filesystem_no_remount_t unlabeled_t:dir { search };
> +allow test_filesystem_no_unmount_t unlabeled_t:dir { search };
> +allow test_move_mount_no_mounton_t unlabeled_t:dir { search };
> +######################## End NFS bug ####################

Don't cover up bugs in the testsuite policy or code.  If it is a bug,
let it fail.

> diff --git a/policy/test_filesystem_notify.te b/policy/test_filesystem_notify.te
> index 3e8a246..c9ef73a 100644
> --- a/policy/test_filesystem_notify.te
> +++ b/policy/test_filesystem_notify.te
> @@ -2,15 +2,55 @@
> +#
> +########## NFS BUG 'unlabeled_t rules' NFS BUG ########################
> +# Ref: https://bugzilla.redhat.com/show_bug.cgi?id=1625955
> +# These rules can be commented out to cause the NFS bug when using:
> +#     mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
> +# And:
> +#     mount -t nfs -o vers=4.2,fscontext=system_u:object_r:test_filesystem_file_t:s0
> +#           localhost:$TESTDIR /mnt/selinux-testsuite
> +#
> +allow test_filesystem_no_watch_mount_t unlabeled_t:dir { search };
> +allow test_filesystem_no_watch_sb_t unlabeled_t:dir { search };
> +allow test_filesystem_no_watch_t unlabeled_t:dir { search };
> +######################## End NFS bug ####################

ditto

> diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesystem.pm
> index a08570a..8a18ddb 100644
> --- a/tests/filesystem/Filesystem.pm
> +++ b/tests/filesystem/Filesystem.pm
> @@ -1,10 +1,10 @@
> @@ -25,15 +25,26 @@ sub check_config {
>      $mod_pol_vers      = `checkmodule -V | cut -f 2 -d '-'`;
>      $max_kernel_policy = `cat /sys/fs/selinux/policyvers`;
>
> -    if ( $mod_pol_vers >= 11 and $pol_vers >= 25 and $max_kernel_policy >= 25 )
> -    {
> -        $name_trans = 1;
> -        $tst_count += 2;
> +    if ( not $nfs_enabled and not $vfat_enabled ) {
> +        if (    $mod_pol_vers >= 11
> +            and $pol_vers >= 25
> +            and $max_kernel_policy >= 25 )
> +        {
> +            $name_trans = 1;
> +            $tst_count += 2;
> +        }
> +    }
> +
> +    $type_trans = 0;
> +    if ( not $nfs_enabled and not $vfat_enabled ) {
> +        $type_trans = 1;
> +        $tst_count += 1;
>      }

Why is this disabled on (labeled) NFS?  type_transitions including
name-based ones should work there AFAICT.  vfat makes sense.

> @@ -121,7 +134,7 @@ sub make_fs {
>      attach_dev( $mk_dev, $mk_dir );
>
>      print "Make $mk_type filesystem on $mk_dev\n";
> -    $result = system("mkfs.$mk_type -I 256 $mk_dev >& /dev/null");
> +    $result = system("mkfs.$mk_type $mk_dev >& /dev/null");

What's the effect of dropping -I 256 on ext4 testing?  e.g. do we stop
testing inline xattrs?

> diff --git a/tests/filesystem/test b/tests/filesystem/test
> index 78faf72..7074f36 100755
> --- a/tests/filesystem/test
> +++ b/tests/filesystem/test
> +
> +    if ($nfs_enabled) {
> +        $test_count -= 3;    # For hooks.c may_create() FILESYSTEM__ASSOCIATE
> +        $test_count -=
> +          3;    # For hooks.c selinux_inode_setxattr() FILESYSTEM__ASSOCIATE
> +        $test_count -= 2;     # For additional Test Invalid Mount tests
> +        $test_count -= 20;    # For tests involving multiple *context= options
> +        if ( $seclabel_type eq 0 ) {
> +            $test_count -= 4;    # If no context option set
> +        }
> +        elsif ( $seclabel_type eq 1 ) {
> +            $test_count -= 2;    # If rootcontext option set
> +        }
> +        elsif ( $seclabel_type eq 2 ) {
> +            $test_count -= 2;    # If fscontext option set
> +        }
> +    }

A tad unclear on the rationale for removing all of these.  Are they
truly not supported by nfs (if so, is that a bug or expected behavior
e.g. an inherent difference between network and local filesystems that
cannot be addressed without changes to the NFS protocol itself), or
are they just not supported by existing policy?
