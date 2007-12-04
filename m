Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB4LjVtC003778
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 16:45:31 -0500
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB4LjU9J028555
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2007 21:45:30 GMT
Received: by nz-out-0506.google.com with SMTP id i1so2457884nzh
        for <selinux@tycho.nsa.gov>; Tue, 04 Dec 2007 13:45:30 -0800 (PST)
Message-ID: <f71a82820712041345v7a1bdbf2mbc4201ae42fb83ff@mail.gmail.com>
Date: Wed, 5 Dec 2007 06:45:29 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: libsepol.expand_terule_helper: duplicate TE rule
In-Reply-To: <47556017.1040703@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f71a82820712010015yafc65dfm21d3f21fbb264008@mail.gmail.com>
	 <47556017.1040703@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

2007/12/4, Daniel J Walsh <dwalsh@redhat.com>:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Shintaro Fujiwara wrote:
> > When I try to install apache.pp,
> >
> > libsepol.expand_terule_helper: duplicate TE rule for httpd_t
> > exim_exec_t:process system_mail_t
> > libsepol.expand_module: Error during expand
> > libsemanage.semanage_expand_sandbox: Expand module failed
> > semodule:  Failed!
> >
> > I can't find any lines concerning exim_exec_t anywhere...
> > Please help.
> >
> >
> in mta.if,
>
> mta_send_mail has the following
>
>
>         domtrans_pattern($1, mailclient_exec_type, system_mail_t)
>         allow system_mail_t mailclient_exec_type:file entrypoint;
>
>
> And
>
> interface(`mta_mailclient',`
>         gen_require(`
>                 attribute mailclient_exec_type;
>         ')
>
>         typeattribute $1 mailclient_exec_type;
> ')
>
>
> In exim.te
>
> mta_mailclient(exim_exec_t)

Thank you, but, I commented line,

mta_send_mail(httpd_t)

and make apache.pp again but still I have an error.
I'm stuck.


> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.7 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>
> iD8DBQFHVWAXrlYvE4MpobMRAsGsAJ9yGCZ4fMMuLn8FIf5V7IdOIjcYVgCeJVwo
> 45S6MoKx9nAW6430eJiaJNY=
> =L/mO
> -----END PGP SIGNATURE-----
>


-- 
Shintaro Fujiwara
segatex project (SELinux policy tool)
http://sourceforge.net/projects/segatex/
Home page
http://intrajp.no-ip.com/
Blog
http://intrajp.no-ip.com/nucleus/
CMS
http://intrajp.no-ip.com/xoops/
Wiki
http://intrajp.no-ip.com/pukiwiki/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
