Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA00857
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 16:57:47 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA01755
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 20:57:20 GMT
Received: from web40020.mail.yahoo.com (web40020.mail.yahoo.com [66.218.78.60])
	by jazzswing.ncsc.mil  with SMTP id UAA01751
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 20:57:19 GMT
Message-ID: <20020627205745.33725.qmail@web40020.mail.yahoo.com>
Date: Thu, 27 Jun 2002 13:57:45 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Major reduction in errors
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20020627195219.DA7037CFE@lyta.coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mr. Coker,

--- Russell Coker <russell@coker.com.au> wrote:
> On Thu, 27 Jun 2002 15:36, Brad Chapman wrote:
> > --- Russell Coker <russell@coker.com.au> wrote:
> > > avc:  denied  { read } for  pid=12 exe=/sbin/devfsd path=/.devfsd
> > > dev=00:07 ino=2 scontext=system_u:system_r:devfsd_t
> > > tcontext=system_u:object_r:devfs_t tclass=chr_file
> > >
> > > You need the following in the devfs_contexts file:
> > > devfscon /.devfsd               system_u:object_r:devfs_control_t
> >
> >         This causes a syntax error when I attempt to compile the policy.
> 
> In that case you're using too old a version of the selinux-small code base to

> work with this.  Put in a rule to allow devfsd_t to read from 
> devfs_t:chr_file until you can upgrade.

        I'm not using selinux-small. I'm using selinux-2002053110.tar.gz,
downloaded straight from www.nsa.gov. And the rule you told me I needed
will look something like this:

        allow devfsd_t devfs_t:chr_file { read };

        Correct?

Brad


=====
Brad Chapman

Permanent e-mails: kakadu_croc@yahoo.com
		   jabiru_croc@yahoo.com
		   tanami_croc@devel.lbsd.net

__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
