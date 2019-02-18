Return-Path: <SRS0=DZpq=QZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D65C43381
	for <selinux@archiver.kernel.org>; Mon, 18 Feb 2019 02:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D7B218C3
	for <selinux@archiver.kernel.org>; Mon, 18 Feb 2019 02:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="qRjpkvn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfBRC4t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 17 Feb 2019 21:56:49 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45801 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbfBRC4t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 17 Feb 2019 21:56:49 -0500
Received: by mail-lf1-f67.google.com with SMTP id h10so10917038lfc.12
        for <selinux@vger.kernel.org>; Sun, 17 Feb 2019 18:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uETNZHaZct6KPQZY6rQXjTnqsFDl1hCC79l6xEqnGFg=;
        b=qRjpkvn3C7Js9mct2Zt1+K86geQzwFNbs2nSBjWrNK/8rGxlY6K6GxtfaX1ZCHfWg9
         9OqqCRb4NNDKsMctYDhskNWK6DHNo1uVAuv7rP280twpS2COfASJwu3pG1oMwgV9hbfq
         dwCiCMjTLTqnFyXtJjITC//95M+bYvuwFpejnsHf28KwuCSqjMg1EyfEm6e/+53IryWc
         wC14WQdgHnuSviBiemiEeErJQp7nb/bfXwdIuRTnGceg3kgFHpoZ4n9wqx767y8j7HJb
         hgVMUiGU+PRc16IlLC72pKV9b86QwmqvwfsKSHzzPVhuoT1vqtvaS4YAFRwoSNtzEddU
         7hwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uETNZHaZct6KPQZY6rQXjTnqsFDl1hCC79l6xEqnGFg=;
        b=tB105jhpghRyjq22arOqPsR7tu4K7icvDAi+VvpWtomIiIPQGdBecOb4sl+cNCytxg
         DjVSs96LBYyQ2Kg8K6x29djed+hDIcqfcQQrE/Rg2M4IT8xBpBYQMLZbMzNkwfPfJ3Iy
         7cE/NzA92yef7BY+KfnO+gQFtp9z/AyO2afOvnq06nJocD2vKV9m7Wy+FsA7LeRedgi2
         wJCd5MljhLqVMGgovI6vb0D0YXHAm4fJNgXo7RbvCI4ZaU+nQsuJuAl3LxXdsWxd+QGY
         NVR9PY61vMATelAWZcS5GIkc4x7czLf3PYb8Mm8gyJajDIBklokUg8aytCfWUboT6n3d
         zjuQ==
X-Gm-Message-State: AHQUAuZj+BIZvpaOa9Z/6Frjw2U1GPVnDdOvjw+pBn8nrL9As2Yz3hdP
        nDL4JgU05cWc19ncvcUKJacgmK+Y/DD2O6t6TNfkZjM=
X-Google-Smtp-Source: AHgI3IbU3Byy4CXGb5kmKFTQJRUcFyWWy4o/jyh7oD0KFfY7HXlMu4v/yxL4SiXVe8M2JW+US5/yOJ6ysyOPhXC2x4A=
X-Received: by 2002:a19:384c:: with SMTP id d12mr11898569lfj.105.1550458604967;
 Sun, 17 Feb 2019 18:56:44 -0800 (PST)
MIME-Version: 1.0
References: <20190217220836.GA41179@beast>
In-Reply-To: <20190217220836.GA41179@beast>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 17 Feb 2019 21:56:33 -0500
Message-ID: <CAHC9VhSdW+eLx3RNwMZ-Wn7BUv9ayPubZLxSZzSj_ab-k84ZGQ@mail.gmail.com>
Subject: Re: [PATCH] doc: sctp: Merge and clean up rst files
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Richard Haines <richard_c_haines@btinternet.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Feb 17, 2019 at 5:08 PM Kees Cook <keescook@chromium.org> wrote:
> The SCTP sections were ending up at the top-level table of contents
> under the security section when they should have be sections with the
> SCTP chapters. In addition to correcting the section and subsection
> headings, this merges the SCTP documents into a single file to organize
> the chapters more clearly, internally linkifies them, and adds the
> missing SPDX header.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  .../security/{LSM-sctp.rst => SCTP.rst}       | 180 +++++++++++++++++-
>  Documentation/security/SELinux-sctp.rst       | 158 ---------------
>  Documentation/security/index.rst              |   3 +-
>  security/selinux/hooks.c                      |   2 +-
>  4 files changed, 176 insertions(+), 167 deletions(-)
>  rename Documentation/security/{LSM-sctp.rst => SCTP.rst} (52%)
>  delete mode 100644 Documentation/security/SELinux-sctp.rst

