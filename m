Subject: Re: Bug (?) in cvs selinux policy
From: Antoine Martin <antoine@nagafix.co.uk>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Erich Schubert <erich@debian.org>, SELinux@tycho.nsa.gov,
   Jason Vas Dias <jvdias@redhat.com>
In-Reply-To: <438C8A3C.5070904@redhat.com>
References: <1132968448.701.1.camel@wintermute.xmldesign.de>
	 <438C8A3C.5070904@redhat.com>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 17:54:49 +0000
Message-Id: <1133286889.9826.32.camel@ant.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-29 at 12:05 -0500, Daniel J Walsh wrote:
> Erich Schubert wrote:
> > Hi,
> > while merging the current policy CVS in my local policy, I noticed this:
> > ---
> > tail -1 domains/program/unused/dhcpc.te
> > allow dhcpc_t locale_t:file write;
> > ---
> >
> > Why? If this is some locale caching or so, it probably should be
> > use_locale(dhcpc_t) or something like that. But this single write here
> > is really odd...
> >
> > best regards,
> > Erich Schubert
> >   
> I think this allows it to cp the locale file into the chroot environment.
> 
Surely this should be done at setup time? Not by dhcpd itself.
My dhcp policy does not have it (dhcpd 3.0.1-r1) and is fine without it.

Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
