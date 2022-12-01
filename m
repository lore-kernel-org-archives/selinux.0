Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A329C43217
	for <selinux@archiver.kernel.org>; Thu,  1 Dec 2022 18:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiLAS1m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Dec 2022 13:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiLAS1l (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Dec 2022 13:27:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39561AC6D2
        for <selinux@vger.kernel.org>; Thu,  1 Dec 2022 10:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669919207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ppptAZ3b838LTpadMzenP+j7olN2ZYki7pqYE+jzTAo=;
        b=IaZbNBocuwh8aqilS6dgXooNT/CX6ct7CQOPWL1bgDmT6zM6fNkr9DhfmtXcN26UFPLYeO
        fwXVJvwrsLZh7VlTA9uhI5VawofmvOoNuThYdYZfJr8T1lRWkvaT87iHFxZiMz/qBe8kjo
        /SOD+T8bDzYWJFX7jUqQsUMJgcSt4YY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-303-R14wT_B3NhuI0ev3HVoGww-1; Thu, 01 Dec 2022 13:26:46 -0500
X-MC-Unique: R14wT_B3NhuI0ev3HVoGww-1
Received: by mail-wr1-f72.google.com with SMTP id q13-20020adfab0d000000b002420132f543so631238wrc.19
        for <selinux@vger.kernel.org>; Thu, 01 Dec 2022 10:26:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ppptAZ3b838LTpadMzenP+j7olN2ZYki7pqYE+jzTAo=;
        b=8C8mbWLoLvIO8sOMMGaOCHf1vWVu8hyTmld9wT0veXxImMURBIg3PNWprIN83VOX0h
         niWm9lEcsbzDgkCkgNCBl/xdf3l0B9yLIPMQN0lGGREmASOrlFL6bnZBji2MyBaCnyH3
         fDi3WJhD6uiquVGvBR5rXGuKzZZxl+rKZun6pkFtCulQtH/rHddFINF5XjSrVelq7omk
         5vLS2DJV2lkQAXg9wPcZixew1N9iGSDdsfZRQUoaVa5Z9s2GM6ocFXWYtrHfv6d7RiiN
         zAOpPw3+nKGGyByAgBFsdwUjm/6NKoqckw4plLbRohOLw+x51R7bVGYw9yfd1G+ahqGP
         N8MQ==
X-Gm-Message-State: ANoB5pmQNZD7L2yd/rPXAMNq4BGwp/XUEGJVMpMrHmfVC+Xrtihw/gpH
        eSc2P+pAVVNL6HMrIRLQ8Wnj/isWI9C2l7J8lnDfzSqsiFDxaur92OQhvIvuKAB+1ku0IPoED+/
        h/UYB2kGRxlM0OVlEuQ==
X-Received: by 2002:a5d:6947:0:b0:242:17a5:ee80 with SMTP id r7-20020a5d6947000000b0024217a5ee80mr13020195wrw.628.1669919205162;
        Thu, 01 Dec 2022 10:26:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6nM1aOjMkTeG2VfxDKeV6gyo/kGiPK3NXd90HP+uprOEYiMCq4KOcqj2rLdX/FRRrLtylbIQ==
X-Received: by 2002:a5d:6947:0:b0:242:17a5:ee80 with SMTP id r7-20020a5d6947000000b0024217a5ee80mr13020179wrw.628.1669919204783;
        Thu, 01 Dec 2022 10:26:44 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id p12-20020adfce0c000000b002366dd0e030sm5164132wrn.68.2022.12.01.10.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 10:26:44 -0800 (PST)
Message-ID: <108a1c80eed41516f85ebb264d0f46f95e86f754.camel@redhat.com>
Subject: Re: Broken SELinux/LSM labeling with MPTCP and accept(2)
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, mptcp@lists.linux.dev
Cc:     network dev <netdev@vger.kernel.org>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Paul Moore <paul@paul-moore.com>
Date:   Thu, 01 Dec 2022 19:26:43 +0100
In-Reply-To: <CAFqZXNs2LF-OoQBUiiSEyranJUXkPLcCfBkMkwFeM6qEwMKCTw@mail.gmail.com>
References: <CAFqZXNs2LF-OoQBUiiSEyranJUXkPLcCfBkMkwFeM6qEwMKCTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

On Thu, 2022-12-01 at 14:42 +0100, Ondrej Mosnacek wrote:
> As discovered by our QE, there is a problem with how the
> (userspace-facing) sockets returned by accept(2) are labeled when
> using MPTCP. Currently they always end up with the label representing
> the kernel (typically system_u:system_r:kernel_t:s0), white they
> should inherit the context from the parent socket (the one that is
> passed to accept(2)).
> 
> A minimal reproducer on a Fedora/CentOS/RHEL system:
> 
> # Install dependencies
> dnf install -y mptcpd nginx curl
> # Disable rules that silence some SELinux denials
> semodule -DB
> # Set up a dummy file to be served by nginx
> echo test > /usr/share/nginx/html/testfile
> chmod +r /usr/share/nginx/html/testfile
> # Set up nginx to use MPTCP
> sysctl -w net.mptcp.enabled=1
> systemctl stop nginx
> mptcpize enable nginx
> systemctl start nginx
> # This will fail (no reply from server)
> mptcpize run curl -k -o /dev/null http://127.0.0.1/testfile
> # This will show the SELinux denial that caused the failure
> ausearch -i -m avc | grep httpd
> 
> It is also possible to trigger the issue by running the
> selinux-testsuite [1] under `mptcpize run` (it will fail on the
> inet_socket test in multiple places).
> 
> Based on what I could infer from the net & mptcp code, this is roughly
> how it happens (may be inaccurate or incorrect - the maze of the
> networking stack is not easy to navigate for me):
> 1. When the server starts, the main mptcp socket is created:
>    socket(2) -> ... -> socket_create() -> inet_create() ->
> mptcp_init_sock() -> __mptcp_socket_create()
> 2. __mptcp_socket_create() calls mptcp_subflow_create_socket(), which
> creates another "kern" socket, which represents the initial(?)
> subflow.
> 3. This subflow socket goes through security_socket_post_create() ->
> selinux_socket_post_create(), which gives it a kernel label based on
> kern == 1, which indicates that it's a kernel-internal socket.
> 4. The main socket goes through its own selinux_socket_post_create(),
> which gives it the label based on the current task.
> 5. Later, when the client connection is accepted via accept(2) on the
> main socket, an underlying accept operation is performed on the
> subflow socket, which is then returned directly as the result of the
> accept(2) syscall.
> 6. Since this socket is cloned from the subflow socket, it inherits
> the kernel label from the original subflow socket (via
> selinux_inet_conn_request() and selinux_inet_csk_clone()).
> selinux_sock_graft() then also copies the label onto the inode
> representing the socket.
> 7. When nginx later calls writev(2) on the new socket,
> selinux_file_permission() uses the inode label as the target in a
> tcp_socket::write permission check. This is denied, as in the Fedora
> policy httpd_t isn't allowed to write to kernel_t TCP sockets.
> 
> Side note: There is currently an odd conditional in sock_has_perm() in
> security/selinux/hooks.c that skips SELinux permission checking for
> sockets that have the kernel label, so native socket operations (such
> as recv(2), send(2), recvmsg(2), ...) will not uncover this problem,
> only generic file operations such as read(2), write(2), writev(2),
> etc. I believe that check shouldn't be there, but that's for another
> discussion...

That comes from:

commit e2943dca2d5b67e9578111986495483fe720d58b
Author: James Morris <jmorris@redhat.com>
Date:   Sat May 8 01:00:33 2004 -0700

    [NET]: Add sock_create_kern()

"""
    This addresses a class of potential issues in SELinux where, for example,
    a TCP NFS session times out, then the kernel re-establishes an RPC
    connection upon further user activity.  We do not want such kernel
    created sockets to be labeled with user security contexts.
"""

> So now the big question is: How to fix this? I can think of several
> possible solutions, but neither of them seems to be the obvious
> correct one:
> 1. Wrap the socket cloned from the subflow socket in another socket
> (similar to how the main socket + subflow(s) are handled), which would
> be cloned from the non-kern outer socket that has the right label.
> This could have the disadvantage of adding unnecessary overhead, but
> would probably be simpler to do.

I would avoid that option: we already have a suboptimal amount of
indirection.

> 2. Somehow ensure that the cloned socket gets the label from the main
> socket instead of the subflow socket. This would probably require
> adding a new LSM hook and I'm not sure at all what would be the best
> way to implement this.
> 3. Somehow communicate the subflow socket <-> main socket relationship
> to the LSM layer so that it can switch to use the label of the main
> socket when handling an operation on a subflow socket (thus copying
> the label correctly on accept(2)). Not a great solution, as it
> requires each LSM that labels sockets to duplicate the indirection
> logic.
> 4. Do not create the subflow sockets as "kern". (Not sure if that
> would be desirable.)

No, we need subflow being kernel sockets. Lockdep will bail otherwise,
and the would be the tip of the iceberg.

> 5. Stop labeling kern sockets with the kernel's label on the SELinux
> side and just label them based on the current task as usual. (This
> would probably cause other issues, but maybe not...)
> 
> Any ideas, suggestions, or patches welcome!

I think something alike the following could work - not even tested,
with comments on bold assumptions.

I'll try to do some testing later.

---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 99f5e51d5ca4..6cad50c6fd24 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -102,6 +102,20 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	if (err)
 		return err;
 
+	/* The first subflow can later be indirectly exposed to security
+	 * relevant syscall alike accept() and bind(), and at this point
+	 * carries a 'kern' related security context.
+	 * Reset the security context to the relevant user-space one.
+	 * Note that the following assumes security_socket_post_create()
+	 * being idempotent
+	 */
+	err = security_socket_post_create(ssock, sk->sk_family, SOCK_STREAM,
+					  IPPROTO_TCP, 0);
+	if (err) {
+		sock_release(ssock);
+		return err;
+	}
+
 	msk->first = ssock->sk;
 	msk->subflow = ssock;
 	subflow = mptcp_subflow_ctx(ssock->sk);

	