[NOTE: adding the SELinux list to the CC line]

Looks good to me, thanks for the fixes/cleanup.

Are you planning this to go via the doc tree, or would you like me to
grab it for the SELinux tree?  Either way is fine with me.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/Documentation/security/LSM-sctp.rst b/Documentation/security/SCTP.rst
> similarity index 52%
> rename from Documentation/security/LSM-sctp.rst
> rename to Documentation/security/SCTP.rst
> index 6e5a3925a860..d903eb97fcf3 100644
> --- a/Documentation/security/LSM-sctp.rst
> +++ b/Documentation/security/SCTP.rst
> @@ -1,6 +1,15 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====
> +SCTP
> +====
> +
>  SCTP LSM Support
>  ================
>
> +Security Hooks
> +--------------
> +
>  For security module support, three SCTP specific hooks have been implemented::
>
>      security_sctp_assoc_request()
> @@ -12,11 +21,11 @@ Also the following security hook has been utilised::
>      security_inet_conn_established()
>
>  The usage of these hooks are described below with the SELinux implementation
> -described in ``Documentation/security/SELinux-sctp.rst``
> +described in the `SCTP SELinux Support`_ chapter.
>
>
>  security_sctp_assoc_request()
> ------------------------------
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  Passes the ``@ep`` and ``@chunk->skb`` of the association INIT packet to the
>  security module. Returns 0 on success, error on failure.
>  ::
> @@ -26,7 +35,7 @@ security module. Returns 0 on success, error on failure.
>
>
>  security_sctp_bind_connect()
> ------------------------------
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  Passes one or more ipv4/ipv6 addresses to the security module for validation
>  based on the ``@optname`` that will result in either a bind or connect
>  service as shown in the permission check tables below.
> @@ -102,7 +111,7 @@ ASCONF chunk when the corresponding ``@optname``'s are present::
>
>
>  security_sctp_sk_clone()
> --------------------------
> +~~~~~~~~~~~~~~~~~~~~~~~~
>  Called whenever a new socket is created by **accept**\(2)
>  (i.e. a TCP style socket) or when a socket is 'peeled off' e.g userspace
>  calls **sctp_peeloff**\(3).
> @@ -114,7 +123,7 @@ calls **sctp_peeloff**\(3).
>
>
>  security_inet_conn_established()
> ----------------------------------
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  Called when a COOKIE ACK is received::
>
>      @sk  - pointer to sock structure.
> @@ -122,7 +131,8 @@ Called when a COOKIE ACK is received::
>
>
>  Security Hooks used for Association Establishment
> -=================================================
> +-------------------------------------------------
> +
>  The following diagram shows the use of ``security_sctp_bind_connect()``,
>  ``security_sctp_assoc_request()``, ``security_inet_conn_established()`` when
>  establishing an association.
> @@ -173,3 +183,161 @@ establishing an association.
>      ------------------------------------------------------------------
>
>
> +SCTP SELinux Support
> +====================
> +
> +Security Hooks
> +--------------
> +
> +The `SCTP LSM Support`_ chapter above describes the following SCTP security
> +hooks with the SELinux specifics expanded below::
> +
> +    security_sctp_assoc_request()
> +    security_sctp_bind_connect()
> +    security_sctp_sk_clone()
> +    security_inet_conn_established()
> +
> +
> +security_sctp_assoc_request()
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Passes the ``@ep`` and ``@chunk->skb`` of the association INIT packet to the
> +security module. Returns 0 on success, error on failure.
> +::
> +
> +    @ep - pointer to sctp endpoint structure.
> +    @skb - pointer to skbuff of association packet.
> +
> +The security module performs the following operations:
> +     IF this is the first association on ``@ep->base.sk``, then set the peer
> +     sid to that in ``@skb``. This will ensure there is only one peer sid
> +     assigned to ``@ep->base.sk`` that may support multiple associations.
> +
> +     ELSE validate the ``@ep->base.sk peer_sid`` against the ``@skb peer sid``
> +     to determine whether the association should be allowed or denied.
> +
> +     Set the sctp ``@ep sid`` to socket's sid (from ``ep->base.sk``) with
> +     MLS portion taken from ``@skb peer sid``. This will be used by SCTP
> +     TCP style sockets and peeled off connections as they cause a new socket
> +     to be generated.
> +
> +     If IP security options are configured (CIPSO/CALIPSO), then the ip
> +     options are set on the socket.
> +
> +
> +security_sctp_bind_connect()
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Checks permissions required for ipv4/ipv6 addresses based on the ``@optname``
> +as follows::
> +
> +  ------------------------------------------------------------------
> +  |                   BIND Permission Checks                       |
> +  |       @optname             |         @address contains         |
> +  |----------------------------|-----------------------------------|
> +  | SCTP_SOCKOPT_BINDX_ADD     | One or more ipv4 / ipv6 addresses |
> +  | SCTP_PRIMARY_ADDR          | Single ipv4 or ipv6 address       |
> +  | SCTP_SET_PEER_PRIMARY_ADDR | Single ipv4 or ipv6 address       |
> +  ------------------------------------------------------------------
> +
> +  ------------------------------------------------------------------
> +  |                 CONNECT Permission Checks                      |
> +  |       @optname             |         @address contains         |
> +  |----------------------------|-----------------------------------|
> +  | SCTP_SOCKOPT_CONNECTX      | One or more ipv4 / ipv6 addresses |
> +  | SCTP_PARAM_ADD_IP          | One or more ipv4 / ipv6 addresses |
> +  | SCTP_SENDMSG_CONNECT       | Single ipv4 or ipv6 address       |
> +  | SCTP_PARAM_SET_PRIMARY     | Single ipv4 or ipv6 address       |
> +  ------------------------------------------------------------------
> +
> +
> +`SCTP LSM Support`_ gives a summary of the ``@optname``
> +entries and also describes ASCONF chunk processing when Dynamic Address
> +Reconfiguration is enabled.
> +
> +
> +security_sctp_sk_clone()
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +Called whenever a new socket is created by **accept**\(2) (i.e. a TCP style
> +socket) or when a socket is 'peeled off' e.g userspace calls
> +**sctp_peeloff**\(3). ``security_sctp_sk_clone()`` will set the new
> +sockets sid and peer sid to that contained in the ``@ep sid`` and
> +``@ep peer sid`` respectively.
> +::
> +
> +    @ep - pointer to current sctp endpoint structure.
> +    @sk - pointer to current sock structure.
> +    @sk - pointer to new sock structure.
> +
> +
> +security_inet_conn_established()
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Called when a COOKIE ACK is received where it sets the connection's peer sid
> +to that in ``@skb``::
> +
> +    @sk  - pointer to sock structure.
> +    @skb - pointer to skbuff of the COOKIE ACK packet.
> +
> +
> +Policy Statements
> +-----------------
> +The following class and permissions to support SCTP are available within the
> +kernel::
> +
> +    class sctp_socket inherits socket { node_bind }
> +
> +whenever the following policy capability is enabled::
> +
> +    policycap extended_socket_class;
> +
> +SELinux SCTP support adds the ``name_connect`` permission for connecting
> +to a specific port type and the ``association`` permission that is explained
> +in the section below.
> +
> +If userspace tools have been updated, SCTP will support the ``portcon``
> +statement as shown in the following example::
> +
> +    portcon sctp 1024-1036 system_u:object_r:sctp_ports_t:s0
> +
> +
> +SCTP Peer Labeling
> +------------------
> +An SCTP socket will only have one peer label assigned to it. This will be
> +assigned during the establishment of the first association. Any further
> +associations on this socket will have their packet peer label compared to
> +the sockets peer label, and only if they are different will the
> +``association`` permission be validated. This is validated by checking the
> +socket peer sid against the received packets peer sid to determine whether
> +the association should be allowed or denied.
> +
> +NOTES:
> +   1) If peer labeling is not enabled, then the peer context will always be
> +      ``SECINITSID_UNLABELED`` (``unlabeled_t`` in Reference Policy).
> +
> +   2) As SCTP can support more than one transport address per endpoint
> +      (multi-homing) on a single socket, it is possible to configure policy
> +      and NetLabel to provide different peer labels for each of these. As the
> +      socket peer label is determined by the first associations transport
> +      address, it is recommended that all peer labels are consistent.
> +
> +   3) **getpeercon**\(3) may be used by userspace to retrieve the sockets peer
> +      context.
> +
> +   4) While not SCTP specific, be aware when using NetLabel that if a label
> +      is assigned to a specific interface, and that interface 'goes down',
> +      then the NetLabel service will remove the entry. Therefore ensure that
> +      the network startup scripts call **netlabelctl**\(8) to set the required
> +      label (see **netlabel-config**\(8) helper script for details).
> +
> +   5) The NetLabel SCTP peer labeling rules apply as discussed in the following
> +      set of posts tagged "netlabel" at: http://www.paul-moore.com/blog/t.
> +
> +   6) CIPSO is only supported for IPv4 addressing: ``socket(AF_INET, ...)``
> +      CALIPSO is only supported for IPv6 addressing: ``socket(AF_INET6, ...)``
> +
> +      Note the following when testing CIPSO/CALIPSO:
> +         a) CIPSO will send an ICMP packet if an SCTP packet cannot be
> +            delivered because of an invalid label.
> +         b) CALIPSO does not send an ICMP packet, just silently discards it.
> +
> +   7) IPSEC is not supported as RFC 3554 - sctp/ipsec support has not been
> +      implemented in userspace (**racoon**\(8) or **ipsec_pluto**\(8)),
> +      although the kernel supports SCTP/IPSEC.
> diff --git a/Documentation/security/SELinux-sctp.rst b/Documentation/security/SELinux-sctp.rst
> deleted file mode 100644
> index a332cb1c5334..000000000000
> --- a/Documentation/security/SELinux-sctp.rst
> +++ /dev/null
> @@ -1,158 +0,0 @@
> -SCTP SELinux Support
> -=====================
> -
> -Security Hooks
> -===============
> -
> -``Documentation/security/LSM-sctp.rst`` describes the following SCTP security
> -hooks with the SELinux specifics expanded below::
> -
> -    security_sctp_assoc_request()
> -    security_sctp_bind_connect()
> -    security_sctp_sk_clone()
> -    security_inet_conn_established()
> -
> -
> -security_sctp_assoc_request()
> ------------------------------
> -Passes the ``@ep`` and ``@chunk->skb`` of the association INIT packet to the
> -security module. Returns 0 on success, error on failure.
> -::
> -
> -    @ep - pointer to sctp endpoint structure.
> -    @skb - pointer to skbuff of association packet.
> -
> -The security module performs the following operations:
> -     IF this is the first association on ``@ep->base.sk``, then set the peer
> -     sid to that in ``@skb``. This will ensure there is only one peer sid
> -     assigned to ``@ep->base.sk`` that may support multiple associations.
> -
> -     ELSE validate the ``@ep->base.sk peer_sid`` against the ``@skb peer sid``
> -     to determine whether the association should be allowed or denied.
> -
> -     Set the sctp ``@ep sid`` to socket's sid (from ``ep->base.sk``) with
> -     MLS portion taken from ``@skb peer sid``. This will be used by SCTP
> -     TCP style sockets and peeled off connections as they cause a new socket
> -     to be generated.
> -
> -     If IP security options are configured (CIPSO/CALIPSO), then the ip
> -     options are set on the socket.
> -
> -
> -security_sctp_bind_connect()
> ------------------------------
> -Checks permissions required for ipv4/ipv6 addresses based on the ``@optname``
> -as follows::
> -
> -  ------------------------------------------------------------------
> -  |                   BIND Permission Checks                       |
> -  |       @optname             |         @address contains         |
> -  |----------------------------|-----------------------------------|
> -  | SCTP_SOCKOPT_BINDX_ADD     | One or more ipv4 / ipv6 addresses |
> -  | SCTP_PRIMARY_ADDR          | Single ipv4 or ipv6 address       |
> -  | SCTP_SET_PEER_PRIMARY_ADDR | Single ipv4 or ipv6 address       |
> -  ------------------------------------------------------------------
> -
> -  ------------------------------------------------------------------
> -  |                 CONNECT Permission Checks                      |
> -  |       @optname             |         @address contains         |
> -  |----------------------------|-----------------------------------|
> -  | SCTP_SOCKOPT_CONNECTX      | One or more ipv4 / ipv6 addresses |
> -  | SCTP_PARAM_ADD_IP          | One or more ipv4 / ipv6 addresses |
> -  | SCTP_SENDMSG_CONNECT       | Single ipv4 or ipv6 address       |
> -  | SCTP_PARAM_SET_PRIMARY     | Single ipv4 or ipv6 address       |
> -  ------------------------------------------------------------------
> -
> -
> -``Documentation/security/LSM-sctp.rst`` gives a summary of the ``@optname``
> -entries and also describes ASCONF chunk processing when Dynamic Address
> -Reconfiguration is enabled.
> -
> -
> -security_sctp_sk_clone()
> --------------------------
> -Called whenever a new socket is created by **accept**\(2) (i.e. a TCP style
> -socket) or when a socket is 'peeled off' e.g userspace calls
> -**sctp_peeloff**\(3). ``security_sctp_sk_clone()`` will set the new
> -sockets sid and peer sid to that contained in the ``@ep sid`` and
> -``@ep peer sid`` respectively.
> -::
> -
> -    @ep - pointer to current sctp endpoint structure.
> -    @sk - pointer to current sock structure.
> -    @sk - pointer to new sock structure.
> -
> -
> -security_inet_conn_established()
> ----------------------------------
> -Called when a COOKIE ACK is received where it sets the connection's peer sid
> -to that in ``@skb``::
> -
> -    @sk  - pointer to sock structure.
> -    @skb - pointer to skbuff of the COOKIE ACK packet.
> -
> -
> -Policy Statements
> -==================
> -The following class and permissions to support SCTP are available within the
> -kernel::
> -
> -    class sctp_socket inherits socket { node_bind }
> -
> -whenever the following policy capability is enabled::
> -
> -    policycap extended_socket_class;
> -
> -SELinux SCTP support adds the ``name_connect`` permission for connecting
> -to a specific port type and the ``association`` permission that is explained
> -in the section below.
> -
> -If userspace tools have been updated, SCTP will support the ``portcon``
> -statement as shown in the following example::
> -
> -    portcon sctp 1024-1036 system_u:object_r:sctp_ports_t:s0
> -
> -
> -SCTP Peer Labeling
> -===================
> -An SCTP socket will only have one peer label assigned to it. This will be
> -assigned during the establishment of the first association. Any further
> -associations on this socket will have their packet peer label compared to
> -the sockets peer label, and only if they are different will the
> -``association`` permission be validated. This is validated by checking the
> -socket peer sid against the received packets peer sid to determine whether
> -the association should be allowed or denied.
> -
> -NOTES:
> -   1) If peer labeling is not enabled, then the peer context will always be
> -      ``SECINITSID_UNLABELED`` (``unlabeled_t`` in Reference Policy).
> -
> -   2) As SCTP can support more than one transport address per endpoint
> -      (multi-homing) on a single socket, it is possible to configure policy
> -      and NetLabel to provide different peer labels for each of these. As the
> -      socket peer label is determined by the first associations transport
> -      address, it is recommended that all peer labels are consistent.
> -
> -   3) **getpeercon**\(3) may be used by userspace to retrieve the sockets peer
> -      context.
> -
> -   4) While not SCTP specific, be aware when using NetLabel that if a label
> -      is assigned to a specific interface, and that interface 'goes down',
> -      then the NetLabel service will remove the entry. Therefore ensure that
> -      the network startup scripts call **netlabelctl**\(8) to set the required
> -      label (see **netlabel-config**\(8) helper script for details).
> -
> -   5) The NetLabel SCTP peer labeling rules apply as discussed in the following
> -      set of posts tagged "netlabel" at: http://www.paul-moore.com/blog/t.
> -
> -   6) CIPSO is only supported for IPv4 addressing: ``socket(AF_INET, ...)``
> -      CALIPSO is only supported for IPv6 addressing: ``socket(AF_INET6, ...)``
> -
> -      Note the following when testing CIPSO/CALIPSO:
> -         a) CIPSO will send an ICMP packet if an SCTP packet cannot be
> -            delivered because of an invalid label.
> -         b) CALIPSO does not send an ICMP packet, just silently discards it.
> -
> -   7) IPSEC is not supported as RFC 3554 - sctp/ipsec support has not been
> -      implemented in userspace (**racoon**\(8) or **ipsec_pluto**\(8)),
> -      although the kernel supports SCTP/IPSEC.
> diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
> index 85492bfca530..aad6d92ffe31 100644
> --- a/Documentation/security/index.rst
> +++ b/Documentation/security/index.rst
> @@ -9,7 +9,6 @@ Security Documentation
>     IMA-templates
>     keys/index
>     LSM
> -   LSM-sctp
> -   SELinux-sctp
> +   SCTP
>     self-protection
>     tpm/index
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f0e36c3492ba..bb4a8e088f7e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4531,7 +4531,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
>  }
>
>  /* This supports connect(2) and SCTP connect services such as sctp_connectx(3)
> - * and sctp_sendmsg(3) as described in Documentation/security/LSM-sctp.rst
> + * and sctp_sendmsg(3) as described in Documentation/security/SCTP.rst
>   */
>  static int selinux_socket_connect_helper(struct socket *sock,
>                                          struct sockaddr *address, int addrlen)
> --
> 2.17.1
>
>
> --
> Kees Cook



-- 
paul moore
www.paul-moore.com
