Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2GEEcDX015444
	for <selinux@tycho.nsa.gov>; Thu, 16 Mar 2006 09:14:42 -0500
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2GECw3h002833
	for <selinux@tycho.nsa.gov>; Thu, 16 Mar 2006 14:12:59 GMT
Subject: Re: one line fix for tor module
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1142469199.16360.23.camel@wintermute.xmldesign.de>
References: <1142469199.16360.23.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 09:14:23 -0500
Message-Id: <1142518463.20739.11.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-03-16 at 01:33 +0100, Erich Schubert wrote:
> Hi,
> Seems like I missed one statement for tor.

> -allow tor_t self:tcp_socket create_socket_perms;
> +allow tor_t self:tcp_socket { create_socket_perms accept };

I think what you want instead is to change it to
create_stream_socket_perms, since you need to listen first before you
can accept?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
