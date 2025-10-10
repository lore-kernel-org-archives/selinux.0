Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF5B2773D3
	for <selinux@vger.kernel.org>; Fri, 10 Oct 2025 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760083747; cv=none; b=Pvy8HCE9nehHPEzS2RSVIj/429/x8sDtVbCVKL3wsmz5rgTXHj10H1HMlYM96E+k7HdZOQz+F5fOFQIfK1bo+qu8tIechjJxLIvMfLriQhPBqwHhnBRyQ+4EdIoHti44m2WrFBAL6OP33sUD7cXnIlP33+y5VVuIU1vLeThDt1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760083747; c=relaxed/simple;
	bh=L4I2qQwE4xJR3w4IvEFVulx1Gvh9gh9++TEo26xPfIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a2jk6SracTIgcf+0/4mraDL5Mvet0gcRlud6T+Jbq193NQcQwRorC1wZXvSFj7GT6FO+ciBZKMItsgI0cxZYafbEHfabNicXWrDd2ozYd4XX72cHrsb7O2JE3auq8soXM3Y9pLAYUmLnLDEBjJx7WTmhNW9sk0nqdp3C5NPUlO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FhySlTPC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhySlTPC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760083745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/PY2gaFRsXImxKdqBEquJjqplRKsrD/Vh0sWZritK2I=;
	b=FhySlTPCYWwZtPfZKX1pIGn1RdladwIXbSUaGpk6YA3LcIeN+o8ZB5x7fT9DV/K5iMQOea
	Xp5FAi5VUTEm5cpu+I8ReZt8ZTuXi7lP+0v3bqu8/FLW/T4Fc17MBxw9V+M3n+uKGln2Mt
	Vvw/ckxT2HxtKx1kNtph3a066EIy9SQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-gEaA_Z-8NSGphlwfWz1Ctg-1; Fri, 10 Oct 2025 04:09:03 -0400
X-MC-Unique: gEaA_Z-8NSGphlwfWz1Ctg-1
X-Mimecast-MFC-AGG-ID: gEaA_Z-8NSGphlwfWz1Ctg_1760083743
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b3cb0f2b217so291860266b.2
        for <selinux@vger.kernel.org>; Fri, 10 Oct 2025 01:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760083742; x=1760688542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/PY2gaFRsXImxKdqBEquJjqplRKsrD/Vh0sWZritK2I=;
        b=TYCTKAioETW25D5gLcqpkfYs5CiuwXwI7/wl+sed/TIdJmwEQijKZiY4iGMqkppZgM
         eJyn0aiyyUfLRuXGGS1dtKg1Ip7QqsKgsIi1oOlnocp4/WUEufzASqWFhCZG3ifUD2cb
         Z0ewus5XCUIJ0jS4yrYLDUTdfgGv69DSw5FS2/h0moj+2a8LZ1ityKx+OypTkSrNd/TU
         NrKM1aRVUC7pvmq7J1xh5zBkvpw/paBtyW8dH90vqQVMnHqNzsIlI9+eEOKjK4qJYEfU
         u39sgeebw8fmGVYCn6ImkVO3tdTCHlCjzefKghy2ySELoUj8ovLc224xt9HRnCXZcbZQ
         geXw==
X-Forwarded-Encrypted: i=1; AJvYcCVsO7VMQIXxjI5w0TqrO5NSusV8wQOB0y5qnPZNGOWjyay+RSJsb4RDTDVm4p8OLaWjqIyjlEL9@vger.kernel.org
X-Gm-Message-State: AOJu0Yys/p6sQBuFNMpT5H/9RVNFAgxF0vKBqG2Kob2BNGHlymhoUQqL
	3FNDYSRTtBkbJGFMRGCedF10Y47UOD2uKaWJLag40xivtzH7TyzLmPAKRKqOkBw8eYYOLC7mHEy
	qS28E6WledFi8aZmLyqhIcTmdNspXSqmWUvod4iQ1dOMTjzKKdyXHqLho49s=
