Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106060;
	b=1stUT7yrnLkth7xikP3SFllqWsgaj9z0ZM63wb8Tk/OoXve4ORaKcVgh67xPwQFUhJZB
	 +eKH+2MGg+WXvyvw/Zfu5KSx+Sh3XRsoQ7R8qde5rD/qoMksW0wMY8OjG51QdShS/63ww
	 /nBcVnXBVZFY03ILK3jdMonil7v5/cmg2lfFYQ3HOftasynKCHUvpaznjKk/QF/bNu3lo
	 L7+S40H3Xb7k4XCJfbFVIbbsGPYky9Ch7dt/+bgm5qolbnN8Zsb8PUjyLRa0CZVCXyAjx
	 zCSPT6kP8gUg5AxllCGKVBnRp78Aibx6ngCFh4L7jLFcek85LIgzNk53Y/ki2bBFA2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106060;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
	 X-Scanned-By;
	bh=8OdLfYDe3nmitHFFFJKZs/kHf9BtQdhPfeSPyFxXPqY=;
	b=vdWDszgf2mojWsl+BuIxIjgAU4ZGc3v0vPvR3w20YPEVxCsR259983YcpUO5wKV6HDRX
	 vyRPZx0pLzzPY0Mc2ItNeTMqs3ctdCgzHLBBiSdQuL2kQkF6IYpHZFhHVLjHqUYRib0+V
	 gOdzp0OvFuJCFW5wlnp1pIMrFYs5+1chTc4ZTPgLnOLJb98e4qhKwq6GFVz2DJPWQdmm6
	 ebOTXNYxWD0YqKxevn0I+P72OQ6HxgdgdF2Zx4W/PwvgOM0oZKJwTBxu3HF0tu7zwMacE
	 hNBgVCfHVeUqm8bGktnzCtOs6h7hM9enET5e23kb53MWMLp+bUr2SIJ5N9NQcxxJDeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L7a1ukqR;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F75606A320
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 16:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1F75606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L7a1ukqR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795106058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8OdLfYDe3nmitHFFFJKZs/kHf9BtQdhPfeSPyFxXPqY=;
	b=L7a1ukqRyc2ZcqM/ZJa/Q1/FMDXUBsj69vTqin+9aW2ZYjk8lv4lN/ROnw8ugkjs2c3NGA
	37ko615jWmgCbKouigZb8DKlKY1gGFcG6SOvnp6+6A6DkKrRS/CoDT46aHBadxenM/ah3U
	5C1rnbsu2qrMrzMyoV3+mepYYtut4/Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-OQM0xi43NEqwBg6vw7TMJQ-1; Thu,
 19 Nov 2026 16:34:14 +0000
X-MC-Unique: OQM0xi43NEqwBg6vw7TMJQ-1
X-Mimecast-MFC-AGG-ID: OQM0xi43NEqwBg6vw7TMJQ_1795106052
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B731195D028;
	Thu, 19 Nov 2026 16:33:54 +0000 (UTC)
Received: from plautrba-thinkpadp16vgen1.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0807F1801976;
	Thu, 19 Nov 2026 16:33:49 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnacek@gmail.com, jwcart2@gmail.com, paul@paul-moore.com,
 jason@perfinion.com, cahu@suse.de, jsegitz@suse.de, tweek@google.com,
 Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH 1/3] sandbox/sandbox: do not follow symlinks when
 shredding sandbox directories
In-Reply-To: <pjdjym9vt5i.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
References: <20261119130355.707-1-stephen.smalley.work@gmail.com>
 <pjdjym9vt5i.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
Date: Thu, 19 Nov 2026 17:33:46 +0100
Message-ID: <pjdzev4vl05.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Petr Lautrbach <lautrbach@redhat.com> writes:

> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
>> sandbox --shred walks the sandbox home/tmp/runuser directories after
>> the sandboxed process has exited and passes each file to
>> /usr/bin/shred.  os.walk() reports symbolic links to files in its
>> "files" list, and shred opens its operand following symlinks and
>> overwrites the target file in place.
>>
>> The walk runs in the invoking user's domain, not in the sandbox
>> domain, so a symlink planted by the sandboxed process lets it destroy
>> files it could not otherwise reach. Further, a child of the sandboxed
>> process can survive and race with the walk to swap a file with a
>> symlink to a file it could not otherwise reach.
>>
>> Fix by replacing the use of /usr/bin/shred with an inline fd-based
>> walk using os.fwalk(follow_symlinks=False) that pins each directory by
>> fd and rejects a directory that was replaced by a symlink after lstat
>> and open; open each leaf O_WRONLY|O_NOFOLLOW|O_NONBLOCK so that we do
>> not follow symlinks and cannot be blocked by a planted fifo; refuse to
>> act on anything that is not a regular file after open; then zero and
>> fsync.
>>
>> Fixing seunshare to ensure that no sandbox descendant survives is left
>> to a future change but is not necessary to close this issue.
>>
>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>

This series has been merged.


>> ---
>>  sandbox/sandbox | 22 +++++++++++++++++++---
>>  1 file changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/sandbox/sandbox b/sandbox/sandbox
>> index 6a18b660..cfcc0b61 100644
>> --- a/sandbox/sandbox
>> +++ b/sandbox/sandbox
>> @@ -540,10 +540,26 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
>>                  shutil.rmtree(self.__runuserdir)
>>  
>>      def shred(self, path):
>> -        for root, dirs, files in os.walk(path):
>> +        for root, dirs, files, dirfd in os.fwalk(path, follow_symlinks=False):
>>              for f in files:
>> -                dest = root + "/" + f
>> -                subprocess.Popen(["/usr/bin/shred", dest]).wait()
>> +                try:
>> +                    fd = os.open(f, os.O_WRONLY | os.O_NOFOLLOW | os.O_NONBLOCK,
>> +                                 dir_fd=dirfd)
>> +                except OSError:
>> +                    continue
>> +                try:
>> +                    st = os.fstat(fd)
>> +                    if not stat.S_ISREG(st.st_mode):
>> +                        continue
>> +                    remaining = st.st_size
>> +                    while remaining > 0:
>> +                        chunk = b"\x00" * min(remaining, 1 << 20)
>> +                        remaining -= os.write(fd, chunk)
>> +                    os.fsync(fd)
>> +                except OSError:
>> +                    pass
>> +                finally:
>> +                    os.close(fd)
>>  
>>      def main(self):
>>          try:
>> -- 
>> 2.47.3

