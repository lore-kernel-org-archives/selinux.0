Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7H5NKrT011516
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 01:23:20 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7H5NJKV006449
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 05:23:20 GMT
Date: Tue, 17 Aug 2004 01:23:07 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: how does this port binding happen?
In-Reply-To: <200408171317.10813.russell@coker.com.au>
Message-ID: <Xine.LNX.4.44.0408170115060.7480-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 17 Aug 2004, Russell Coker wrote:

> avc:  denied  { name_bind } for  pid=14909 exe=/usr/bin/kview src=669 
> scontext=rjc:staff_r:staff_t tcontext=system_u:object_r:port_t 
> tclass=tcp_socket
> 
> kview is a viewer for JPEG etc images.  It is never run as root.  How does it 
> get to the stage of an SE Linux access check?

This check is done before the kernel DAC check.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
