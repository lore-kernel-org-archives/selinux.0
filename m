Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB5FrqZ2004317
	for <selinux@tycho.nsa.gov>; Tue, 5 Dec 2006 10:53:52 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB5Fq7u3026401
	for <selinux@tycho.nsa.gov>; Tue, 5 Dec 2006 15:52:07 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id kB5FpKsM004476
	for <selinux@tycho.nsa.gov>; Tue, 5 Dec 2006 10:51:20 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id kB5FpK2k004475
	for selinux@tycho.nsa.gov; Tue, 5 Dec 2006 10:51:20 -0500
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB42d2oP001412
	for <selinux@tycho.nsa.gov>; Sun, 3 Dec 2006 21:39:02 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB42bHcg020800
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 02:37:18 GMT
From: "David O'Brien" <david.obrien@redhat.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: User home directory creation with useradd (rhbz#217441)
Date: Mon, 4 Dec 2006 12:39:21 +1000
Cc: James Antill <jantill@redhat.com>, selinux@tycho.nsa.gov
References: <1165003691.18588.103.camel@code.and.org> <45708F0B.6080405@mentalrootkit.com>
In-Reply-To: <45708F0B.6080405@mentalrootkit.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612041239.21597.david.obrien@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 02 December 2006 06:22, Karl MacMillan wrote:
> James Antill wrote:
> >  As some of you know, there's an open BZ about the fact that in a
> > strict/MLS environment useradd doesn't create the user's homedir with
> > the correct context[1].
> >  The problem is that matchpathcon() needs semanage to have run, so we
> > know what SELinux user the unix user is associated with, but that runs
> > separately and after useradd. The four obvious solutions are:
> >
> > 1. Have an option for useradd to call semanage to add the selinux user,
> > and then do the restorecon.
>
> I think this is the best option, though there needs to be additional
> flags to useradd added to allow the setting or roles.
>
> > 2. Have semanage do the equivalent of a restorecon when doing an
> > add/modify (or just add) of SELinux user information.
>
> I think this is needed in addition to one for changes to users. Should
> be optional (but perhaps on by default) since the operating is
> potentially expensive.
>
> > 3. Have some kind of wrapper that does:
> >  i. useradd
> >  ii. semanage
> >  iii. restorecon
>
> Setools used to include something like this - didn't get much use that I
> am aware of because no one knew it was there. I would prefer patching
> the default tools.
>
> > 4. Document that you need to call the list of programs in #3.
>
> Nobody reads documentation - this isn't viable.  <--------  !!

Karl... be nice. Tech writers are sensitive beings  ;-)


-- 
David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
