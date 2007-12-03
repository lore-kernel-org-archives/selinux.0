Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB3LrUEO011124
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2007 16:53:30 -0500
Received: from nz-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB3LrTo0008673
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2007 21:53:29 GMT
Received: by nz-out-0506.google.com with SMTP id i1so2206813nzh
        for <selinux@tycho.nsa.gov>; Mon, 03 Dec 2007 13:53:29 -0800 (PST)
Message-ID: <f71a82820712031353r6531c257u8845617d9072f36d@mail.gmail.com>
Date: Tue, 4 Dec 2007 06:53:28 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: libsepol.expand_terule_helper: duplicate TE rule
In-Reply-To: <1196691444.25613.0.camel@gorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f71a82820712010015yafc65dfm21d3f21fbb264008@mail.gmail.com>
	 <1196546279.4808.2.camel@defiant.pebenito.net>
	 <f71a82820712011518u409799c9wa48902f7062f6c02@mail.gmail.com>
	 <1196691444.25613.0.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here's I get.

# rpm -qa|grep selinux
libselinux-python-2.0.43-1.fc8
selinux-policy-mls-3.0.8-58.fc8
selinux-doc-1.26-1.1
selinux-policy-3.0.8-58.fc8
selinux-policy-targeted-3.0.8-58.fc8
libselinux-devel-2.0.43-1.fc8
libselinux-2.0.43-1.fc8
selinux-policy-devel-3.0.8-58.fc8

I really want to get F8 server run (apache)..

2007/12/3, Christopher J. PeBenito <cpebenito@tresys.com>:
> On Sun, 2007-12-02 at 08:18 +0900, Shintaro Fujiwara wrote:
> > Well, as a matter of fact, I installed apache from source.
> > So, I installed apche into /usr/local/apache2.
> >
> > I set /etc/selinux/config permissive and found that apache
> > runs in initrc_t.
> > But, of course I want to make it run httpd_t.
> >
> > So, I tried to edit your refpolicy downloading from repository,
> > newest version.
>
> And the remainder of the policy is which fedora policy version?
>
> > I commented every
> >
> > type ...
> > bool ...
> > atribute...
> >
> > including .if of templates.
> >
> > and set them require {}.
> >
> > I succeeded make apache.pp all-right, but when I tried to install by
> > semodule -i apache.pp,
> > expand_terule_helper says it has an error.
> >
> > I found exim module in services directory but could not found
> > anything like process system_mail_t
> > I could not found those in tmp/apache.mod either.
> >
> > It's first time I see this error and don't know what it is.
> >
> > I messed up policy apache or some kind of bug ?
> >
> > I succeeded install postgresql and mysql by this method all-right.
> >
> > Thanks for your quick response.
> >
> >
> > 2007/12/2, Chris PeBenito <pebenito@gentoo.org>:
> > > On Sat, 2007-12-01 at 17:15 +0900, Shintaro Fujiwara wrote:
> > > > When I try to install apache.pp,
> > > >
> > > > libsepol.expand_terule_helper: duplicate TE rule for httpd_t
> > > > exim_exec_t:process system_mail_t
> > > > libsepol.expand_module: Error during expand
> > > > libsemanage.semanage_expand_sandbox: Expand module failed
> > > > semodule:  Failed!
> > > >
> > > > I can't find any lines concerning exim_exec_t anywhere...
> > > > Please help.
> > >
> > > Which distro policy are you using?
>
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
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
