Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6EHv2fO023196
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2008 13:57:02 -0400
Received: from yw-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6EHv1iV014029
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2008 17:57:01 GMT
Received: by yw-out-1718.google.com with SMTP id 6so2071825ywa.84
        for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2008 10:56:49 -0700 (PDT)
Message-ID: <4c4ba1530807141056k69261f9eqd1798edb0e56bdf0@mail.gmail.com>
Date: Mon, 14 Jul 2008 10:56:48 -0700
From: "Tom London" <selinux@gmail.com>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Subject: Re: ping and the /tmp directory
Cc: selinux@tycho.nsa.gov
In-Reply-To: <0794F277152EF94AA637E3AECF5CB70F010A9C12@blums0042.bluelnk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <0794F277152EF94AA637E3AECF5CB70F010A9C12@blums0042.bluelnk.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jul 14, 2008 at 9:10 AM, Clarkson, Mike R (US SSA)
<mike.clarkson@baesystems.com> wrote:
> Does the ping utility normally read/write to the /tmp directory?
>
> I've got a domain that uses ping in the ping_t domain, using the
> netutils_domtrans_ping interface, and I'm getting the following from
> audit2allow:
>
> allow ping_t tmp_t:file { read write getattr ioctl };
>
> Thanks
>

Do you have nscd running? If I remember right, some versions saved
nscd state in /tmp somewhere.

tom
-- 
Tom London

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
