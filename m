Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA25085
	for <selinux@tycho.nsa.gov>; Sun, 11 Aug 2002 16:52:48 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA02949
	for <selinux@tycho.nsa.gov>; Sun, 11 Aug 2002 20:51:50 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id UAA02945
	for <selinux@tycho.nsa.gov>; Sun, 11 Aug 2002 20:51:48 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Swollen su_macros.te file
Date: Sun, 11 Aug 2002 22:52:33 +0200
Cc: selinux@tycho.nsa.gov
References: <20020811204041.88072.qmail@web40014.mail.yahoo.com>
In-Reply-To: <20020811204041.88072.qmail@web40014.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020811205234.3C26A861B@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 11 Aug 2002 22:40, Brad Chapman wrote:
> > >       Lately I have noticed that my su_macros.te file is becoming
> > > unmanageable due to the enormous amount of stuff that I use su for.
> > > Could you (and the list) please review my su_macros.te file and tell me
> > > how to make it smaller?
> >
> > I think that you have something wrong with your setup.  The $1_su_t
> > domain is
> >
> > only to be used for the "su" program, I think that you are using the
> > shell in
> >
> > that domain too for some reason.
> >
> > $1_su_t should not have access to man pages, home directories, sysctl,
> > debian_menu_t, device files, boot_t, etc.
>
>         I know, but everything keeps showing up as $1_su_t instead of
> the correct domain, such as insmod_t, devfsd_t, init_t, etc. I wouldn't
> have had this problem if that wasn't the case.

Giving one domain access to everything brings you back towards the standard 
Linux permission system.

What you have to do is determine why it isn't transitioning back to the 
correct domain.

Maybe your shell is not labelled as shell_exec_t.

>         BTW, here are some more files which look more like spaghetti pots
> IMHO. They are devfsd.te, admin_macros.te, and xserver_macros.te. I would
> very much like to straighten these messy files out. Thanks for your help.

You will be better off copying from the latest versions I maintain, 
especially for devfsd.  Also what distribution do you use?  If it's not 
Debian then make sure the init scripts for devfsd are run in the same way as 
the Debian package regarding making device nodes for non-devfs devices.  If 
it is Debian then upgrade to the latest devfsd package.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
