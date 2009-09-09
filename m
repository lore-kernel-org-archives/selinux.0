Subject: Re: opensuse and SELinux = some dbus roblem with xdm/gdm
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss1.tresys.com>
In-Reply-To: <4AA73E25.7080609@gmail.com>
References: <dd18b0c30909081604i2c0231a8q7abf7156eb8938@mail.gmail.com>
	 <4AA73E25.7080609@gmail.com>
Content-Type: text/plain
Date: Wed, 09 Sep 2009 08:55:02 -0400
Message-Id: <1252500902.13634.647.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-09-08 at 22:33 -0700, Justin P. Mattock wrote:
> Justin Mattock wrote:
> > Not sure if this is SELinux/refpolicy
> >
> > Out of curiosity I wanted to setup the latest
> > policy with the latest opensuse.
> > Seems everything has gone o.k. for the moment.
> >
> > The proble Im running into is xdm/gdm seems to crap out
> > with some dbus error message:
> >
> > ** (gdm:1566): WARNING **: Couldn't connect to system bus: An SELinux
> > policy prevents this sender from sending this message to this recipient
> > (rejected message had sender "(unset)" interface "freedesktop.DBus"
> > member "Hello"
> > error name "(unset)" destination "org.freedesktop.DBus")
> >
> > The funny thing with this is with the initial policy load
> > I hadn't relabeled yet, and the system had loaded the policy
> > just fine and xdm worked then once I relabeled this appeared and xdm/gdm
> > just craps out.(the policy is all in permissive mode, giving selinux=0
> > makes the system operate as should).
> >
> > Also not sure if this matters but in
> > /etc/pam.d{gdm,login,xdm) I added
> > pam_selinux.so open/close but had no idea
> > where they should be placed.
> >
> > Any ideas?
> >
> >    
> Shoot I didn't look, but when I do a
> ldd /usr/sbin/gdm I see nothing with libselinux nor
> libaudit.
> 
> loading an ubuntu livecd results in showing
> libselinux.
> 
> my guess since this is a development version they haven't
> enabled SELinux support yet with gdm.
> 
> ohh well, I guess Ill leave it at that.

The gdm selinux support was obsoleted by the gdm rewrite, so it isn't
necessary to link it with libselinux anymore.  It all gets handled by
pam_selinux in /etc/pam.d/gdm.  In Fedora, /etc/pam.d/gdm looks like
this:
#%PAM-1.0
auth     [success=done ignore=ignore default=bad] pam_selinux_permit.so
auth       required    pam_succeed_if.so user != root quiet
auth       required    pam_env.so
auth       substack    system-auth
auth       optional    pam_gnome_keyring.so
account    required    pam_nologin.so
account    include     system-auth
password   include     system-auth
session    required    pam_selinux.so close
session    required    pam_loginuid.so
session    optional    pam_console.so
session    required    pam_selinux.so open
session    optional    pam_keyinit.so force revoke
session    required    pam_namespace.so
session    optional    pam_gnome_keyring.so auto_start
session    include     system-auth

BTW, I would recommend testing the policy package provided by OpenSUSE
to see if it works before trying upstream refpolicy.

And report issues with their SELinux integration to their bugzilla, not
to us.  It won't get fixed if you just post it here.

Are you following the guidance at:
http://en.opensuse.org/SELinux

You have to add an additional repository to pick up their policy and associated packages.

The SELinux integration work seems to be getting tracked on this blog:
http://thetoms-random-thoughts.blogspot.com/search/label/Security

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
