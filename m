Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA16104
	for <selinux@tycho.nsa.gov>; Tue, 20 Aug 2002 08:29:45 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA25815
	for <selinux@tycho.nsa.gov>; Tue, 20 Aug 2002 12:28:07 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA25811 for <selinux@tycho.nsa.gov>; Tue, 20 Aug 2002 12:28:06 GMT
Date: Tue, 20 Aug 2002 08:22:04 -0400 (EDT)
From: Wayne Salamon <wsalamon@tislabs.com>
To: Stephen Smalley <sds@tislabs.com>
cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: tcp_socket messages
In-Reply-To: <Pine.GSO.4.33.0208200652170.13775-100000@raven>
Message-ID: <Pine.LNX.4.33.0208200812030.20876-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 20 Aug 2002, Stephen Smalley wrote:

>
>
> Since we have recently added a security field to the struct sock and some
> new hooks to LSM (Rev 1.348 in BitKeeper), we can likely eliminate the
> second case by saving the proper SID in the struct sock when the
> tcp_create_openreq_child hook is called and then using this information in
> the skb_set_owner_w hook to label the traffic.  However, I think that this
> will require passing the listening socket (sk) to the
> tcp_create_openreq_child hook in addition to the new socket and the
> network buffer, since the SID will be derived from the listening socket.
> Wayne?
>

  Yes, this makes sense.  The new tcp_create_openreq_child() hook is the
key, so we can now associate a new sock with the listening sock SID. We
could either label the skbuff in tcp_create_openreq_child() directly for
this case, or save the SID in the sock and allow skb_set_owner_w() label
the SKB as is it's function. Having tcp_create_openreq_child() would be
slightly more efficient because we can eliminate the checks in
skb_set_owner_w() for PF_INET and SOCK_STREAM.

  And yes, we'd have to modify the tcp_create_openreq_child() hook to pass
in the in the listening sock struct.

Wayne
 --
Wayne Salamon
wsalamon@tislabs.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
