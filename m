Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n47JMTVD014869
	for <selinux@tycho.nsa.gov>; Thu, 7 May 2009 15:22:29 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n47JQ01j007936
	for <selinux@tycho.nsa.gov>; Thu, 7 May 2009 19:26:08 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Memory leak in libselinux/src/label_file.c
Date: Thu, 7 May 2009 15:20:27 -0400
Message-ID: <C628ACBB.A6FA6%csellers@tresys.com>
In-Reply-To: <d6a0e5a20904022158w21bdf15eg31d248013c2f1c57@mail.gmail.com>
From: "Chad Sellers" <csellers@tresys.com>
To: "Hiroshi Shinji" <hiroshi.shinji@gmail.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 4/3/09 12:58 AM, "Hiroshi Shinji" <hiroshi.shinji@gmail.com> wrote:

> Hi,
> 
> I found memory leak in libselinux/src/label_file.c.
> Please fix it.
> 
> Regards,

This looks good to me.

Acked-by: Chad Sellers <csellers@tresys.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
