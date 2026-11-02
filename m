Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624745;
	b=KT/GpIFnSTKMy66BBImn5+Sa9LTnLFQ6neBUXjuJ5FnHRRiyKi6HXmurD6A0YJEdJBhG
	 xVwCKKykQDGI5WqPpF+/DzCTHxisZm8ewzRrzPJijzERTjyNGPL5uJhtVBaE5c6FFLwIC
	 0i2AwVcR4F3FcQNHRpI1h4rUYN2enRToHy6/utiP/6rka8kcciVn+5LpwrmDP5vXJhjMw
	 BBzF89ji/Est4DsVQLGjkJPBSv2hhpdbM1FUCbRR2mCgjvg5AehdMG0KPHbpopyf+FBUm
	 tEQo3sQTE2g/jS92k6S13ltYvcd3WmfNaCvlOqg9jqqTsQm4wkUBAnEDijUJxR2MSXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2/g1xL5iGwG1omHrmHgnmCBZ/PbDFU5IAnXkvWs0rU8=;
	b=P1Q2PbCpF7eva9Nhg0JhlCbjjVm8ugBgfcZZUvIicQJbtfc/50elvtPCfr63wZjiW7ot
	 vmFGWIzpM3SNb67CvRrCjVN9NCWDPriv5R5Pv/uLNxoyl6Pi7LZQHDJyoEPP4tHBQWkm+
	 coP2UE9bIPiIipM3Du+y85mPSRU4P9+iHuEZSyncKSQ2gAJf/zpvckR/kpYnmDFka7lOh
	 1uuLCphOArH4vsybOxhZnOKeKfDlFBzWcj2riXf17fMunBAs2z52J0csLD/yBPhN7WOyv
	 cqduIhxFRuyZ+PstHRQFgvEB98JcTmmqP3AvN0uLB0MvSpFLc4VGsZHX/Srf5DsMuRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="D9/S9EAi";
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32874606A324
	for <selinux@vger.kernel.org>; Mon,  2 Nov 2026 13:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32874606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D9/S9EAi
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso23296995e9.1
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2026 05:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793624743; x=1794229543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2/g1xL5iGwG1omHrmHgnmCBZ/PbDFU5IAnXkvWs0rU8=;
        b=D9/S9EAiM4U3YwX9Fq+R2/twHKsOr6RHGoCPd6j6+sZL33de8LQ1lj/bFMZ4NaiXRy
         /K4VnigemD4+VqDY0hchVHT6sPvVLpjM8Z9sq/4t/m+SaM0CJW2VlF2qWQ4nD8zgVzzT
         ADN2anmU0+N0l93HJhzGF/rn23AaKvUac8zezVVLv7ffba4YhMrIg4yYa7ZW1floAKUD
         E74hi/fACYkYjv/7C8Lt0IR5C5W4Hph7Ei+hf2dry0AIKw6sWcxcOlO11QQA2vRT43a9
         POLOaDAbcMBVXf9KOrJ5Q/Wd/gJOKqFdgfv5uVMhn0b7YV40mFY3vlVIBbhHgf9kX1oD
         CvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793624743; x=1794229543;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2/g1xL5iGwG1omHrmHgnmCBZ/PbDFU5IAnXkvWs0rU8=;
        b=huh7mY2JXUIjN2gQg7wR6YIgVBtFO9iVO256ucuvpBS2JMptrM35XtSCX25UPIkPzV
         bPmbq8EiIWCIkVgND/+PrZUWOno7oVzqoeQ6yeRS1iT7yRijj8uqkQZt7V16IRTjfSyz
         voMKMCF4bi6L1F9fhJwkbFqqElf+TYGtslLGG7yvC5zPZyzWRgyGcsMx5c+msc7sNvQx
         kVmQrWRB+tDbgQ6jZOX6Jffb0Y8Bw47u/JU24+yLyk1K/cMCASV/huOy/l9x0UlhUhx9
         FxbwjRq1p1Q1U5U51iEZRtVEIspdlLcW3CbaSBvnCgJNdt+Rl9bSjPQmhbnTkMEZGuha
         8qRw==
