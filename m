Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0LMTuTh031700
	for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2013 17:30:01 -0500
Received: by mail-ee0-f47.google.com with SMTP id e52so3069764eek.6
        for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2013 14:29:58 -0800 (PST)
Message-ID: <1358807394.2986.9.camel@d30>
Subject: Re: ERROR 'type staff_java_t is not within scope' at token
From: Dominick Grift <dominick.grift@gmail.com>
To: Hung Truong <hung.truong@tridsys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Mon, 21 Jan 2013 23:29:54 +0100
In-Reply-To: <1358807160.2986.7.camel@d30>
References: 
	3086262d0228a121663cb87f5d77a07a@mail.gmail.com <bf19e346e82ccd053990b576f4058a61@mail.gmail.com>
	 <1358807160.2986.7.camel@d30>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2013-01-21 at 23:26 +0100, Dominick Grift wrote:

> > Does anyone know why I get this error and how to fix it?  BTW, if it does
> > matter, I modified the *.spec file to build a monolithic and strict policy.
> > 
> 
> I think this policy needs to be nested properly
> 
> Its a dependency thing
> 
> so for example:
> 
> optional_policy(`
>   java_per_role_template(staff, staff_r, staff_t)
> 
>   optional_policy(`
>     allow staff_java_t cdvoip_sysadmcat_pki_cdvaserver_pem_t: file
> read_file_perms;
>   ')
> ')
> 

Actually the whole concept of optional policy should does not apply to
monolitic policy but i guess the compiler still wants it somehow


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
