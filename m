Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA65K0Sf015769
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2003 00:20:01 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hA65JxKl015040
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2003 05:19:59 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id hA65Jx5m015037 for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2003 05:19:59 GMT
Date: Thu, 6 Nov 2003 00:19:19 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Yuan ChunYang <cyyuanml@sonata.iscas.ac.cn>
cc: lsm <linux-security-module@wirex.com>, <selinux@tycho.nsa.gov>
Subject: Re: What's "name_bind " permission and difference with "bind"
 permission?
In-Reply-To: <1068080280.1084.2.camel@sonata>
Message-ID: <Xine.LNX.4.44.0311060003290.16840-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 6 Nov 2003, Yuan ChunYang wrote:

> hi,  in selinux ,there is "name_bind" permission check in
> selinux_socket_bind permission. It's said that "If PF_INET, check
> name_bind permission for the port" .
> Can somebody tell me what's name_bind permission and difference with
> "bind" permission?
> thanx!

The bind permission is used to control whether a socket is allowed to 
have bind(3) called on it.

The name_bind permission is a further check between a socket and the port
it is being bound to, if the port is outside the local port range
(determined by the sysctl net.ipv4.ip_local_port_range) and/or is a
protected port.

See http://www.nsa.gov/selinux/doc/module/x2042.html, and policy examples.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
