From: Glauber de Oliveira Costa <glommer@br.ibm.com>
To: Steve G <linux_4ever@yahoo.com>
Subject: Re: [PATCH] Add version option to newrole
Date: Wed, 8 Feb 2006 15:16:14 -0200
Cc: Selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
References: <20060208171037.31031.qmail@web51504.mail.yahoo.com>
In-Reply-To: <20060208171037.31031.qmail@web51504.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602081516.14832.glommer@br.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Em Quarta 08 Fevereiro 2006 15:10, Steve G escreveu:
> >I moved the constant definition to the makefile, and also, I'm gathering
> > the
>
> data
>
> >from the version file.
>
> Thanks. That should be easier to maintain.

Np. 

> >Also, Steve, I would like to hear from you why do you think the -v
> >option is not that descriptive.
>
> OK my bad. I though the -- ARGS was added. -v is fine.
>
> But waht about the other programs? load_policy, restorecon, run_init,
> etc...

Note that it would be too much spent work *IF* you don't like the idea. So, 
here is newrole implementation for your appreciation. If you guys tell me 
"Ok, version option is good, we'll merge it", I'll then implement it in other 
programs, and document it in their respective manpages.

Also, if there are any of the policycoreutils programs that for any reason 
should *not* have a version option for any reason, please let me know the 
program along with the reasons, and I'll skip it.

> -Steve

Glauber.

> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
