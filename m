Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0LMdfaU032404
	for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2013 17:39:41 -0500
Received: by mail-ee0-f49.google.com with SMTP id d4so3056416eek.36
        for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2013 14:39:39 -0800 (PST)
Message-ID: <1358807976.2986.11.camel@d30>
Subject: Re: ERROR 'type staff_java_t is not within scope' at token
From: Dominick Grift <dominick.grift@gmail.com>
To: Hung Truong <hung.truong@tridsys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Mon, 21 Jan 2013 23:39:36 +0100
In-Reply-To: <bf19e346e82ccd053990b576f4058a61@mail.gmail.com>
References: 
	3086262d0228a121663cb87f5d77a07a@mail.gmail.com <bf19e346e82ccd053990b576f4058a61@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2013-01-21 at 13:40 -0500, Hung Truong wrote:
> I have this rule in my policy:

snip

> Does anyone know why I get this error and how to fix it?  BTW, if it
> does matter, I modified the *.spec file to build a monolithic and
> strict policy.
> 
>  

By the way , questions with regard to policy should go to
refpolicy@oss.tresys.com maillist instead



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
