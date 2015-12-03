Date: Thu, 3 Dec 2015 18:30:28 +0100
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Miroslav Grepl <mgrepl@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: continuation of systemd/SELinux discussion from Github
Message-ID: <20151203173027.GC29999@x250>
References: <20151202101801.GA1028@x250> <565F366E.3030403@tycho.nsa.gov>
 <20151202194715.GC1028@x250> <565F6167.5090507@tycho.nsa.gov>
 <56606797.1070609@redhat.com> <566069A6.9080701@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <566069A6.9080701@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Thu, Dec 03, 2015 at 11:11:18AM -0500, Stephen Smalley wrote:
> On 12/03/2015 11:02 AM, Miroslav Grepl wrote:
> >On 12/02/2015 10:23 PM, Stephen Smalley wrote:
> >>On 12/02/2015 02:47 PM, Dominick Grift wrote:
> >>>On Wed, Dec 02, 2015 at 01:20:30PM -0500, Stephen Smalley wrote:
> >>>>On 12/02/2015 05:18 AM, Dominick Grift wrote:
> >>>>>Let's continue the discussion here.
> >>>>>
> >>>>>The last answered questionnaire is below, any further questions or
> >>>>>comments?:
> >>>>>
> >>>>>----------------------------------------
> >>>>>
> >>>>>          "systemd --user" concept is broken as we can see/read from
> >>>>>this
> >>>>>          thread from SELinux point of view.
> >>>>>
> >>>>>It was working fine except that it was trying to log to the audit
> >>>>>system
> >>>>>which unprivileged processes arent allowed to do.
> >>>
> >>>>What's the dbus solution for this issue?
> >>>
> >>>Here is some chatter about the above i believe:
> >>>
> >>>https://bugs.freedesktop.org/show_bug.cgi?id=83856
> >>
> >>The code is easier to follow. bus/audit.c:bus_audit_init() will only
> >>open the audit socket if the process has CAP_AUDIT_WRITE.
> >>bus/selinux.c:log_callback() will only try to send the message to audit
> >>if the audit socket was opened, but will always send the message to
> >>syslog regardless.  Thus, if the dbus-daemon instance has
> >>CAP_AUDIT_WRITE, you get the messages logged to audit and syslog;
> >>otherwise, you only get them in syslog.  This is the most general
> >>approach, as it supports both privileged and unprivileged dbus-daemon
> >>instances, including the case where the system-wide bus is running in a
> >>container and does not have CAP_AUDIT_WRITE (even though it thinks it is
> >>root / uid 0) and the case where the session bus has CAP_AUDIT_WRITE (if
> >>one were to set cap_audit_write in the file capabilities on the
> >>dbus-daemon executable, not recommended but possible), as well as the
> >>more common cases of a system-wide bus with CAP_AUDIT_WRITE and a
> >>session bus without it.  systemd should likely do something similar, but
> >>using the journal.
> >>
> >>>
> >>>
> >>>>>
> >>>>>          Are we able truly explain the enforcement here?
> >>>>>
> >>>>>I think i was able to at least identify some of it, but i probably have
> >>>>>overlooked other compelling arguments:
> >>>>>
> >>>>>Any processes that needs to be able to "control" any system-wide
> >>>>>systemd
> >>>>>user unit, will be able to "control" all system-wide systemd user
> >>>>>units.
> >>>>>
> >>>>>In practice that means that a process may be able to for example
> >>>>>start a
> >>>>>application even though it does not have access to execute that
> >>>>>application by telling systemd --user do start that applications on its
> >>>>>behalf
> >>>
> >>>>Can systemd-run --user be used to escape any of the following:
> >>>>a) SELinux sandbox,
> >>>>b) libvirt / svirt confinement,
> >>>>c) newrole -r to a different, more restricted role or -l to a different
> >>>>level,
> >>>>d) runcon to a more restricted domain.
> >>>
> >>>>If so, then there is a problem with systemd --user not applying its own
> >>>>access controls over its operations.
> >>>
> >>>
> >>>I cannot answer above currently. I can tell you that obviously one needs
> >>>to be able to talk to ones systemd --user instance to be able to tell it
> >>>to do anything on ones behalf obviously. So by default all of the above
> >>>will likely not work, since they most likely do not have the permissions
> >>>to talk to systemd --user even if they were able to execute systemctl
> >>>and/or systemd-run.
> >>>
> >>>But even then, things also depend on whether systemd --user runs in a
> >>>private domain or the login user domain (in my policy it runs in a
> >>>private domain except for unconfined users)
> >>>
> >>>Those are good questions but i do not see how they are directly related
> >>>to the question whether systemd --user should be a selinux user space
> >>>object
> >>>manager or not (in my view it obviously should but i am not trusted by
> >>>systemd maintainers, walsh is trusted and walsh gave systemd maintainers
> >>>the impression that systemd --user does not have to be an selinux object
> >>>manager) I strongly suspect that is wrong.
> >>
> >>I cited those examples because they were applicable to the stock Fedora
> >>policy and, if valid, would provide a rationale for restoring the
> >>controls regardless of what one might believe about confining desktop
> >>applications because they would indicate vulnerabilities or regressions
> >>in functionality provided by Fedora.  That seemed more likely to be
> >>convincing to the Fedora SELinux maintainers.
> >>
> >>For sandbox, they don't appear to allow it to connect in the first place:
> >>
> >>$ sandbox /bin/bash
> >>bash-4.3$ systemd-run --user id
> >>Failed to create bus connection: Permission denied
> >>
> >>So there the systemd access controls wouldn't come into play.
> >>
> >>For confined user roles, systemd-run --user <command> failed on Fedora
> >>22 with:
> >>
> >>Failed to start transient service unit: Access denied
> >>
> >>and journalctl showed:
> >>
> >>systemd[15007]: Can't send to audit system: USER_AVC avc:  denied  {
> >>start } for auid=N uid=N gid=N
> >>path="/run/user/N/systemd/user/run-PID.service" cmdline="systemd-run
> >>--user id" scontext=staff_u:staff_r:staff_t:s0-s0:c0.c1023
> >>tcontext=system_u:object_r:user_tmp_t:s0 tclass=service
> >>
> >>So removing the systemd --user controls is a regression in the
> >>protection being provided in Fedora, IIUC, although I'll let the Fedora
> >>SELinux maintainers speak to that.
> >
> >First I would like to talk about non-working "systemd --user" because we
> >lack a support of pam_selinux in F23. So if you allow confined users to
> >start user services you will end up with unconfined_service_t. Which is
> >wrong because of systemd --user is running as init_t. The object manager
> >helps here indeed.
> >
> >We have pam_selinux support in F24 and theoretically you will end up
> >with a correct user context. But without missing object manager you will
> >be able to start user services under SELinux user context and under a
> >user Linux identity.
> >
> >This is a reason why I told this is broken now. We have more regressions
> >here. And I believe that first we would have systemd --user running with
> >correct labeling. We have it working for unconfined users on the latest
> >rawhide because we removed unconfined_domain attribute for init_t and
> >added needed fixes.
> >
> >The second issue is missing object manager. It is strongly related to
> >confined SELinux users who are defined by own restricted SELinux
> >policies and still restricted by own Linux identity.
> >
> >If we have running 'systemd --user' with the correct user type
> >pam_selinux support then we can experiment and make working SELinux
> >object manager in systemd --user at all if it is used and requested widely.
> 
> So, what is needed for correct systemd --user pam_selinux support still?
> Has anything been done wrt eliminating usage of security_compute_user()?
> Are you blocked on that?
> 

