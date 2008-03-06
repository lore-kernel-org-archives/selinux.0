Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m26ClP2N008616
	for <selinux@tycho.nsa.gov>; Thu, 6 Mar 2008 07:47:25 -0500
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m26ClEwu016311
	for <selinux@tycho.nsa.gov>; Thu, 6 Mar 2008 12:47:19 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: [DSE-Dev] refpolicy: domains need access to the apt's pty and fifos
Date: Thu, 6 Mar 2008 23:46:54 +1100
Cc: =?utf-8?q?V=C3=A1clav_Ovs=C3=ADk?= <vaclav.ovsik@i.cz>,
        selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
References: <20080305152322.GA9988@bobek.pm.i.cz> <200803062117.20441.russell@coker.com.au> <1204805640.5885.4.camel@hepcat.vitavonni.de>
In-Reply-To: <1204805640.5885.4.camel@hepcat.vitavonni.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200803062346.58639.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 06 March 2008 23:13, Erich Schubert <erich@debian.org> wrote:
> > > It would definitely help to have separate apt_t and apt_script_t
> > > domains, though, to be able to differentiate access for installation
> > > scripts and the package manager itself.
> >
> > What meaningful restrictions can be applied to one but not the other?
>
> I agree with you that we would currently have to allow pretty much any
> access by apt_script_t, unfortunately. Sorry for mixing up apt and dpkg
> again in that post btw, yes, it sould be dpkg_t and dpkg_script_t,
> obviously.
> No, I can't really think of ways to restrict dpkg_script_t apart from
> not messing with the dpkg_t state files. Maybe we could make some policy

But given that dpkg_script_t can make all manner of other changes (including 
loading a SE Linux policy) it seems rather minor to restrict access to dpkg 
state files.

> that /usr is to be modified by dpkg_t only whereas dynamically generated
> files have to reside in /var, but I doubt this would currently hold.

It's a standard practice to convert the data files under /var in an upgrade.

> And after all, dpkg_script_t needs to be able to even add users
> to /etc/passwd (although through the helper applications, not directly).

Yes.

In fact while we have unconfined_t, the benefit of having a separate dpkg_t 
instead of using unconfined_t for installing packages doesn't seem 
significant.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