X-Gm-Gg: ASbGncsNwLJ7IZQDAPIv3WmwyazsLmu+lDJJpVWYrILRaFqMr1zolg0B3o/RzypIEiA
	sF7HJZKRtW66m+eQ4Qtm8IzfGxXHDINPF7ENxj7Ne7D2OwknkvJDDc6bG69u450QsYGmB60CJrz
	xim8I6KdZCh+ZJQ7Lax3Sebf+9/+C9uDKmmAs0QBJoB4UkGiY2r/0RCD/QfRud/8Ch6452N45Ss
	HkJ8RAuEbdl+60jAVoVA/giGNZMJdN09ESx+kcLfo46dTn19HGRxre98Xytl8q+eRwkAT7293dG
	Q7s/3txR5XcfyRnSfyp57WEsF6EXF+0AYy/h
X-Received: by 2002:a17:906:ee89:b0:b3c:896:abf5 with SMTP id a640c23a62f3a-b50aa393bc7mr1142560366b.25.1760083742377;
        Fri, 10 Oct 2025 01:09:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6MmakUZRFgwAiuScJI9gru6tPPAJEKkB0mpdEKWKLWgqJ4dbClzuAVkwqsASebSsNiHDHtA==
X-Received: by 2002:a17:906:ee89:b0:b3c:896:abf5 with SMTP id a640c23a62f3a-b50aa393bc7mr1142557466b.25.1760083741964;
        Fri, 10 Oct 2025 01:09:01 -0700 (PDT)
Received: from fedora ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d95257c8sm171260166b.77.2025.10.10.01.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 01:09:01 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2] nbd: override creds to kernel when calling sock_{send,recv}msg()
Date: Fri, 10 Oct 2025 10:09:00 +0200
Message-ID: <20251010080900.1680512-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sock_{send,recv}msg() internally calls security_socket_{send,recv}msg(),
which does security checks (e.g. SELinux) for socket access against the
current task. However, _sock_xmit() in drivers/block/nbd.c may be called
indirectly from a userspace syscall, where the NBD socket access would
be incorrectly checked against the calling userspace task (which simply
tries to read/write a file that happens to reside on an NBD device).

To fix this, temporarily override creds to kernel ones before calling
the sock_*() functions. This allows the security modules to recognize
this as internal access by the kernel, which will normally be allowed.

A way to trigger the issue is to do the following (on a system with
SELinux set to enforcing):

    ### Create nbd device:
    truncate -s 256M /tmp/testfile
    nbd-server localhost:10809 /tmp/testfile

    ### Connect to the nbd server:
    nbd-client localhost

    ### Create mdraid array
    mdadm --create -l 1 -n 2 /dev/md/testarray /dev/nbd0 missing

After these steps, assuming the SELinux policy doesn't allow the
unexpected access pattern, errors will be visible on the kernel console:

[  142.204243] nbd0: detected capacity change from 0 to 524288
[  165.189967] md: async del_gendisk mode will be removed in future, please upgrade to mdadm-4.5+
[  165.252299] md/raid1:md127: active with 1 out of 2 mirrors
[  165.252725] md127: detected capacity change from 0 to 522240
[  165.255434] block nbd0: Send control failed (result -13)
[  165.255718] block nbd0: Request send failed, requeueing
[  165.256006] block nbd0: Dead connection, failed to find a fallback
[  165.256041] block nbd0: Receive control failed (result -32)
[  165.256423] block nbd0: shutting down sockets
[  165.257196] I/O error, dev nbd0, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[  165.257736] Buffer I/O error on dev md127, logical block 0, async page read
[  165.258263] I/O error, dev nbd0, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[  165.259376] Buffer I/O error on dev md127, logical block 0, async page read
[  165.259920] I/O error, dev nbd0, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[  165.260628] Buffer I/O error on dev md127, logical block 0, async page read
[  165.261661] ldm_validate_partition_table(): Disk read failed.
[  165.262108] I/O error, dev nbd0, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[  165.262769] Buffer I/O error on dev md127, logical block 0, async page read
[  165.263697] I/O error, dev nbd0, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[  165.264412] Buffer I/O error on dev md127, logical block 0, async page read
[  165.265412] I/O error, dev nbd0, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[  165.265872] Buffer I/O error on dev md127, logical block 0, async page read
[  165.266378] I/O error, dev nbd0, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[  165.267168] Buffer I/O error on dev md127, logical block 0, async page read
[  165.267564]  md127: unable to read partition table
[  165.269581] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[  165.269960] Buffer I/O error on dev nbd0, logical block 0, async page read
[  165.270316] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[  165.270913] Buffer I/O error on dev nbd0, logical block 0, async page read
[  165.271253] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
[  165.271809] Buffer I/O error on dev nbd0, logical block 0, async page read
[  165.272074] ldm_validate_partition_table(): Disk read failed.
[  165.272360]  nbd0: unable to read partition table
[  165.289004] ldm_validate_partition_table(): Disk read failed.
[  165.289614]  nbd0: unable to read partition table

