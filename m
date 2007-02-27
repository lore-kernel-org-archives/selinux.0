Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1RHQnAP032471
	for <selinux@tycho.nsa.gov>; Tue, 27 Feb 2007 12:26:49 -0500
Received: from web51507.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l1RHSAKw009322
	for <selinux@tycho.nsa.gov>; Tue, 27 Feb 2007 17:28:10 GMT
Date: Tue, 27 Feb 2007 09:28:08 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: [PATCH] Lazy config init in libselinux
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <1172592340.19041.357.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <965532.95521.qm@web51507.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>- I'm not clear that __libc_once is intended to be a stable API/ABI
>provided by glibc, 

We could copy it into a private header. Its a convenience wrapper around
pthread_once, so moving it to a private header would guarantee its stability.

>- I'm not clear on what overhead this imposes upon the functions that
>need to be guarded by __libc_once, and what the tradeoff is for real
>workloads.

I have to ask how often something really needs to know the setting of targeted or
strict that is performance critical. I'd rather see the development tools or
rarely used utilities take the hit in favor of runtime performance of everything
else. There are far more users of "ls" than semodule.

>- We'd have to be careful to ensure that all functions that use any
>global data initialized by init_selinux_config() are guarded by
>__libc_once(),

That is the case, today, with the patch.

>and any future extensions.

That's the trick. We can put some note at the top of the file to remind us. And
some comments in the source, too.

>With the current set, in addition to the path functions, we'd have to
>ensure that the various flags set by init_selinux_config() aren't used
>before initialization anywhere.

Sure. I think we are covered for today's file.

>We can certainly audit all uses now and add such guards, but I'm a
>little concerned about the maintainability of this approach long term.

I did the audit yesterday to make sure everything was covered. Please double
check me since this is important. During the audit, I was also wondering about
/etc/security and whether that should die now. Moving the macro into a private
header should aleviate external dependencies.

My testing of selinuxenabled with this patch and the statfs patch shows its now
21% faster. ls of an empty directory is 166 syscalls before and 147 syscalls
after the patches. So that is also around 11%.

-Steve


 
____________________________________________________________________________________
Do you Yahoo!?
Everyone is raving about the all-new Yahoo! Mail beta.
http://new.mail.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
