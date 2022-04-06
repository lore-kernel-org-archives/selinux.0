Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568E3C433F5
	for <selinux@archiver.kernel.org>; Wed,  6 Apr 2022 13:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiDFNkC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Apr 2022 09:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbiDFNjq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Apr 2022 09:39:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 738D34FAC1C
        for <selinux@vger.kernel.org>; Wed,  6 Apr 2022 03:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649241715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bh/fAlEcL8Tgmsz2lL6Kj77g0X2HE2MRjwIAjVJT31Y=;
        b=QVvYB2ib2WNnlIx2sQz/atrKF4p63y1ov8DjTMWKrLOGgf+ql/ggg2jeOkhzBFeIVfB/Yl
        YJFlXttRpAxUPkgJOlO16ORvVabiqCcy3+gEJNyGEj+4xWoe8ehEjtvb0s0kVTtKHPHT9v
        oLTmt4W9bAMYqC+KTR8mVOsCp7uhmJ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641--Ausq0TgN-mL77FmOdGDNQ-1; Wed, 06 Apr 2022 06:41:52 -0400
X-MC-Unique: -Ausq0TgN-mL77FmOdGDNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A88B218A6583;
        Wed,  6 Apr 2022 10:41:51 +0000 (UTC)
Received: from localhost (unknown [10.40.193.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D75F540CF910;
        Wed,  6 Apr 2022 10:41:48 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH] policycoreutils: drop usage of egrep in fixfiles
In-Reply-To: <20220405133958.52460-1-cgzones@googlemail.com>
References: <20220405133958.52460-1-cgzones@googlemail.com>
Date:   Wed, 06 Apr 2022 12:41:48 +0200
Message-ID: <878rsipk7n.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> egrep(1) is deprecated, use `grep -E`.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Petr Lautrbach <plautrba@redhat.com>


> ---
>  policycoreutils/scripts/fixfiles | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/f=
ixfiles
> index 7df4303a..c72ca0eb 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -45,9 +45,9 @@ FS=3D"`cat /proc/self/mounts | sort | uniq | awk '{prin=
t $2}'`"
>  for i in $FS; do
>  	if [ `useseclabel` -ge 0 ]
>  	then
> -		grep " $i " /proc/self/mounts | awk '{print $4}' | egrep --silent '(^|=
,)seclabel(,|$)' && echo $i
> +		grep " $i " /proc/self/mounts | awk '{print $4}' | grep -E --silent '(=
^|,)seclabel(,|$)' && echo $i
>  	else
> -		grep " $i " /proc/self/mounts | grep -v "context=3D" | egrep --silent =
'(ext[234]| ext4dev | gfs2 | xfs | jfs | btrfs )' && echo $i
> +		grep " $i " /proc/self/mounts | grep -v "context=3D" | grep -E --silen=
t '(ext[234]| ext4dev | gfs2 | xfs | jfs | btrfs )' && echo $i
>  	fi
>  done
>  }
> @@ -55,14 +55,14 @@ done
>  get_rw_labeled_mounts() {
>  FS=3D`get_all_labeled_mounts | sort | uniq`
>  for i in $FS; do
> -	grep " $i " /proc/self/mounts | awk '{print $4}' | egrep --silent '(^|,=
)rw(,|$)' && echo $i
> +	grep " $i " /proc/self/mounts | awk '{print $4}' | grep -E --silent '(^=
|,)rw(,|$)' && echo $i
>  done
>  }
>=20=20
>  get_ro_labeled_mounts() {
>  FS=3D`get_all_labeled_mounts | sort | uniq`
>  for i in $FS; do
> -	grep " $i " /proc/self/mounts | awk '{print $4}' | egrep --silent '(^|,=
)ro(,|$)' && echo $i
> +	grep " $i " /proc/self/mounts | awk '{print $4}' | grep -E --silent '(^=
|,)ro(,|$)' && echo $i
>  done
>  }
>=20=20
> @@ -176,7 +176,7 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
>  	sed -r -e 's,:s0, ,g' $FC | sort -u | \
>  	/usr/bin/diff -b ${PREFCTEMPFILE} - | \
>  	    grep '^[<>]'|cut -c3-| grep ^/ | \
> -	    egrep -v '(^/home|^/root|^/tmp)' |\
> +	    grep -Ev '(^/home|^/root|^/tmp)' |\
>  	sed -r -e 's,[[:blank:]].*,,g' \
>  	       -e 's|\(([/[:alnum:]]+)\)\?|{\1,}|g' \
>  	       -e 's|([/[:alnum:]])\?|{\1,}|g' \
> --=20
> 2.35.1