The corresponding SELinux denial on Fedora/RHEL will look like this
(assuming it's not silenced):
type=AVC msg=audit(1758104872.510:116): avc:  denied  { write } for  pid=1908 comm="mdadm" laddr=::1 lport=32772 faddr=::1 fport=10809 scontext=system_u:system_r:mdadm_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=tcp_socket permissive=0

The respective backtrace looks like this:
@security[mdadm, -13,
        handshake_exit+221615650
        handshake_exit+221615650
        handshake_exit+221616465
        security_socket_sendmsg+5
        sock_sendmsg+106
        handshake_exit+221616150
        sock_sendmsg+5
        __sock_xmit+162
        nbd_send_cmd+597
        nbd_handle_cmd+377
        nbd_queue_rq+63
        blk_mq_dispatch_rq_list+653
        __blk_mq_do_dispatch_sched+184
        __blk_mq_sched_dispatch_requests+333
        blk_mq_sched_dispatch_requests+38
        blk_mq_run_hw_queue+239
        blk_mq_dispatch_plug_list+382
        blk_mq_flush_plug_list.part.0+55
        __blk_flush_plug+241
        __submit_bio+353
        submit_bio_noacct_nocheck+364
        submit_bio_wait+84
        __blkdev_direct_IO_simple+232
        blkdev_read_iter+162
        vfs_read+591
        ksys_read+95
        do_syscall_64+92
        entry_SYSCALL_64_after_hwframe+120
]: 1

The issue has started to appear since commit 060406c61c7c ("block: add
plug while submitting IO").

Cc: Ming Lei <ming.lei@redhat.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2348878
Fixes: 060406c61c7c ("block: add plug while submitting IO")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

Changes in v2:
 * Move put_cred() after destroy_workqueue() in nbd_cleanup() to avoid a UAF
 * Add some more details into the commit message
 * Add a Fixes: tag

v1: https://lore.kernel.org/linux-block/20251009134542.1529148-1-omosnace@redhat.com/

 drivers/block/nbd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 6463d0e8d0cef..3903186e8a4e4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -52,6 +52,7 @@
 static DEFINE_IDR(nbd_index_idr);
 static DEFINE_MUTEX(nbd_index_mutex);
 static struct workqueue_struct *nbd_del_wq;
+static struct cred *nbd_cred;
 static int nbd_total_devices = 0;
 
 struct nbd_sock {
@@ -554,6 +555,7 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 	int result;
 	struct msghdr msg = {} ;
 	unsigned int noreclaim_flag;
+	const struct cred *old_cred;
 
 	if (unlikely(!sock)) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
@@ -562,6 +564,8 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 		return -EINVAL;
 	}
 
+	old_cred = override_creds(nbd_cred);
+
 	msg.msg_iter = *iter;
 
 	noreclaim_flag = memalloc_noreclaim_save();
@@ -586,6 +590,8 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 
+	revert_creds(old_cred);
+
 	return result;
 }
 
@@ -2669,7 +2675,15 @@ static int __init nbd_init(void)
 		return -ENOMEM;
 	}
 
+	nbd_cred = prepare_kernel_cred(&init_task);
+	if (!nbd_cred) {
+		destroy_workqueue(nbd_del_wq);
+		unregister_blkdev(NBD_MAJOR, "nbd");
+		return -ENOMEM;
+	}
+
 	if (genl_register_family(&nbd_genl_family)) {
+		put_cred(nbd_cred);
 		destroy_workqueue(nbd_del_wq);
 		unregister_blkdev(NBD_MAJOR, "nbd");
 		return -EINVAL;
@@ -2724,6 +2738,7 @@ static void __exit nbd_cleanup(void)
 	/* Also wait for nbd_dev_remove_work() completes */
 	destroy_workqueue(nbd_del_wq);
 
+	put_cred(nbd_cred);
 	idr_destroy(&nbd_index_idr);
 	unregister_blkdev(NBD_MAJOR, "nbd");
 }
-- 
2.51.0

