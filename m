Subject: Re: Bug (?) in cvs selinux policy
From: Antoine Martin <antoine@nagafix.co.uk>
To: Erich Schubert <erich@debian.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux@tycho.nsa.gov,
   Jason Vas Dias <jvdias@redhat.com>
In-Reply-To: <1133305918.20990.5.camel@wintermute.xmldesign.de>
References: <1132968448.701.1.camel@wintermute.xmldesign.de>
	 <438C8A3C.5070904@redhat.com>
	 <1133305918.20990.5.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 23:29:46 +0000
Message-Id: <1133306986.13162.45.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-30 at 00:11 +0100, Erich Schubert wrote:
> Hello,
> > I think this allows it to cp the locale file into the chroot environment.
> 
> For example with postfix, running stuff in a chroot is "deprecated" with
> SELinux, since the security implicatons of setting up the chroot are
> higher than not running a chroot but only SELinux. ;-)
I personally like to have the option of using both, for peace of mind.
I am not good enough to run my systems in full enforcing mode constantly
(there are still some maintenance tasks that I do which are much easier
to handle by switching to permissive mode) and so I like to have the
ability to cumulate the security measures.

Antoine

> Also, the setup should probably done by the init script, not by the
> daemon.
> 
> best regards,
> Erich Schubert


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
