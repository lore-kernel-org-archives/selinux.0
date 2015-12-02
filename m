Date: Wed, 2 Dec 2015 20:47:16 +0100
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: continuation of systemd/SELinux discussion from Github
Message-ID: <20151202194715.GC1028@x250>
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

Here is some chatter about the above i believe:

https://bugs.freedesktop.org/show_bug.cgi?id=83856

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

I cannot answer above currently. I can tell you that obviously one needs
to be able to talk to ones systemd --user instance to be able to tell it
to do anything on ones behalf obviously. So by default all of the above
will likely not work, since they most likely do not have the permissions
to talk to systemd --user even if they were able to execute systemctl
and/or systemd-run.

But even then, things also depend on whether systemd --user runs in a
private domain or the login user domain (in my policy it runs in a
private domain except for unconfined users)

Those are good questions but i do not see how they are directly related
to the question whether systemd --user should be a selinux user space object
manager or not (in my view it obviously should but i am not trusted by
systemd maintainers, walsh is trusted and walsh gave systemd maintainers
the impression that systemd --user does not have to be an selinux object
manager) I strongly suspect that is wrong.

If you can give me a really simple example to test some of the above
then i can try it out and report back.

One can obviously also just try my policy out as per

https://github.com/defensec/dssp/wiki

and see for ones self. Its not fedora policy but atleast my policy
supports systemd --user

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

iQGcBAEBCgAGBQJWX0q/AAoJENAR6kfG5xmco1AMAKAu6NJNZsTChlTAZsJ21VWF
gifU/8iCBwz4DBNsdzw7v9dysNl1rymtgV+516KgZe3liB8jYhAwKcFzIPMUo0uc
uRy9XDbYUO00O0z1qx6IDxixnKiXKHTCjsEBLiHQcS71eD31ry7sr49JBr9O0LA8
0RkgodYtAjh4xf2zw4SEPJudsPm3YJrxgp82FA2JnXLIO3352ecuvoaAGlBtsTG2
0IDx0RyxGu7HlXc8cc5d2lN5wpE9JM4gZucXWZI7ArLIQa0cuM/jlUxUvWPPFin/
OZFT6GDL+PGJz12M7AfwLAu/lVzUJDFPFFfrMEBZhxnDlHvHzwJAupR1ENzMIefn
L1JjS6BAXpv05yTOJZ2r8cHipCBG3ju6peG40At72tVQsv+oY2/pBAbYDlOnViNa
iFA8YshSwFte8W2V2nqAqOQu04DDKf9qAgsdqbRR7SihUj/taV5nmNWbtVMkQIo6
BbQOw7IERsJnMxVM0lQ1JYQzQGRTaPMrUk//iH4vmw==
=lQZD
-----END PGP SIGNATURE-----
