Subject: Re: errors in debugging "services.c"
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <20070318095444.98257.qmail@web86913.mail.ukl.yahoo.com>
References: <20070318095444.98257.qmail@web86913.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 09:51:04 -0400
Message-Id: <1174312264.22565.58.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-03-18 at 09:54 +0000, JanuGerman wrote:
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

Dropping a new .c file into the ss/ subdirectory doesn't cause it to be
built as part of the kernel build unless you also update ss/Makefile, so
likely your separate file isn't being built at all.

And you can't use stdio from the kernel naturally.  New to kernel
development?  You might want to go to:
http://kernelnewbies.org/
and get yourself a good book on Linux kernel development.  Please don't
ask basic questions about kernel development here.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
