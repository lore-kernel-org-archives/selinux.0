Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA07128
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 10:28:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA19870
	for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 14:26:21 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA19865 for <selinux@tycho.nsa.gov>; Tue, 27 Aug 2002 14:26:20 GMT
Date: Tue, 27 Aug 2002 10:27:40 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Tom <tom@lemuria.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: FYI: woody startup messages
In-Reply-To: <20020827141101.5DFB12355@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208271025220.14544-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 27 Aug 2002, Russell Coker wrote:

> On Tue, 27 Aug 2002 12:56, you wrote:
> > there's a few other puzzles in there I'll try to solve myself, e.g. why
> > proftpd tries to bind some high port.
>
> > Aug 27 12:56:57 nsa kernel: avc:  denied  { name_bind } for  pid=254
> > exe=/usr/sbin/proftpd port=5376 scontext=system_u:system_r:ftpd_t
> > tcontext=system_u:object_r:ftp_port_t tclass=tcp_socket
>
> 5376 >> 8 = 21.
>
> As a quick test on my system, "netcat -l -p 106" as user_t gives the
> following:
> avc:  denied  { name_bind } for  pid=22563 exe=/bin/nc port=27136
> scontext=rjc:user_r:user_t tcontext=system_u:object_r:pop_port_t
> tclass=tcp_socket
>
> Maybe there's one too many ntohs() calls in the audit code...

Yes, good call.  avc_audit() calls ntohs() on the port number passed to
it, but this port number was already converted to host order.  Note that
this is merely a bug in the audit output, not a problem with the
permission check itself.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
