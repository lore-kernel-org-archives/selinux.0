Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7004211CAF;
	Sun, 30 Mar 2025 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743330853; cv=none; b=WZDfkXdqnvOKPCt2Bg02WtnoKsSni/3OP9KIyNgCyJ8Na/JhMyea1SSHstEut2witrHuIBvnvPYJcMI5kdSTKawwtFBtREeNyp5YqAdcF6BSqFbW5ODj/nU6lhhMmVKXH9SEbnFqFroAdK1o8fKE6Cx0bQ4XP5MQUANSemz+dD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743330853; c=relaxed/simple;
	bh=/Q3k5X2P4dwXQISDL+GBAhFuGgVmsV1ZMtOfAK/F7aQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TgRZBkOmZjSpeDkVqLjhSWWf14omoZA8930wiArWgH7YrUkrQyfVolEyK9Qw+Pe+JovJ/fpRsdudRgBYQ2VlEMeiyPILAS4lD17j0EqiqbtHcKTahPN9rw6jT1eb+wOi6uQBdHkxnocDChU0LloGUeEjDKxmM3g0FirVJ3RxFyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E8lzzqlY; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E8lzzqlY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=R/OU0
	V8NdoaJXsUCiLUPKOq7COZkSQ1mwl2m2pWiWKA=; b=E8lzzqlYztuKqKaYYo1Ah
	hYhIoXtLhNQz29V8PYzfAUHoNBB/whZyrvaBRRtfbQTWkWhyydN+PZn98GeuchsZ
	2a5gp4VOlIEBLUQDiHvkmj7OJrcuBtS65F5Mw+yAc+4LKCJj4lUsDAZ5OuKTWerl
	ndv4fwz3bC/YQ9wW0IJc+U=
Received: from WIN-S4QB3VCT165.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAXj9gEHulnSK1lCw--.60329S4;
	Sun, 30 Mar 2025 18:33:41 +0800 (CST)
From: Debin Zhu <mowenroot@163.com>
To: linux-security-module@vger.kernel.org
Cc: netdev@vger.kernel.org,
	selinux@vger.kernel.org,
	paul@paul-moore.com,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	Debin Zhu <mowenroot@163.com>,
	Bitao Ouyang <1985755126@qq.com>
Subject: [PATCH v2] netlabel: Fix NULL pointer exception caused by CALIPSO on IPv4 sockets
Date: Sun, 30 Mar 2025 18:33:39 +0800
Message-Id: <20250330103339.30794-1-mowenroot@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXj9gEHulnSK1lCw--.60329S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr1rtry3tF4kurW7Cry5twb_yoWrCryDpF
	yDKan8A348AFWUWws3XFWkCrWSkF4kKF17urWxAw4YkasrGr18Ja48KrWIya4ayFZrKrZ5
	Xr48ta1F9w4kC3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRebytUUUUU=
X-CM-SenderInfo: pprzv0hurr3qqrwthudrp/1tbiEwwelGfmvP2sogACsZ

Vulnerability Description:

	From Linux Kernel v4.0 to the latest version, 
	a type confusion issue exists in the `netlbl_conn_setattr` 
	function (`net/netlabel/netlabel_kapi.c`) within SELinux, 
	which can lead to a local DoS attack.

	When calling `netlbl_conn_setattr`, 
	`addr->sa_family` is used to determine the function behavior. 
	If `sk` is an IPv4 socket, 
	but the `connect` function is called with an IPv6 address, 
	the function `calipso_sock_setattr()` is triggered. 
	Inside this function, the following code is executed:

	sk_fullsock(__sk) ? inet_sk(__sk)->pinet6 : NULL;

	Since `sk` is an IPv4 socket, `pinet6` is `NULL`, 
	leading to a null pointer dereference and triggering a DoS attack.

