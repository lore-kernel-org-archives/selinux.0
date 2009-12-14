Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBEGApnd000916
	for <selinux@tycho.nsa.gov>; Mon, 14 Dec 2009 11:10:58 -0500
Received: from mail-gx0-f226.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nBEGDJJE029433
	for <selinux@tycho.nsa.gov>; Mon, 14 Dec 2009 16:13:19 GMT
Received: by gxk26 with SMTP id 26so1716638gxk.19
        for <selinux@tycho.nsa.gov>; Mon, 14 Dec 2009 08:10:56 -0800 (PST)
Message-ID: <4B2663A2.6090608@gmail.com>
Date: Mon, 14 Dec 2009 08:11:14 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Guido Trentalancia <guido@trentalancia.com>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: avc's generated causes the system to freeze up
References: <dd18b0c30912111344j65436d86h85f8d74e752e19af@mail.gmail.com>	 <1260722550.2858.13.camel@tesla.lan>  <4B252E41.6070501@gmail.com>	 <1260733223.2858.23.camel@tesla.lan>  <4B254D52.1080602@gmail.com> <1260784575.2853.17.camel@tesla.lan>
In-Reply-To: <1260784575.2853.17.camel@tesla.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/14/09 01:56, Guido Trentalancia wrote:
> Have you tried the "-r" option of auditctl ? This would be something
> similar to the kernel printk_ratelimit(). The default is 0, you should
> increase it to a positive value representing a messages/second limit.
>
> Guido
>
>

yeah but remember I have auditd off.

I can try and see...

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
