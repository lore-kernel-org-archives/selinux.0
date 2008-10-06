Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m96H1mT0030550
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2008 13:01:48 -0400
Received: from dmzms99802.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m96H0ccv024574
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2008 17:00:39 GMT
Message-Id: <738m08$luidl@dmzms99802.na.baesystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: user guide drafts: "Working with SELinux" sections
Date: Mon, 6 Oct 2008 10:01:45 -0700
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <Valdis.Kletnieks@vt.edu>, "Murray McAllister" <mmcallis@redhat.com>
Cc: "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On
> Behalf Of Valdis.Kletnieks@vt.edu
> Sent: Tuesday, September 30, 2008 9:00 PM
> To: Murray McAllister
> Cc: SE Linux
> Subject: Re: user guide drafts: "Working with SELinux" sections
> 
> On Wed, 01 Oct 2008 10:19:15 +1000, Murray McAllister said:
> 
> > > Erm. What *exactly* produces that entry in /var/log/messages?
> > Are you referring to SELinux denying access or
setroubelshoot-server?
> > > AVC stuff ends up in auditd.  Or is this just because the
> setroubleshoot
> > > RPMs aren't *quite* as mandatory as you noted above, and I don't
see
> those
> > > messages because I don't have them installed *and enabled*? (Gotta
> watch
> > > out for those pesky 'chkconfig off' ;)
> > I thought I tried this before writing (thinking it only went into
> > audit.log if setroubleshoot-server was installed, otherwise it would
go
> > to /var/log/messages). I will fix the text up to reflect this...
> 
> AVC's go into dmesg (and wherever your syslog dumps that) if auditd
isn't
> running.
> 
> AVC's goes into audit.log if auditd *is* running.
> 
> If setroubleshoot is running, it reads audit.log and pretty-prints
them
> into the syslog.
> 
> > This is coming next in a separate chapter. Why can't you do much
with
> > MCS if everyone is user_u? Doesn't it use the level, not the
> user/role/type?
> 
> Whether you're using either the level or the classification, you need
to
> be
> able to run users at different levels/classes for it to do any real
good:
> 
> Consider:
> 
> User1 can read classes A, B, C.
> User2 can read classes B, D, E.
> User3 can read classes A, B, and E.
> 
> Wow.  That works pretty nice.
> 
> Now consider if you only have 1 defined user for people to run as:
> 
> User_u can read classes A, B, C.
> User_u can read classes B, D, E.
> User_u can read.. oh nevermind. ;)
> 
> So you need to be able to say "userid fred runs as user1, userid joe
runs
> as user2, userid dept-paperwork runs as user3/levelA, userid
dept-admin
> runs
> as user3/levelB", and so on....
> 
> The stock MCS policy provides enough user classes and levels to
protect
> the
> *system* from users - but you need to roll-your-own to protect user
data
> to
> a similar level.

Even with all users mapped to selinux user user_u, mcs should still be
able to be used effectively. While it is true that in the case above,
user_u would need to be given access to all the compartments (A - E),
that does not mean that individual linux users (as opposed to the
selinux user user_u) must have access to all the compartments.
Individual linux users can be given access to only a subset of the
compartments through the "semanange login ..." command. The compartments
that individual linux users have access to can be seen using "semanage
login -l", and can be set by either adding or modifying a user with
"semanage login ...". For example:

semanage login -a -s user_u -r A joe

gives the linux user joe, access only to compartment A, even though his
linux user maps to the selinux user user_u, which has access to
compartments A-E



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
