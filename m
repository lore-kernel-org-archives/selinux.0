Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8EKSpRR027468
	for <selinux@tycho.nsa.gov>; Fri, 14 Sep 2007 16:28:51 -0400
Received: from mail.seekline.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8EKSmIG014692
	for <selinux@tycho.nsa.gov>; Fri, 14 Sep 2007 20:28:49 GMT
Subject: Re: [refpolicy] apt and dpkg changes
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1189796106.17544.3.camel@gorn.columbia.tresys.com>
References: <415EF526-2C14-4AF6-91A2-7AEC4692823C@sf-net.com>
	 <1189776979.11871.6.camel@gorn>  <1189778176.6047.6.camel@vogon>
	 <1189796106.17544.3.camel@gorn.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 14 Sep 2007 21:33:17 +0200
Message-Id: <1189798397.3170.3.camel@vogon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-09-14 at 14:55 -0400, Christopher J. PeBenito wrote:
> On Fri, 2007-09-14 at 15:56 +0200, Stefan Schulze Frielinghaus wrote:
> > On Fri, 2007-09-14 at 09:36 -0400, Christopher J. PeBenito wrote:
> > > On Sat, 2007-08-18 at 02:28 -0400, Stefan Schulze Frielinghaus wrote:
> > > > +template(`apt_per_role_template',`
> > > [...]
> > > > +        type $1_apt_t;
> > > > +        domain_type($1_apt_t)
> > > > +        domain_entry_file($1_apt_t,apt_exec_t)
> > > > +       role $3 types $1_apt_t;
> > > > +
> > > > +       type $1_home_apt_t;
> > > > +       files_type($1_home_apt_t)
> > > [...]
> > > > +       manage_dirs_pattern(apt_t,$1_home_apt_t,$1_home_apt_t)
> > > > +       manage_files_pattern(apt_t,$1_home_apt_t,$1_home_apt_t)
> > > > +
> > > > +       allow apt_t $1_home_dir_t:dir search;
> > > > +')
> > > 
> > > Why is this needed?
> > 
> > Management rights are needed because via aptitude you can manage your
> > own config files.
> 
> But you would be running it as an admin, not a regular user, right?

At the moment yes. But you could also run it as a normal user to search
a package etc. And after you decided which one to install you could
changerole.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
