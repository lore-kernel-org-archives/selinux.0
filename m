Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB3EHajA025081
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2007 09:17:36 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id lB3EHXbQ026583
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2007 14:17:35 GMT
Subject: Re: libsepol.expand_terule_helper: duplicate TE rule
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Shintaro Fujiwara <shintaro.fujiwara@gmail.com>
Cc: Chris PeBenito <pebenito@gentoo.org>, selinux <selinux@tycho.nsa.gov>
In-Reply-To: <f71a82820712011518u409799c9wa48902f7062f6c02@mail.gmail.com>
References: <f71a82820712010015yafc65dfm21d3f21fbb264008@mail.gmail.com>
	 <1196546279.4808.2.camel@defiant.pebenito.net>
	 <f71a82820712011518u409799c9wa48902f7062f6c02@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 03 Dec 2007 09:17:24 -0500
Message-Id: <1196691444.25613.0.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-12-02 at 08:18 +0900, Shintaro Fujiwara wrote:
> Well, as a matter of fact, I installed apache from source.
> So, I installed apche into /usr/local/apache2.
> 
> I set /etc/selinux/config permissive and found that apache
> runs in initrc_t.
> But, of course I want to make it run httpd_t.
> 
> So, I tried to edit your refpolicy downloading from repository,
> newest version.

And the remainder of the policy is which fedora policy version?

> I commented every
> 
> type ...
> bool ...
> atribute...
> 
> including .if of templates.
> 
> and set them require {}.
> 
> I succeeded make apache.pp all-right, but when I tried to install by
> semodule -i apache.pp,
> expand_terule_helper says it has an error.
> 
> I found exim module in services directory but could not found
> anything like process system_mail_t
> I could not found those in tmp/apache.mod either.
> 
> It's first time I see this error and don't know what it is.
> 
> I messed up policy apache or some kind of bug ?
> 
> I succeeded install postgresql and mysql by this method all-right.
> 
> Thanks for your quick response.
> 
> 
> 2007/12/2, Chris PeBenito <pebenito@gentoo.org>:
> > On Sat, 2007-12-01 at 17:15 +0900, Shintaro Fujiwara wrote:
> > > When I try to install apache.pp,
> > >
> > > libsepol.expand_terule_helper: duplicate TE rule for httpd_t
> > > exim_exec_t:process system_mail_t
> > > libsepol.expand_module: Error during expand
> > > libsemanage.semanage_expand_sandbox: Expand module failed
> > > semodule:  Failed!
> > >
> > > I can't find any lines concerning exim_exec_t anywhere...
> > > Please help.
> >
> > Which distro policy are you using?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
