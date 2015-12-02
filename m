Date: Wed, 2 Dec 2015 21:34:34 +0100
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: continuation of systemd/SELinux discussion from Github
Message-ID: <20151202203433.GD1028@x250>
References: <20151202101801.GA1028@x250>
 <565F366E.3030403@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <565F366E.3030403@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, Dec 02, 2015 at 01:20:30PM -0500, Stephen Smalley wrote:
> On 12/02/2015 05:18 AM, Dominick Grift wrote:
> >Let's continue the discussion here.
> >
> >The last answered questionnaire is below, any further questions or
> >comments?:
> >
> >----------------------------------------
> >
> >         "systemd --user" concept is broken as we can see/read from this
> >         thread from SELinux point of view.
> >
> >It was working fine except that it was trying to log to the audit system
> >which unprivileged processes arent allowed to do.
> 
> What's the dbus solution for this issue?

I vaguely recall XACE logging its avc denials to xorg.log.N instead of
using the audit system, I might be wrong, and also since then xserver runs unprivileged so I am not sure if
anything has changed and whether that still works ( I would need to try
that out since i have XACE disabled ).

I suppose an option for systemd --user would be to log avc denials to journal
instead of audit

> 
> >
> >         Are we able truly explain the enforcement here?
> >
> >I think i was able to at least identify some of it, but i probably have
> >overlooked other compelling arguments:
> >
> >Any processes that needs to be able to "control" any system-wide systemd
> >user unit, will be able to "control" all system-wide systemd user units.
> >
> >In practice that means that a process may be able to for example start a
> >application even though it does not have access to execute that
> >application by telling systemd --user do start that applications on its
> >behalf
> 
> Can systemd-run --user be used to escape any of the following:
> a) SELinux sandbox,
> b) libvirt / svirt confinement,
> c) newrole -r to a different, more restricted role or -l to a different
> level,
> d) runcon to a more restricted domain.
> 
> If so, then there is a problem with systemd --user not applying its own
> access controls over its operations.
> 
> >
> >A process may, for example, be able to use this to stop a sensitive
> >process bypassing SELinux access control
> >
> >         And the point is if we have big benefits of this level of
> >         isolation?
> >
> >With access control the benefits often depend on the requirements. but
> >in general since selinux touts flexibility and one of the big benefits
> >here is that we can contain access of processes to units actions.
> >
> >without this processes are potentially able to bypass selinux by telling
> >systemd --user to do stuff on their behalf
> >
> >         Do we have real examples how it prevents possible security
> >         flaws?
> >
> >No, and why should we? SELinux does not prevent possible security
> >flaws. SELinux is Linux access control extension
> >It enforces integrity and optional confidentiality or
> >comparmentalization.
> >
> >         Do we talk about confined desktop here?
> >
> >No we are talking about a set of components that without SELinux access
> >control extension potentionally allows processes
> >to bypass SELinux access control restrictions in some cases
> >
> >_______________________________________________
> >Selinux mailing list
> >Selinux@tycho.nsa.gov
> >To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> >To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> >
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWX1XVAAoJENAR6kfG5xmcyDUL/ArLiJcoTl/mTJEr88xGE2yi
EmE5vWjHQ87DpRg7A/lgUynxfzZ/mETNtS58yvHY0J8x9SnqnQvAlg5xrtIj+V1w
FWCTGuqqaFw2EM0QY0FXruUHXWgg3eRiQRUgs9r7q5iOAvG4fM0DkVTOURc7XkgC
OVdUPRDnRbNH5cGJvUWwUkRRQ+9Ohr4lMSU+J0pp3NkZN+TswTpptGjbc1SI6tXU
4aRZ/CIEl22uTHNtI7/l67+cL6WnKaQ4iEcGmm2UMg33m0oH0FhRs5XspeEVq2ec
zNk80g58v6dinu3YdEPapIp3KjNU9IJVrmlRzFl5kcOmSYmdS/xuethG8w+TV+5q
Rs0bBT7dATOf06j0ZvcgQ+gaALTYwRXp94yK6V7e9AU+f6cFjhPMPyrQu8D1lUZO
LszlO9BNhmONO+bjG3vcuW315l1W/MjYZAu7ZCPM7cAYayO3sd/BLe1TJlknPLWd
/qv14mtfJPLK3TuABIiQW3LUjVbiQwwroW1wZjV/TA==
=HGnK
-----END PGP SIGNATURE-----
