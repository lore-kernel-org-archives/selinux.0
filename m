Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBEGFAb5001229
	for <selinux@tycho.nsa.gov>; Mon, 14 Dec 2009 11:15:13 -0500
Received: from cp-out11.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nBEGE2Wd010184
	for <selinux@tycho.nsa.gov>; Mon, 14 Dec 2009 16:14:03 GMT
Received: from [192.168.2.2] (151.64.23.152) by cp-out11.libero.it (8.5.119)
        id 4AE04A3D0B726DC1 for selinux@tycho.nsa.gov; Mon, 14 Dec 2009 17:15:10 +0100
Subject: Re: avc's generated causes the system to freeze up
From: Guido Trentalancia <guido@trentalancia.com>
To: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4B2663A2.6090608@gmail.com>
References: <dd18b0c30912111344j65436d86h85f8d74e752e19af@mail.gmail.com>
	 <1260722550.2858.13.camel@tesla.lan>  <4B252E41.6070501@gmail.com>
	 <1260733223.2858.23.camel@tesla.lan>  <4B254D52.1080602@gmail.com>
	 <1260784575.2853.17.camel@tesla.lan>  <4B2663A2.6090608@gmail.com>
Content-Type: text/plain
Date: Mon, 14 Dec 2009 17:15:09 +0100
Message-Id: <1260807309.2853.55.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Auditctl should operate at kernel-level. But this topics are all
off-theme from SELinux. You shouldn't post audit questions to a SELinux
mailing list.

On Mon, 2009-12-14 at 08:11 -0800, Justin P. Mattock wrote:
> On 12/14/09 01:56, Guido Trentalancia wrote:
> > Have you tried the "-r" option of auditctl ? This would be something
> > similar to the kernel printk_ratelimit(). The default is 0, you should
> > increase it to a positive value representing a messages/second limit.
> >
> > Guido
> >
> >
> 
> yeah but remember I have auditd off.
> 
> I can try and see...
> 
> Justin P. Mattock
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
