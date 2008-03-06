Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m26CE8mb003650
	for <selinux@tycho.nsa.gov>; Thu, 6 Mar 2008 07:14:08 -0500
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m26CE4w3011855
	for <selinux@tycho.nsa.gov>; Thu, 6 Mar 2008 12:14:05 GMT
Subject: Re: [DSE-Dev] refpolicy: domains need access to the apt's pty and
	fifos
From: Erich Schubert <erich@debian.org>
To: russell@coker.com.au
Cc: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>,
        selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
In-Reply-To: <200803062117.20441.russell@coker.com.au>
References: <20080305152322.GA9988@bobek.pm.i.cz>
	 <1204734268.12784.124.camel@hepcat.vitavonni.de>
	 <200803062117.20441.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 06 Mar 2008 13:13:59 +0100
Message-Id: <1204805640.5885.4.camel@hepcat.vitavonni.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Russel,
> > It would definitely help to have separate apt_t and apt_script_t
> > domains, though, to be able to differentiate access for installation
> > scripts and the package manager itself.
> What meaningful restrictions can be applied to one but not the other?

I agree with you that we would currently have to allow pretty much any
access by apt_script_t, unfortunately. Sorry for mixing up apt and dpkg
again in that post btw, yes, it sould be dpkg_t and dpkg_script_t,
obviously.
No, I can't really think of ways to restrict dpkg_script_t apart from
not messing with the dpkg_t state files. Maybe we could make some policy
that /usr is to be modified by dpkg_t only whereas dynamically generated
files have to reside in /var, but I doubt this would currently hold.
And after all, dpkg_script_t needs to be able to even add users
to /etc/passwd (although through the helper applications, not directly).

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C     (o_
 The early bird gets the worm, but the second mouse gets the cheese.  //\
       Ein Freund ist ein Geschenk, das man sich selbst macht.        V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
