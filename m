Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA25234
	for <selinux@tycho.nsa.gov>; Sun, 11 Aug 2002 17:22:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA03754
	for <selinux@tycho.nsa.gov>; Sun, 11 Aug 2002 21:21:31 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA03750
	for <selinux@tycho.nsa.gov>; Sun, 11 Aug 2002 21:21:27 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Swollen su_macros.te file
Date: Sun, 11 Aug 2002 23:21:59 +0200
Cc: selinux@tycho.nsa.gov
References: <20020811205718.89317.qmail@web40014.mail.yahoo.com>
In-Reply-To: <20020811205718.89317.qmail@web40014.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <20020811212159.9371B339@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 11 Aug 2002 22:57, Brad Chapman wrote:
> > > > $1_su_t should not have access to man pages, home directories,
> > > > sysctl, debian_menu_t, device files, boot_t, etc.
> > >
> > >         I know, but everything keeps showing up as $1_su_t instead of
> > > the correct domain, such as insmod_t, devfsd_t, init_t, etc. I wouldn't
> > > have had this problem if that wasn't the case.
> >
> > Giving one domain access to everything brings you back towards the
> > standard Linux permission system.
> >
> > What you have to do is determine why it isn't transitioning back to the
> > correct domain.
> >
> > Maybe your shell is not labelled as shell_exec_t.
>
>         It is labeled as shell_exec_t.

Check that you have the domain_auto_trans() macro correctly functioning for 
transitioning to the user_t domain from user_su_t on execute of shell_exec_t.

Inside the domain_auto_trans macro put the following line for debugging 
purposes:
#DOMAIN_AUTO_TRANS($1, $2, $3)

Then you'll be able to easily check that the correct rule is going in.

> > >         BTW, here are some more files which look more like spaghetti
> > > pots IMHO. They are devfsd.te, admin_macros.te, and xserver_macros.te.
> > > I would very much like to straighten these messy files out. Thanks for
> > > your help.
> >
> > You will be better off copying from the latest versions I maintain,
> > especially for devfsd.  Also what distribution do you use?  If it's not
> > Debian then make sure the init scripts for devfsd are run in the same way
> > as the Debian package regarding making device nodes for non-devfs
> > devices.  If it is Debian then upgrade to the latest devfsd package.
>
>         I know that, but how long will it take me to remove all of the
> errors that I KNOW will pop up, because of basic differences in locations
> and such? I use Red Hat 6.2, BTW.

The easy way to solve these problems is to find out why things aren't working 
as they should and fix it.

The hard way is to continually hack in extra rules for domains that shouldn't 
have them so that eventually every domain can do almost everything, and you 
lose most of the security you wanted to gain from SE Linux in the first place.

The NSA people wrote their original policy for Red Hat.  In my changes I have 
been careful to try and avoid doing things that are likely to break it for 
Red Hat users.  Steve is presumably still testing his policy on Red Hat 
before commiting it to the CVS.

Getting it to work on Red Hat should not be THAT difficult.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