I think it is still (kind of) an issue. Here is some chatter about it:

https://github.com/fedora-selinux/selinux-policy/commit/7516138078d9c9048e49fe1abfa2a7dd85e3d14b#commitcomment-14376880

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

iQGcBAEBCgAGBQJWYHwuAAoJENAR6kfG5xmcfLYL/jz36K9xpLqTKD8JgM/hYocD
hfxGq9wd89tLFX5Eg+bJrT1WAq9m0q2MMNT+JoEgPJWQw1eLGCEDd3ZejuSOrU8w
Mc2L3zZhbfxgQmIv8lsxsyN/a5miM9q5A2bdbmwIlbLPgW2Mwz/vTl1hTJm9bMqT
8+0tbwVz3+DAQHyY3G2jyMs9c2Q2U0yut2kAWzmkn0Z2W78PJwpdwUNNENqFUaxD
o3EKuO8XUP6aUuyrOWkH+WC5Z2TcvxQHYAq/8KheyjM+q9uqajpWmf30YRFDseSf
PjMVvnPuCtyaIHWHfOwFaedRQnqsvn7NmvpLfH+PNw4hvi0uBoocp3GB1O2wxnng
Om2hua1iWi3e7HizhP94bjU4AYsQJlgeWQKUW6Sak6Pmi/tCSbA1QPI/KkWhcftC
qeHFaZtzfLOwik4bcwkcvh0KdJjImTOlpsSLduBbmTIqUe8DohXCKJ+4S+STZtSI
62kW7RMi1fTlJf+brtlIiMVpB2E8fmuhanFM6T3cmg==
=0aRS
-----END PGP SIGNATURE-----
