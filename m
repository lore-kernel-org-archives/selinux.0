Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lB1NI9ex010630
	for <selinux@tycho.nsa.gov>; Sat, 1 Dec 2007 18:18:09 -0500
Received: from wa-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB1NI8Ye025763
	for <selinux@tycho.nsa.gov>; Sat, 1 Dec 2007 23:18:09 GMT
Received: by wa-out-1112.google.com with SMTP id k22so3617366waf
        for <selinux@tycho.nsa.gov>; Sat, 01 Dec 2007 15:18:08 -0800 (PST)
Message-ID: <f71a82820712011518u409799c9wa48902f7062f6c02@mail.gmail.com>
Date: Sun, 2 Dec 2007 08:18:07 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: "Chris PeBenito" <pebenito@gentoo.org>, selinux <selinux@tycho.nsa.gov>
Subject: Re: libsepol.expand_terule_helper: duplicate TE rule
In-Reply-To: <1196546279.4808.2.camel@defiant.pebenito.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f71a82820712010015yafc65dfm21d3f21fbb264008@mail.gmail.com>
	 <1196546279.4808.2.camel@defiant.pebenito.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Well, as a matter of fact, I installed apache from source.
So, I installed apche into /usr/local/apache2.

I set /etc/selinux/config permissive and found that apache
runs in initrc_t.
But, of course I want to make it run httpd_t.

So, I tried to edit your refpolicy downloading from repository,
newest version.
I commented every

type ...
bool ...
atribute...

including .if of templates.

and set them require {}.

I succeeded make apache.pp all-right, but when I tried to install by
semodule -i apache.pp,
expand_terule_helper says it has an error.

I found exim module in services directory but could not found
anything like process system_mail_t
I could not found those in tmp/apache.mod either.

It's first time I see this error and don't know what it is.

I messed up policy apache or some kind of bug ?

I succeeded install postgresql and mysql by this method all-right.

Thanks for your quick response.


2007/12/2, Chris PeBenito <pebenito@gentoo.org>:
> On Sat, 2007-12-01 at 17:15 +0900, Shintaro Fujiwara wrote:
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
>
> Which distro policy are you using?
>
> --
> Chris PeBenito
> <pebenito@gentoo.org>
> Developer,
> Hardened Gentoo Linux
>
> Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
> Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243
>
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
