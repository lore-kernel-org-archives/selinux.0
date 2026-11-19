Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095479;
	b=UyqvmVXIfMwLtohd1I9/qHW3t9cfSP8oYA6AlJpDHu4dxU2mFk1D3rmb7coIhMhkiRul
	 Beob57J03ynwScGocKu43wOb+XQ6Jf3iBKIDvwX63E4+DCQeUo3X0a6Wu50u/LO+M1Noz
	 jqQwPnrVOSnFtFMCn0KRW9Lgqx9eQ6vgv9uc8JUG7PfWNtXW2LXvXqqZUnUyKPbIcKnLw
	 +pYd4kHPyluKjNbR4N2GV37fhleeY3DZ0oDCSA51bjSqikhmnIn6TPVPLXRI7hZwD7Nj3
	 Br2ISHaSvNvowUuDP8ooCjns4ZSWeogRwloP+0rDFbrb2DLg7oWndXDHiov54DStX5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095479;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
	 X-Scanned-By;
	bh=2UEQVnHAQhIv2JvokPBkjPiCQ1YQ8NAYQRcspoaguhc=;
	b=YtBtgpyIIHOVVIfsvff5PMCD3YxIvUkz8v6K8l12lHNqqJP8QPS0Am8I31+drBWvS4+R
	 Gqp9r+cVOA28JuJNGDuxOhGSwYG9Wwv5od3VXuTTmWgYLHy+eeRIjYoKWekmP5RmnwzlU
	 TMmRxWw1WYP127pLr2QXqQlLqcWT4ClGER818bmUA1PWviyPflVWp7BBb2G/oqrKUlHHe
	 uCiSUiEbBie37V4egTipVjljQgtgBmRi2ZcTFd6mWmVFa6Xafj/oi9mxZ8NvTzKzCq6RT
	 Da1yewYbQrXa3gtFelR0LiysxA+yUBT1kFsrjyn8v55uBcVhJxhwNuXS3anFaZ1Asow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R4RWXq1S;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819AE606A320
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 13:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 819AE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R4RWXq1S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795095477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2UEQVnHAQhIv2JvokPBkjPiCQ1YQ8NAYQRcspoaguhc=;
	b=R4RWXq1Sft3n/ByI3ay96v4AL8rOEdWDs+i98w9ZuV9IqN7tYVp8LemEEkvj4fba5BhJN5
	2S7TUeyHeYxoHynQ5ROvcLzKGeTVNET0Jzh/IJk81NtmhLGA1edu9lSbcYI6nPwgzinIga
	aJoXG8TubAB2G6/lAzbsieBFe/RuQjM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-ugOI97GDPD61dSvUnE8_WA-1; Thu,
 19 Nov 2026 08:37:54 -0500
X-MC-Unique: ugOI97GDPD61dSvUnE8_WA-1
X-Mimecast-MFC-AGG-ID: ugOI97GDPD61dSvUnE8_WA_1795095472
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 02ABF195608D;
	Thu, 19 Nov 2026 13:37:52 +0000 (UTC)
Received: from plautrba-thinkpadp16vgen1.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D7A6195B3C7;
	Thu, 19 Nov 2026 13:37:48 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnacek@gmail.com, jwcart2@gmail.com, paul@paul-moore.com,
 jason@perfinion.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH 1/3] sandbox/sandbox: do not follow symlinks when
 shredding sandbox directories
In-Reply-To: <20261119130355.707-1-stephen.smalley.work@gmail.com>
References: <20261119130355.707-1-stephen.smalley.work@gmail.com>
Date: Thu, 19 Nov 2026 14:37:45 +0100
Message-ID: <pjdjym9vt5i.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> sandbox --shred walks the sandbox home/tmp/runuser directories after
> the sandboxed process has exited and passes each file to
> /usr/bin/shred.  os.walk() reports symbolic links to files in its
> "files" list, and shred opens its operand following symlinks and
> overwrites the target file in place.
>
> The walk runs in the invoking user's domain, not in the sandbox
> domain, so a symlink planted by the sandboxed process lets it destroy
> files it could not otherwise reach. Further, a child of the sandboxed
> process can survive and race with the walk to swap a file with a
> symlink to a file it could not otherwise reach.
>
> Fix by replacing the use of /usr/bin/shred with an inline fd-based
> walk using os.fwalk(follow_symlinks=False) that pins each directory by
> fd and rejects a directory that was replaced by a symlink after lstat
> and open; open each leaf O_WRONLY|O_NOFOLLOW|O_NONBLOCK so that we do
> not follow symlinks and cannot be blocked by a planted fifo; refuse to
> act on anything that is not a regular file after open; then zero and
> fsync.
>
> Fixing seunshare to ensure that no sandbox descendant survives is left
> to a future change but is not necessary to close this issue.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

> ---
>  sandbox/sandbox | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/sandbox/sandbox b/sandbox/sandbox
> index 6a18b660..cfcc0b61 100644
> --- a/sandbox/sandbox
> +++ b/sandbox/sandbox
> @@ -540,10 +540,26 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
>                  shutil.rmtree(self.__runuserdir)
>  
>      def shred(self, path):
> -        for root, dirs, files in os.walk(path):
> +        for root, dirs, files, dirfd in os.fwalk(path, follow_symlinks=False):
>              for f in files:
> -                dest = root + "/" + f
> -                subprocess.Popen(["/usr/bin/shred", dest]).wait()
> +                try:
> +                    fd = os.open(f, os.O_WRONLY | os.O_NOFOLLOW | os.O_NONBLOCK,
> +                                 dir_fd=dirfd)
> +                except OSError:
> +                    continue
> +                try:
> +                    st = os.fstat(fd)
> +                    if not stat.S_ISREG(st.st_mode):
> +                        continue
> +                    remaining = st.st_size
> +                    while remaining > 0:
> +                        chunk = b"\x00" * min(remaining, 1 << 20)
> +                        remaining -= os.write(fd, chunk)
> +                    os.fsync(fd)
> +                except OSError:
> +                    pass
> +                finally:
> +                    os.close(fd)
>  
>      def main(self):
>          try:
> -- 
> 2.47.3

