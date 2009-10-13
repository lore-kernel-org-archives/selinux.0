Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9DCKkQt024278
	for <selinux@tycho.nsa.gov>; Tue, 13 Oct 2009 08:20:46 -0400
Received: from mail2.asahi-net.or.jp (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9DCJscs022431
	for <selinux@tycho.nsa.gov>; Tue, 13 Oct 2009 12:19:55 GMT
Message-ID: <4AD4709A.6050407@kaigai.gr.jp>
Date: Tue, 13 Oct 2009 21:20:42 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: michel m <michel.mcgregor@gmail.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: what is http authenticated user?
References: <bb74313d0910130430l3f9ff448p42efbcfba5c90d4e@mail.gmail.com>
In-Reply-To: <bb74313d0910130430l3f9ff448p42efbcfba5c90d4e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

michel m wrote:
> Hi,
> 
> in my last mail, I had asked how to get context for incoming requests. 
> meanwhile studying replies, I got familiar with apache/selinux plus 
> which labels threads based on identity of user. but I can not understand 
> how users are authenticated from http requests. who does this 
> authentication ( is it a service special to apache/httpd that analyzes 
> http requests) ? I think, an http request in normal form does not 
> contain any information by which remote user can be authenticated.
> 
> may some one explain me more or redirect me to some resources that 
> clarify things more?

You need to distinguish a web-user from a OS-user.

When you have a shopping at amazon.com, you were supposed to provide
your account information (e.g e-mail address and password), but it
does not mean that a new user account is available on the operating
system of amazon.com, because all the http requests are handled by
httpd server process from the viewpoint of operating system.

A web-user is a concept in web or application layer, not OS.
Its account information is implicitly sent for each http request basically,
then the http server parses it and applies its authentication.
(if failed, http server returns an error prior to page references.)

Apache/SELinux Plus is a module to assign a certain security context
based on the authorized web-user, not OS-user.

However, here is no fundamental differences between httpd and sshd.
When we connect a host using ssh, we have to provide my account information
(e.g username/password or public key), then ssh authorizes the connection
using the given account info, and assigns a certain security context on the
user login shell.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
