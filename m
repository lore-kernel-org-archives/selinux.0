Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E465E148316
	for <selinux@vger.kernel.org>; Mon,  3 Mar 2025 18:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741025207; cv=none; b=ZjqKlymHqJ5Eo4RJU51+4YjFJHa5r/bQZMW94Ex3+Cs7khMr2JHr22/jvW1yoO4Suw2WhmjeyLvkZt7mY6W1LQSvDFmnDaBpipm3BtAW42Ny92a0x9o0WpGVvNpnzi7MAFUd71MCo5FVSCUc4j/w0dIy0FXkQ7jh876ViEynxx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741025207; c=relaxed/simple;
	bh=5OG8cjm4s+KKNzVucOWMVmZuhUWCGpei3FGAKtSVC08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RHMSUtO1/ZeIO5SI+ZnYu6my4WmrPYmt2RMW0DEthJ8EyTjwrVMRUWVYFQ2ktTfiFg8Wpa49WAKR+MgRXVtBw/gmyX0MQkWTcPI50H9GXaF/4yNh2E5AUh7O/zvOzAdNpYpAA3foVcAJ8eh9TDV0onHDKQs90XUNbboeDH3D7Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ShvzZkOh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShvzZkOh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741025203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SXilqrElp+wX0+CuNTW8Apmv9kv+ZnbjAvuopuw+uhE=;
	b=ShvzZkOhdC5mg6IOdpNsWxi2Xc9nZpW+Z35PyN3vFWXZXc4gPyG7oaBZIqPd6tw0p3GbFg
	1fA5o0R0OqUZyimsMzndYzktJYAK3mmBOLKM6VCy4zHxFNL+m9fx9sfuY6wUAVbVy8k/Q3
	Bz0WeosECor1/KUHOoPS03noqCew0YE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-qB6JbW5OM16bEh0vBjptLg-1; Mon,
 03 Mar 2025 13:06:32 -0500
X-MC-Unique: qB6JbW5OM16bEh0vBjptLg-1
X-Mimecast-MFC-AGG-ID: qB6JbW5OM16bEh0vBjptLg_1741025191
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C68811800871;
	Mon,  3 Mar 2025 18:06:30 +0000 (UTC)
Received: from localhost (unknown [10.45.226.154])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 957A619560AE;
	Mon,  3 Mar 2025 18:06:29 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org, Jason Zaman <jason@perfinion.com>
Cc: 
Subject: Re: [PATCH] libsemanage: improve performance of semanage store rebuild
In-Reply-To: <Z79A97uBFd_6RTFz@anduin.perfinion.com>
References: <20250225075555.16136-1-lautrbach@redhat.com>
 <Z79A97uBFd_6RTFz@anduin.perfinion.com>
Date: Mon, 03 Mar 2025 19:06:28 +0100
Message-ID: <87bjui9efv.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Jason Zaman <jason@perfinion.com> writes:

> On Tue, Feb 25, 2025 at 08:55:23AM +0100, Petr Lautrbach wrote:
>> Commit 9d107ab77ba4 ("libsemanage: Set new restorecon handle before doing restorecon
>> ") added reopeniong selabel handle every time semanage_setfiles() is
>> called. It means that during `semodule -B`, `selabel_close()` and
>> `selabel_open()` could be called more than 1800x what could have a
>> significant performance impact.
>> 
>> It should be enough to reopen selabel handle just after semanage commit
>> when changes are applied.
>> 
>> Before 9d107ab77ba4:
>>     semodule -B  5.84s user 0.52s system 96% cpu 6.585 total
>> 
>> After 9d107ab77ba4:
>>     semodule -B  11.15s user 0.64s system 98% cpu 11.952 total
>> 
>> With this patch:
>>     semodule -B  5.51s user 0.41s system 98% cpu 6.014 total
>> 
>> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> Acked-by: Jason Zaman <jason@perfinion.com>

Merged.


>> ---
>>  libsemanage/src/semanage_store.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>> 
>> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
>> index cf9aa809b7f8..307f27f9838b 100644
>> --- a/libsemanage/src/semanage_store.c
>> +++ b/libsemanage/src/semanage_store.c
>> @@ -1712,6 +1712,7 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
>>  	    semanage_path(SEMANAGE_PREVIOUS, SEMANAGE_TOPLEVEL);
>>  	const char *sandbox = semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL);
>>  	struct stat buf;
>> +	struct selabel_handle *sehandle;
>>  
>>  	/* update the commit number */
>>  	if ((commit_number = semanage_direct_get_serial(sh)) < 0) {
>> @@ -1822,6 +1823,8 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
>>  
>>        cleanup:
>>  	semanage_release_active_lock(sh);
>> +	sehandle = selinux_restorecon_default_handle();
>> +	selinux_restorecon_set_sehandle(sehandle);
>>  	return retval;
>>  }
>>  
>> @@ -3012,14 +3015,10 @@ log_callback_mute(__attribute__((unused)) int type, __attribute__((unused)) cons
>>  void semanage_setfiles(semanage_handle_t * sh, const char *path){
>>  	struct stat sb;
>>  	int fd;
>> -	struct selabel_handle *sehandle;
>>  
>>  	union selinux_callback cb_orig = selinux_get_callback(SELINUX_CB_LOG);
>>  	union selinux_callback cb = { .func_log = log_callback_mute };
>>  
>> -	sehandle = selinux_restorecon_default_handle();
>> -	selinux_restorecon_set_sehandle(sehandle);
>> -
>>  	/* Mute all logs */
>>  	selinux_set_callback(SELINUX_CB_LOG, cb);
>>  
>> -- 
>> 2.48.1
>> 
>> 