X-Forwarded-Encrypted: i=1; AKwUvBzBU5TM8AgUP0W9jzJLBHh64otEf4Py6k74Q2Wc6fJOM0/6Hud3VCfobn1DUXSAI0aWTUUM0bvF@vger.kernel.org
X-Gm-Message-State: AFq9FYIHdad37pZsYExI9d4xF1T8T447WgnBnluFHh8mWTIa3OzPil0l
	bkwxESWEAnNd21tCzWd4UnYO5zbHj61NKJzkQTAJW63KmRXkv/DjNVlv
X-Gm-Gg: AYBFou36/KpOfMSIKNOpbJ5/Asl92UKhPL+KiI2mqTv/jG2Ddx9eCxs1uRfvThBi3nq
	yR46FmqqGnn6KhmdvVQxohZB+J9JzLrs0S/bK5ZQ5Qhdjz/PCZrmNcZE4oyARi/UPTgbu/OE5h5
	YhmA8I5WCnFjRwVGOH6udd3kRB/oOvR0m+xkIzpyzmCtKJDJAyHn4y72rbE+v3FF5rmHO9VE8Az
	OPUKEXd+hXzPMEFxfI0T+cpj8L0Vn449Ig5+xhQZkKgG+oS5uyW5LVtxWE6vue8k2OSXK2XK5fr
	53fTq6/lAInl5FzWFY37j9f7vuGXdwjKbI7GFi1gpOd9Zj3FAoS7+GgSIKhtUFRempInthzTid7
	ZLyHtVoHanNNk29ivXqVfa8sCS+rDxppSwrqWQNlfTvFNZiskXGjex8kxcslC5XPulX0FGx1fug
	YtWySfaE80NJgxky5/9DsdeFn3ayvFUr2FaI9ACL0OWtVjLT8bDwiILDrenulXKrFmOeFdTeB4h
	8i3k1W/QmnWSbe2I7xI7yI65jMCZfFqiXeJhvHtw3huuWLzC9D4nifJph3BEQl8Rc2Ffci+sXXx
	oe1817ALYhN5uaYRV/D69zcwF1xvM5dpD7Yb+xdKmgnft5kTErqCWPrhHJ8RvEo7hM3Sl1TGzZu
	GTR5stJ58tQ==
X-Received: by 2002:a05:600c:6087:b0:49f:f099:6fb1 with SMTP id 5b1f17b1804b1-4ac17753befmr226189025e9.15.1793624743352;
        Mon, 02 Nov 2026 05:05:43 -0800 (PST)
