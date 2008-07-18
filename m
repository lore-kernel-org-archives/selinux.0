Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6IIFRdP006582
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 14:15:27 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m6IIFQ29015191
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 18:15:26 GMT
Subject: Re: refpolicy patch: samba enhancements
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Mike Edenfield <kutulu@kutulu.org>,
        SELinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <4880D5FC.5030400@redhat.com>
References: <487BB78D.6080500@kutulu.org>  <4880D5FC.5030400@redhat.com>
Content-Type: text/plain
Date: Fri, 18 Jul 2008 14:14:59 -0400
Message-Id: <1216404899.21191.175.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-07-18 at 13:42 -0400, Daniel J Walsh wrote:
> Mike Edenfield wrote:
> > I apologize if I'm not doing this right, I'm kinda new at this...
> > 
> > I have made some changes to the SELinux policy for our intranet servers
> > that I thought might be useful to a broader audience.  Included below is
> > a patch to the latest refpolicy.  This has been tested on the Gentoo
> > systems we have here; I don't have easy access to other SELinux systems
> > at the moment.  It does the following:
[...]
> > * Adds a tunable that lets samba create home directories via pam_mkhomedir

> Could you do this with pam_oddjob_mkhomedir without having to add the
> privs.  I think this is a better solution.

What if you don't have oddjob?  It doesn't hurt to have the perms in a
tunable.  It could be put in a ifndef distro_redhat, if samba in
fedora/rh requires pam_oddjob_mkhomedir.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
