Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA25113
	for <selinux@tycho.nsa.gov>; Sun, 11 Aug 2002 16:57:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA09771
	for <selinux@tycho.nsa.gov>; Sun, 11 Aug 2002 20:55:44 GMT
Received: from web40014.mail.yahoo.com (web40014.mail.yahoo.com [66.218.78.54])
        by jazzband.ncsc.mil  with SMTP id UAA09767 for <selinux@tycho.nsa.gov>; Sun, 11 Aug 2002 20:55:43 GMT
Message-ID: <20020811205718.89317.qmail@web40014.mail.yahoo.com>
Date: Sun, 11 Aug 2002 13:57:18 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Swollen su_macros.te file
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20020811205234.3C26A861B@lyta.coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mr. Russell,

--- Russell Coker <russell@coker.com.au> wrote:
> On Sun, 11 Aug 2002 22:40, Brad Chapman wrote:
> > > >       Lately I have noticed that my su_macros.te file is becoming
> > > > unmanageable due to the enormous amount of stuff that I use su for.
> > > > Could you (and the list) please review my su_macros.te file and tell me
> > > > how to make it smaller?
> > >
> > > I think that you have something wrong with your setup.  The $1_su_t
> > > domain is
> > >
> > > only to be used for the "su" program, I think that you are using the
> > > shell in
> > >
> > > that domain too for some reason.
> > >
> > > $1_su_t should not have access to man pages, home directories, sysctl,
> > > debian_menu_t, device files, boot_t, etc.
> >
> >         I know, but everything keeps showing up as $1_su_t instead of
> > the correct domain, such as insmod_t, devfsd_t, init_t, etc. I wouldn't
> > have had this problem if that wasn't the case.
> 
> Giving one domain access to everything brings you back towards the standard 
> Linux permission system.
> 
> What you have to do is determine why it isn't transitioning back to the 
> correct domain.
> 
> Maybe your shell is not labelled as shell_exec_t.

        It is labeled as shell_exec_t.

> 
> >         BTW, here are some more files which look more like spaghetti pots
> > IMHO. They are devfsd.te, admin_macros.te, and xserver_macros.te. I would
> > very much like to straighten these messy files out. Thanks for your help.
> 
> You will be better off copying from the latest versions I maintain, 
> especially for devfsd.  Also what distribution do you use?  If it's not 
> Debian then make sure the init scripts for devfsd are run in the same way as 
> the Debian package regarding making device nodes for non-devfs devices.  If 
> it is Debian then upgrade to the latest devfsd package.

        I know that, but how long will it take me to remove all of the errors
that I KNOW will pop up, because of basic differences in locations and such?
I use Red Hat 6.2, BTW.

Brad


=====
Brad Chapman

Permanent e-mails: kakadu_croc@yahoo.com
		   jabiru_croc@yahoo.com
		   tanami_croc@devel.lbsd.net

__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
