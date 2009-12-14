Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBE9uRw3009181
	for <selinux@tycho.nsa.gov>; Mon, 14 Dec 2009 04:56:27 -0500
Received: from cp-out12.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nBE9weoK010773
	for <selinux@tycho.nsa.gov>; Mon, 14 Dec 2009 09:58:41 GMT
Received: from [192.168.2.2] (151.64.23.152) by cp-out12.libero.it (8.5.119)
        id 4B0BAAC204E56F02 for selinux@tycho.nsa.gov; Mon, 14 Dec 2009 10:56:16 +0100
Subject: Re: avc's generated causes the system to freeze up
From: Guido Trentalancia <guido@trentalancia.com>
To: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4B254D52.1080602@gmail.com>
References: <dd18b0c30912111344j65436d86h85f8d74e752e19af@mail.gmail.com>
	 <1260722550.2858.13.camel@tesla.lan>  <4B252E41.6070501@gmail.com>
	 <1260733223.2858.23.camel@tesla.lan>  <4B254D52.1080602@gmail.com>
Content-Type: text/plain
Date: Mon, 14 Dec 2009 10:56:15 +0100
Message-Id: <1260784575.2853.17.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Have you tried the "-r" option of auditctl ? This would be something
similar to the kernel printk_ratelimit(). The default is 0, you should
increase it to a positive value representing a messages/second limit.

Guido

On Sun, 2009-12-13 at 12:23 -0800, Justin P. Mattock wrote:
> On 12/13/09 11:40, Guido Trentalancia wrote:
> > Have you tried tuning auditd and its dispatcher which could be audispd ?
> >
> > So for example, try feeding audispd with the following options:
> >
> > q_depth: increase it from its default value (which is 80 on Redhat's
> > recent auditd)
> > priority_boost = 0
> >
> > Finally, if things don't improve, you could also try:
> >
> > overflow_action = suspend
> >
> > Other than this I don't know how to help. Good luck.
> >
> >
> 
> well right now I dont really use auditd i.g.
> the libraries are there but the daemon is off.
> (I am not using fedora/redhat).
> 
> In any case it's not a worry because I can go ahead and add the
> allow rules,  moreover the main issue is the spamming
> of log message which might/could result in some buffer thing
> reason for wanting info if there is a mechanism
> like printk_ratelimit etc.. for Xorg.0.log
> 
> Justin P. Mattock
> 
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