Received: from omos-acer.lan (109-81-86-162.rct.o2.cz. [109.81.86.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa813d2640sm340857865e9.6.2026.11.02.05.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:05:42 -0800 (PST)
From: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Simon Horman <horms@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	netdev@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] af_unix: introduce MSG_CMSG_SEALED
Date: Mon,  2 Nov 2026 14:05:40 +0100
Message-ID: <20261102130540.252894-1-omosnacek@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, when a process receives a file through AF_UNIX's SCM_RIGHTS
mechanism, the security_file_receive() LSM hook is calledto allow LSMs
like SELinux to validate the receiver's access to the received file
(similarly to a process inheriting file descriptors through execve(2)).

However, there are cases (such as dbus daemon/dbus-broker) where the
receiver doesn't intend to access the received file and merely wants to
forward it to a third process. In this case the forwarding process would
need to have the appropriate r/w access to the file in order to receive
it, even though it will never actually acess it. That leads to the
security policy having to grant the forwarder access to a potentially
wide range of files (in case of dbus-broker basically all files), which
is not ideal.

This patch adds a new CMSG flag MSG_CMSG_SEALED that, when passed to
recvmsg(2), wraps any received files into an opaque anonymous inode with
the name "[envelope]", skipping the security_file_receive() LSM check.
The returned "[envelope]" file descriptor can't be used in any
meaningful way other than being passed forward via sendmsg(2) with the
MSG_CMSG_SEALED flag. In that case the original file is unwrapped and
sent via SCM_RIGHTS to the receiver. The receiver can then either
receive the file as normal (subject to the LSM check) or again "sealed"
in the "[envelope]" anon inode for further forwarding.

Note that sending the "[envelope]" file is only allowed with the
MSG_CMSG_SEALED flag set, to make the unsealing explicit and avoid
unexpected behavior. Attempting to send it without this flag will fail
with an error. This also avoids recursive nesting of "[envelope]" files,
which would only make this feature harder to audit for possible issues.

This patch also adds a simple read-only sockopt for UNIX sockets that
allows userspace to determine if this feature is present (passing
unknown CMSG flags unfortunately doesn't lead to an error currently).
The minimal code to do so can look like this:

    #ifndef SO_RIGHTS_SEALED_SUPPORTED
    #define SO_RIGHTS_SEALED_SUPPORTED 88
    #endif

    #include <sys/socket.h>
    #include <unistd.h>
    #include <stdbool.h>

    bool MSG_CMSG_SEALED_supported(void)
    {
        int sock, ret;
        socklen_t optlen = 0;

        sock = socket(AF_UNIX, SOCK_STREAM, 0);
        if (sock < 0) {
            /* handle error */
            /* ... */
        }

        ret = getsockopt(sock, SOL_SOCKET, SO_RIGHTS_SEALED_SUPPORTED,
                         NULL, &optlen);
        close(sock);

        return ret == 0;
    }

Related: https://github.com/fedora-selinux/selinux-policy/issues/3286
Related: https://github.com/fedora-selinux/selinux-policy/issues/3287
Signed-off-by: Ondrej Mosnáček <omosnacek@gmail.com>
---
 arch/alpha/include/uapi/asm/socket.h    |  2 +
 arch/mips/include/uapi/asm/socket.h     |  2 +
 arch/parisc/include/uapi/asm/socket.h   |  2 +
 arch/sparc/include/uapi/asm/socket.h    |  2 +
 include/linux/socket.h                  |  4 +-
 include/net/scm.h                       |  2 +-
 include/uapi/asm-generic/socket.h       |  2 +
 io_uring/net.c                          |  2 +-
 net/compat.c                            |  3 +-
 net/core/scm.c                          | 81 +++++++++++++++++++++----
 net/core/sock.c                         |  9 +++
 net/socket.c                            |  2 +-
 tools/include/uapi/asm-generic/socket.h |  2 +
 13 files changed, 97 insertions(+), 18 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 5d3524c26b2b..cd9fce1d9432 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -161,6 +161,8 @@
 
 #define SO_PEERPIDFD_THREAD    87
 
+#define SO_RIGHTS_SEALED_SUPPORTED	88
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 245a43f52fb1..393898479ce6 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -172,6 +172,8 @@
 
 #define SO_PEERPIDFD_THREAD    87
 
+#define SO_RIGHTS_SEALED_SUPPORTED	88
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index f23710e1c671..055b532ccc14 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -153,6 +153,8 @@
 
 #define SO_PEERPIDFD_THREAD	0x4055
 
+#define SO_RIGHTS_SEALED_SUPPORTED	0x4056
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index b35b25bdefc2..e152e2bdf42e 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -154,6 +154,8 @@
 
 #define SO_PEERPIDFD_THREAD      0x0060
 
+#define SO_RIGHTS_SEALED_SUPPORTED	0x0061
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/linux/socket.h b/include/linux/socket.h
index b17fdb7d38a7..90e4bc5d3f91 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -345,7 +345,9 @@ struct ucred {
 #define MSG_SOCK_DEVMEM 0x2000000	/* Receive devmem skbs as cmsg */
 #define MSG_ZEROCOPY	0x4000000	/* Use user data in kernel path */
 #define MSG_SPLICE_PAGES 0x8000000	/* Splice the pages from the iterator in sendmsg() */
-#define MSG_FASTOPEN	0x20000000	/* Send data in TCP SYN */
+#define MSG_CMSG_SEALED  0x10000000	/* Seal file descriptors received
+					   through SCM_RIGHTS */
+#define MSG_FASTOPEN     0x20000000	/* Send data in TCP SYN */
 #define MSG_CMSG_CLOEXEC 0x40000000	/* Set close_on_exec for file
 					   descriptor received through
 					   SCM_RIGHTS */
diff --git a/include/net/scm.h b/include/net/scm.h
index b68a143f42de..53b999868104 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -108,7 +108,7 @@ void scm_recv_unix(struct socket *sock, struct msghdr *msg,
 		   struct scm_cookie *scm, int flags);
 
 int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flags,
-		    bool notrunc);
+		    bool notrunc, bool sealed);
 
 #endif /* __LINUX_NET_SCM_H */
 
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 56fed7ab27ab..14bf06367ef1 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -156,6 +156,8 @@
 
 #define SO_PEERPIDFD_THREAD	87
 
+#define SO_RIGHTS_SEALED_SUPPORTED	88
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/io_uring/net.c b/io_uring/net.c
index eeab88e77fd8..b579d542b7e2 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -992,7 +992,7 @@ static int io_recvmsg_multishot(struct socket *sock, struct io_sr_msg *io,
 
 	if (kmsg->namelen)
 		kmsg->msg.msg_name = &hdr.addr;
-	kmsg->msg.msg_flags = flags & (MSG_CMSG_CLOEXEC|MSG_CMSG_COMPAT);
+	kmsg->msg.msg_flags = flags & (MSG_CMSG_CLOEXEC | MSG_CMSG_SEALED | MSG_CMSG_COMPAT);
 	kmsg->msg.msg_namelen = 0;
 
 	if (sock->file->f_flags & O_NONBLOCK)
diff --git a/net/compat.c b/net/compat.c
index 6bdf4a2c9077..29816b47f675 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -296,7 +296,8 @@ void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm, bool notr
 	int err = 0, i;
 
 	for (i = 0; i < fdmax; i++) {
-		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags, notrunc);
+		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags, notrunc,
+				      msg->msg_flags & MSG_CMSG_SEALED);
 		if (err < 0)
 			break;
 	}
