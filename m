Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eD0RFI29"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1306B114
	for <selinux@vger.kernel.org>; Sun,  3 Dec 2023 05:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701611237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G6n4gkU3N/v7q0hGMcejn7WVq9Ifmgc/fzDPpTHt67c=;
	b=eD0RFI29vTlPaKq4kE6+QyQKvO0WtZZKbNluqxk5PQsb04GHKK4+qcU71p7GXGmTEW8vsw
	vqecCg3AW+w5PTs0XzKENkKQ4wGwEtACi0yhogOABtomAp2GtLMGApTWZtabrM9Ncqy4ET
	JHzxrBIw8PUpJHhgsXHXlpDqyHDda3Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-D6NomQRIM4udpeJ_0kqM3g-1; Sun,
 03 Dec 2023 08:47:13 -0500
X-MC-Unique: D6NomQRIM4udpeJ_0kqM3g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FDE72810D54;
	Sun,  3 Dec 2023 13:47:13 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AAD772026D4C;
	Sun,  3 Dec 2023 13:47:08 +0000 (UTC)
Date: Sun, 3 Dec 2023 21:47:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, joshi.k@samsung.com,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH v2 2/3] io_uring/cmd: inline io_uring_cmd_do_in_task_lazy
Message-ID: <ZWyG19/yZxT1Anqd@fedora>
References: <cover.1701391955.git.asml.silence@gmail.com>
 <2ec9fb31dd192d1c5cf26d0a2dec5657d88a8e48.1701391955.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ec9fb31dd192d1c5cf26d0a2dec5657d88a8e48.1701391955.git.asml.silence@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Fri, Dec 01, 2023 at 12:57:36AM +0000, Pavel Begunkov wrote:
> Now as we can easily include io_uring_types.h, move IOU_F_TWQ_LAZY_WAKE
> and inline io_uring_cmd_do_in_task_lazy().
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

