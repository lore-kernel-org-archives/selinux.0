Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6EGgvVE002648
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2008 12:42:57 -0400
Received: from mho-01-bos.mailhop.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6EGguiV024454
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2008 16:42:56 GMT
Cc: <selinux@tycho.nsa.gov>
Message-Id: <653FACE3-C619-4DD2-8DD0-137333A7B3BE@nall.com>
From: Joe Nall <joe@nall.com>
To: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
In-Reply-To: <0794F277152EF94AA637E3AECF5CB70F010A9C12@blums0042.bluelnk.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v928.1)
Subject: Re: ping and the /tmp directory
Date: Mon, 14 Jul 2008 11:42:54 -0500
References: <0794F277152EF94AA637E3AECF5CB70F010A9C12@blums0042.bluelnk.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jul 14, 2008, at 11:10 AM, Clarkson, Mike R (US SSA) wrote:

> Does the ping utility normally read/write to the /tmp directory?
>
> I've got a domain that uses ping in the ping_t domain, using the
> netutils_domtrans_ping interface, and I'm getting the following from
> audit2allow:
>
> allow ping_t tmp_t:file { read write getattr ioctl };

Is stdout of the parent process being redirected to a tmp file?

joe



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