diff --git a/net/core/scm.c b/net/core/scm.c
index ae38f3c1165c..08822b2a1f22 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/errqueue.h>
 #include <linux/io_uring.h>
+#include <linux/anon_inodes.h>
 
 #include <linux/uaccess.h>
 
@@ -66,7 +67,19 @@ static __inline__ int scm_check_creds(struct ucred *creds)
 	return -EPERM;
 }
 
-static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
+static int envelope_release(struct inode *inode, struct file *file)
+{
+	struct file *inner = file->private_data;
+
+	fput(inner);
+	return 0;
+}
+
+static const struct file_operations envelope_ops = {
+	.release = envelope_release,
+};
+
+static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp, bool sealed)
 {
 	int *fdp = (int*)CMSG_DATA(cmsg);
 	struct scm_fp_list *fpl = *fplp;
@@ -114,10 +127,29 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 
 		if (fd < 0 || !(file = fget_raw(fd)))
 			return -EBADF;
-		/* don't allow io_uring files */
-		if (io_is_uring_fops(file)) {
-			fput(file);
-			return -EINVAL;
+
+		if (sealed) {
+			/* Only allow sealed files */
+			if (file->f_op != &envelope_ops)
+				return -EINVAL;
+
+			file = (struct file *)file->private_data;
+
+			/*
+			 * No need to check for io_uring files here as the
+			 * underlying file had already successfully passed the
+			 * check when it was first sent.
+			 */
+		} else {
+			/* Don't allow sealed files */
+			if (file->f_op == &envelope_ops)
+				return -EINVAL;
+
+			/* don't allow io_uring files */
+			if (io_is_uring_fops(file)) {
+				fput(file);
+				return -EINVAL;
+			}
 		}
 		if (unix_get_socket(file))
 			fpl->count_unix++;
@@ -203,7 +235,8 @@ int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *p)
 		case SCM_RIGHTS:
 			if (!ops || ops->family != PF_UNIX)
 				goto error;
-			err=scm_fp_copy(cmsg, &p->fp);
+			err = scm_fp_copy(cmsg, &p->fp,
+					  msg->msg_flags & MSG_CMSG_SEALED);
 			if (err<0)
 				goto error;
 			break;
@@ -365,18 +398,37 @@ static int scm_max_fds(struct msghdr *msg)
 }
 
 int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flags,
