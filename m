Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m75FAMRX026307
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 11:10:22 -0400
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m75FAMSF002190
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 15:10:22 GMT
Cc: selinux@tycho.nsa.gov, txtoth@gmail.com
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 05 Aug 2008 17:10:21 +0200
From: "Dennis Wronka" <linuxweb@gmx.net>
In-Reply-To: <dd18b0c30808050804g3662f22cs8c7c3cba8669cb26@mail.gmail.com>
Message-ID: <20080805151021.243280@gmx.net>
MIME-Version: 1.0
References: <200808052155.18105.linuxweb@gmx.net>	
 <cadfc0e40808050717j6a042fedle997df133400456@mail.gmail.com>	
 <200808052232.03624.linuxweb@gmx.net>	
 <1217947735.2994.88.camel@moss-spartans.epoch.ncsc.mil>
 <dd18b0c30808050804g3662f22cs8c7c3cba8669cb26@mail.gmail.com>
Subject: Re: Question about newrole
To: "Justin Mattock" <justinmattock@gmail.com>, sds@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


-------- Original-Nachricht --------
> Datum: Tue, 5 Aug 2008 08:04:34 -0700
> Von: "Justin Mattock" <justinmattock@gmail.com>
> An: "Stephen Smalley" <sds@tycho.nsa.gov>
> CC: "Dennis Wronka" <linuxweb@gmx.net>, "Xavier Toth" <txtoth@gmail.com>, "SELinux Mailing List" <selinux@tycho.nsa.gov>
> Betreff: Re: Question about newrole

> On Tue, Aug 5, 2008 at 7:48 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >
> > On Tue, 2008-08-05 at 22:32 +0800, Dennis Wronka wrote:
> >> Thanks.
> >> That seems to help quite a bit.
> >> I now get some messages. For example it seems that newrole wants to
> >> read /etc/shadow directly.
> >> Will check those messages and play around with the policy.
> >
> > The way it works is that pam_unix attempts to open /etc/shadow directly
> > for reading, and if it fails, it falls back to running unix_chkpwd to
> > perform the password check.  SELinux policy prohibits most programs from
> > directly reading /etc/shadow, including even ones that run as root, and
> > forces them to go through unix_chkpwd instead, in order to limit the set
> > of processes that have full read access to the shadow password file.
> >
> > The logic to try to open /etc/shadow and fall back to unix_chkpwd
> > already existed before SELinux in order to support non-root processes
> > re-authenticating the current user.  What changed with SELinux was that
> > it could also happen for root processes.
> >
> > The current policy dontaudit's the attempt to directly read /etc/shadow
> > to avoid noise.  When you did semodule -DB, you turned on that auditing.
> > But those denials are what is expected, and allowing them will mean
> > giving newrole direct read access to /etc/shadow (although that will
> > only work if running as root, of course, as otherwise it has to use a
> > suid helper like unix_chkpwd anyway).
> >
> > Does newrole work for you as a non-root user?
> >
> > --
> > Stephen Smalley
> > National Security Agency
> >
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> > the words "unsubscribe selinux" without quotes as the message.
> >
> 
> I usually just type passwd in a terminal
> and update the database. then choose you're role
> and do the same for that role if need be.
> but depending on what you have, this might be a different case.
> hope this helps.
> regards;
> 
> -- 
> Justin P. Mattock

What I actually want to use newrole for is not resetting passwords. I was thinking to introduce MLS to the next release and thus require the user to transition to secadm_r if he wants to switch from enforcing to permissive.
-- 
GMX startet ShortView.de. Hier findest Du Leute mit Deinen Interessen!
Jetzt dabei sein: http://www.shortview.de/wasistshortview.php?mc=sv_ext_mf@gmx

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
