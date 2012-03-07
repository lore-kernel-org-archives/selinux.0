MIME-Version: 1.0
In-Reply-To: <14357406.17003.135edba7f47.Coremail.yffbrave@163.com>
References: <14357406.17003.135edba7f47.Coremail.yffbrave@163.com>
Date: Wed, 7 Mar 2012 10:52:48 -0500
Message-ID: <CACLa4pu1dLjebpOMQs17wwPcZWo3Vo2g5ZTyT1poO-z69-2vLQ@mail.gmail.com>
Subject: Re: A few questions
From: Eric Paris <eparis@parisplace.org>
To: Yao <yffbrave@163.com>
Cc: SELinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

2012/3/7 Yao <yffbrave@163.com>:

> (2)the struct "selinux_ops" in file hooks.c is declared as "static", why not
> add "const" qualifier so that
> the it will be put in read-only data section in the kernel?

I probably can.  Thanks for the suggestion.

> (3)Is there any way to hack the SELinux, I mean, to disable it on the fly?
> For example, replace the policy db with a
> blank file so that any permission is allowed. Is it feasible?

There have been kernel attacks which disable SELinux.  If you can
write to arbitrary kernel memory you can win.  But I'm not going to
help tell you how to write your rootkit    :)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
