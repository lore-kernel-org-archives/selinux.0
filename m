Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2J2lbwx006280
	for <selinux@tycho.nsa.gov>; Sun, 18 Mar 2007 22:47:37 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2J2labh024182
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 02:47:36 GMT
Message-ID: <45FDF9B2.2060805@manicmethod.com>
Date: Sun, 18 Mar 2007 22:47:14 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: JanuGerman <doublemalam@yahoo.co.uk>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: errors in debugging "services.c"
References: <20070318095444.98257.qmail@web86913.mail.ukl.yahoo.com>
In-Reply-To: <20070318095444.98257.qmail@web86913.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

JanuGerman wrote:
> Hi Every body,
>
>   I have included some "print" and some "manipulation"
> statements with the ss/services.c file, in order to
> get some of output, at various places during kernel
> compilation.
>
>  Unfortunately, i was not successful, in doing so, and
> got a long list of errors, for missing standard
> libraries e.g: 
>
> security/selinux/ss/services.c:44:19: error: stdio.h:
> No such file or directory
> error: string.h: No such file or directory
> error: stdlib.h: No such file or directory
> error: stdint.h: No such file or directory
> error: stderr undeclared (first use in this function)
>
> (i have truncated the errors, because they were too
> much verbose)
>
>
> The difficulty is that, when i execute these print and
> manipulation statements as a sepeate file within the
> kerncel source tree i.e. within ss/, no problem at
> all, and all went well. I think so, i am making some
> path problems. If some body, can suggest me some thing
> in this regard.
>   
Are you trying to use fprintf or other libc functions? (i see stderr 
there, which doesn't exist in the kernel), the kernel doesn't use 
standard libc calls, printk should be used to print out information to 
the kernel ring buffer, which can be checked with the dmesg command, 
with a flag such as KERN_INFO, KERN_ERR, etc to specify how critical it is.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
