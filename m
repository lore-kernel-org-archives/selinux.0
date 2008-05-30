Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4ULhQ0E032665
	for <selinux@tycho.nsa.gov>; Fri, 30 May 2008 17:43:26 -0400
Received: from web36607.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m4ULhPUw027868
	for <selinux@tycho.nsa.gov>; Fri, 30 May 2008 21:43:25 GMT
Date: Fri, 30 May 2008 14:43:14 -0700 (PDT)
From: Casey Schaufler <rancidfat@yahoo.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: rbacsep: collapsing xserver
To: Xavier Toth <txtoth@gmail.com>, Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joe Nall <joe@nall.com>, SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40805300758m1fb4c920mb84e49e38a28493a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <983301.23467.qm@web36607.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Xavier Toth <txtoth@gmail.com> wrote:


> >>> From http://www.gnome.org/projects/gdm/docs/2.20/overview.html:
> >>>
> >>> "On Solaris, GDM (since version 2.8.0.3) uses the SDTLOGIN interface
> >>> after user authentication to tell the X server to be restarted as the
> >>> user instead of as root for added security. When the user's session
> >>> exits, the GDM daemon will run the PostSession script as root."
> >>>
> >>> Couldn't we utilize the same functionality on Fedora?
> >>>
> >
> > I've got no problem with doing something like this.  I've already written
> > support for communicating with the X server from pam_selinux.so to set up
> > the user's device labels, so it could also tell the server to setcon
> itself.
> >  That work has stalled because of dependency issues (pam depending on
> > libxcb), getting PAM_XAUTH_DATA support into gdm, and waiting for the next
> > release of libxcb.  But, I can pick up work on it once I finish the X
> Python
> > stuff.
> >
> > With regards to SDTLOGIN, it doesn't look like it restarts the server, only
> > causes it to drop privileges; see
> > http://osdir.com/ml/gnome.gdm.general/2007-10/msg00080.html dated Oct 2007.
> >  The current gdm upstream seems to have dropped support for it.  I did some
> > grepping in the gdm source and couldn't find anything.  It's probably a
> > temporary result of the gdm rewrite.
> >
> 
> Yes, I think Brian mentioned that the server is not actually restarted
> but rather does a setuid/setgid because of the need to be root during
> some portion of the X sever initialization. Hopefully it won't be too
> much trouble to add a setcon too. One question about this is what will
> happen with audit once the X server transition user and context?

Just to offer the other point of view, Trusted Irix restarts the
X server on each login. In addition to how much simpler it makes
the process, doing it this way addresses all object reuse issues
which I dare say calling setcon will not suffice to address.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
