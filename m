Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8EJLu4r020489
	for <selinux@tycho.nsa.gov>; Fri, 14 Sep 2007 15:21:56 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l8EJLstY014511
	for <selinux@tycho.nsa.gov>; Fri, 14 Sep 2007 19:21:54 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [refpolicy] apt and dpkg changes
Date: Fri, 14 Sep 2007 14:55:06 -0400
Message-ID: <1189796106.17544.3.camel@gorn.columbia.tresys.com>
In-Reply-To: <1189778176.6047.6.camel@vogon>
References: <415EF526-2C14-4AF6-91A2-7AEC4692823C@sf-net.com> <1189776979.11871.6.camel@gorn>  <1189778176.6047.6.camel@vogon>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Stefan Schulze Frielinghaus" <stefan@sf-net.com>
Cc: "SELinux List" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-09-14 at 15:56 +0200, Stefan Schulze Frielinghaus wrote:
> On Fri, 2007-09-14 at 09:36 -0400, Christopher J. PeBenito wrote:
> > On Sat, 2007-08-18 at 02:28 -0400, Stefan Schulze Frielinghaus wrote:
> > > +template(`apt_per_role_template',`
> > [...]
> > > +        type $1_apt_t;
> > > +        domain_type($1_apt_t)
> > > +        domain_entry_file($1_apt_t,apt_exec_t)
> > > +       role $3 types $1_apt_t;
> > > +
> > > +       type $1_home_apt_t;
> > > +       files_type($1_home_apt_t)
> > [...]
> > > +       manage_dirs_pattern(apt_t,$1_home_apt_t,$1_home_apt_t)
> > > +       manage_files_pattern(apt_t,$1_home_apt_t,$1_home_apt_t)
> > > +
> > > +       allow apt_t $1_home_dir_t:dir search;
> > > +')
> > 
> > Why is this needed?
> 
> Management rights are needed because via aptitude you can manage your
> own config files.

But you would be running it as an admin, not a regular user, right?

> > > --- /usr/src/refpolicy-20070629/policy/modules/admin/apt.te     2007-06-29 16:48:13.000000000 +0200
> > > +++ policy/modules/admin/apt.te 2007-08-16 17:46:35.000000000 +0200
> > > @@ -1,6 +1,10 @@
> > >  
> > >  policy_module(apt,1.2.0)
> > >  
> > > +gen_require(`
> > > +       type var_log_t;
> > > +')
> > [...]
> > > +# append to logfile
> > > +allow apt_t var_log_t:dir search;
> > > +append_files_pattern(apt_t,apt_log_t,apt_log_t)
> > 
> > Requiring and using an external type like this is not allowed.
> 
> Why? Do I need to include a require statement?

Its one of the core refpolicy rules, which is one of the reasons we have
interfaces.

> Otherwise we could use the following:
> 
> logging_search_logs(apt_t)

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
