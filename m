Subject: Re: Content macros v 2 (create implies read in policy)
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: SELinux <SELinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1118864318.25735.43.camel@celtics.boston.redhat.com>
References: <1118744201.3416.13.camel@localhost.localdomain>
	 <1118770918.7853.5.camel@celtics.boston.redhat.com>
	 <1118855232.25735.10.camel@celtics.boston.redhat.com>
	 <1118864318.25735.43.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Wed, 15 Jun 2005 16:04:44 -0400
Message-Id: <1118865884.31840.0.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> 0) Fix apps so they do this printer manipulation in
> their private folders, whether that's in $HOME or in /tmp.
> This requires changing the application code, which is unfortunate.
> I have to investigate whether this is library code or not.
> If the folder is in /tmp, it might require pre-creating more
> folders with a script (or alternative mechanism, when implemented).

So it appears this is all library code, so it might actually
not be hard to do. libgnomeprint and libgnomecups should take
care of all of GNOME, and then I have to investigate how mozilla
handles this...



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