<TASK>
calipso_sock_setattr+0x4f/0x80 net/netlabel/netlabel_calipso.c:557
netlbl_conn_setattr+0x12a/0x390 net/netlabel/netlabel_kapi.c:1152
selinux_netlbl_socket_connect_helper 
selinux_netlbl_socket_connect_locked+0xf5/0x1d0 
selinux_netlbl_socket_connect+0x22/0x40 security/selinux/netlabel.c:611
selinux_socket_connect+0x60/0x80 security/selinux/hooks.c:4923
security_socket_connect+0x71/0xb0 security/security.c:2260
__sys_connect_file+0xa4/0x190 net/socket.c:2007
__sys_connect+0x145/0x170 net/socket.c:2028
__do_sys_connect net/socket.c:2038 [inline]
__se_sys_connect net/socket.c:2035 [inline]
__x64_sys_connect+0x6e/0xb0 net/socket.c:2035
do_syscall_x64 arch/x86/entry/common.c:51 

Affected Versions:

- Linux 4.0 - Latest Linux Kernel version

Reproduction Steps:

	Use the `netlabelctl` tool and 
	run the following commands to trigger the vulnerability:

	netlabelctl map del default
	netlabelctl cipsov4 add pass doi:8 tags:1
	netlabelctl map add default address:192.168.1.0/24 protocol:cipsov4,8
	netlabelctl calipso add pass doi:7
	netlabelctl map add default address:2001:db8::1/32 protocol:calipso,7

Then, execute the following PoC code:

	int sockfd = socket(AF_INET, SOCK_STREAM, 0);

	struct sockaddr_in6 server_addr = {0};
	server_addr.sin6_family = AF_INET6;     
	server_addr.sin6_port = htons(8080);    

	const char *ipv6_str = "2001:db8::1";    
	inet_pton(AF_INET6, ipv6_str, &server_addr.sin6_addr);

	connect(sockfd, (struct sockaddr*)&server_addr, sizeof(server_addr));

Suggested Fix:

	When using an IPv4 address on an IPv6 UDP/datagram socket, 
	the operation will invoke the IPv4 datagram code through 
	the IPv6 datagram code and execute successfully. 
	It is necessary to check whether the `pinet6` pointer 
	returned by `inet6_sk()` is NULL; otherwise, 
	unexpected issues may occur.

Signed-off-by: Debin Zhu <mowenroot@163.com>
Signed-off-by: Bitao Ouyang <1985755126@qq.com>
---
 net/ipv6/calipso.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index dbcea9fee..a8a8736df 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -1072,8 +1072,13 @@ static int calipso_sock_getattr(struct sock *sk,
 	struct ipv6_opt_hdr *hop;
 	int opt_len, len, ret_val = -ENOMSG, offset;
 	unsigned char *opt;
-	struct ipv6_txoptions *txopts = txopt_get(inet6_sk(sk));
+	struct ipv6_pinfo *pinfo = inet6_sk(sk);
+	struct ipv6_txoptions *txopts;
 
+	if (!pinfo)
+		return -EAFNOSUPPORT;
+
+	txopts = txopt_get(pinfo);
 	if (!txopts || !txopts->hopopt)
 		goto done;
 
@@ -1125,8 +1130,13 @@ static int calipso_sock_setattr(struct sock *sk,
 {
 	int ret_val;
 	struct ipv6_opt_hdr *old, *new;
-	struct ipv6_txoptions *txopts = txopt_get(inet6_sk(sk));
-
+	struct ipv6_pinfo *pinfo = inet6_sk(sk);
+	struct ipv6_txoptions *txopts;
+
+	if (!pinfo)
+		return -EAFNOSUPPORT;
+
+	txopts = txopt_get(pinfo);
 	old = NULL;
 	if (txopts)
 		old = txopts->hopopt;
@@ -1153,8 +1163,13 @@ static int calipso_sock_setattr(struct sock *sk,
 static void calipso_sock_delattr(struct sock *sk)
 {
 	struct ipv6_opt_hdr *new_hop;
-	struct ipv6_txoptions *txopts = txopt_get(inet6_sk(sk));
+	struct ipv6_pinfo *pinfo = inet6_sk(sk);
+	struct ipv6_txoptions *txopts;
 
+	if (!pinfo)
+		return;
+
+	txopts = txopt_get(pinfo);
 	if (!txopts || !txopts->hopopt)
 		goto done;
 
-- 
mowenroot@163.com

