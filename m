Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA13682
	for <selinux@tycho.nsa.gov>; Mon, 27 Jan 2003 06:18:04 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0RBI4I27043
	for <selinux@tycho.nsa.gov>; Mon, 27 Jan 2003 11:18:04 GMT
Received: from mail.vegaa.de (mail.vegaa.de [213.203.196.181])
        by jazzband.ncsc.mil  with ESMTP id h0RBI3f27039 for <selinux@tycho.nsa.gov>; Mon, 27 Jan 2003 11:18:03 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carsten.grohmann@raumbildsysteme.de>
To: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
Subject: Re: tmpfs_t
Date: Mon, 27 Jan 2003 12:16:50 +0100
References: <200301251657.08983.russell@coker.com.au>
In-Reply-To: <200301251657.08983.russell@coker.com.au>
MIME-Version: 1.0
Message-Id: <200301271216.50369.carsten.grohmann@raumbildsysteme.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Samstag, 25. Januar 2003 16:57 schrieb Russell Coker:
> Or should I instead leave the tmpfs filesystem labelled as tmpfs_t
> and add appropriate file_type_auto_trans() rules for it?

.. a new xxx_tmpfs_t type and both add to the tmp_domain macro?
This way seems to be easy and good way. 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