-		    bool notrunc)
+		    bool notrunc, bool sealed)
 {
+	struct file *f_received;
 	int error;
 
 	if (!ufd)
 		return -EFAULT;
 
-	error = security_file_receive(f);
-	if (error)
-		return notrunc ? put_user(error, ufd) : error;
+	if (sealed) {
+		/*
+		 * Receive fd sealed in an "envelope" anonymous fd.
+		 * This will install a special file that can be unsealed
+		 * upon sending to another process, otherwise the underlying
+		 * file will not be accessible to this process, avoiding the
+		 * need to pass the LSM check below.
+		 */
+		f_received = anon_inode_getfile("[envelope]", &envelope_ops, f,
+						O_RDONLY);
+		if (IS_ERR(f_received))
+			return PTR_ERR(f_received);
+
+		get_file(f);
+	} else {
+		error = security_file_receive(f);
+		if (error)
+			return notrunc ? put_user(error, ufd) : error;
 
-	FD_PREPARE(fdf, flags, get_file(f));
+		f_received = get_file(f);
+	}
+
+	FD_PREPARE(fdf, flags, f_received);
 	if (fdf->fd < 0)
 		return fdf->fd;
 
@@ -384,7 +436,9 @@ int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flags,
 	if (error)
 		return error;
 
-	__receive_sock(fdf->file);
+	if (!sealed)
+		__receive_sock(fdf->file);
+
 	return fd_publish(fdf);
 }
 
@@ -407,7 +461,8 @@ void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool notrunc)
 	}
 
 	for (i = 0; i < fdmax; i++) {
-		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags, notrunc);
+		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags, notrunc,
+				      msg->msg_flags & MSG_CMSG_SEALED);
 		if (err < 0)
 			break;
 	}
diff --git a/net/core/sock.c b/net/core/sock.c
index e7405be8941f..68a447d8bf52 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1959,6 +1959,15 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		v.val = sk->sk_scm_rights;
 		break;
 
+	case SO_RIGHTS_SEALED_SUPPORTED:
+		if (!sk_is_unix(sk))
+			return -EOPNOTSUPP;
+
+		/* Just succeed without returning anything, signaling
+		 * support.
+		 */
+		break;
+
 	case SO_PEERCRED:
 	{
 		struct ucred peercred;
diff --git a/net/socket.c b/net/socket.c
index 2e3b5737c481..dbb3c7c6ff66 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2921,7 +2921,7 @@ static int ____sys_recvmsg(struct socket *sock, struct msghdr *msg_sys,
 
 	msg_sys->msg_name = &addr;
 	cmsg_ptr = (unsigned long)msg_sys->msg_control;
-	msg_sys->msg_flags = flags & (MSG_CMSG_CLOEXEC|MSG_CMSG_COMPAT);
+	msg_sys->msg_flags = flags & (MSG_CMSG_CLOEXEC | MSG_CMSG_SEALED | MSG_CMSG_COMPAT);
 
 	/* We assume all kernel code knows the size of sockaddr_storage */
 	msg_sys->msg_namelen = 0;
diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi/asm-generic/socket.h
index f333a0ac4ee4..fb9e98a7b370 100644
--- a/tools/include/uapi/asm-generic/socket.h
+++ b/tools/include/uapi/asm-generic/socket.h
@@ -147,6 +147,8 @@
 
 #define SO_PASSRIGHTS		83
 
+#define SO_RIGHTS_SEALED_SUPPORTED	88
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
-- 
2.54.0

