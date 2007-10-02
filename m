Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l92Drqne018640
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2007 09:53:52 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l92DrmA2029734
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2007 13:53:48 GMT
Message-ID: <47024D25.4000102@redhat.com>
Date: Tue, 02 Oct 2007 09:52:37 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Michael Klinosky <mpk2@enter.net>
CC: SElinux <selinux@tycho.nsa.gov>
Subject: Re: ftpd is denied access to a dir
References: <47019EAF.4050009@enter.net>
In-Reply-To: <47019EAF.4050009@enter.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Michael Klinosky wrote:
> I have Fedora 7, using gnome. (Btw: when I hunted for SElinux maillists,
> I didn't find one for Fedora specificallly. Is there a website?)
> 
> I installed pure-ftpd on my personal computer (for my own use). It's
> version 1.0.21-12, and there's an SElinux package for it (both listed in
> the package manager).
> 
> When I run the server as a xinetd service, and attempt a unix-style log
> in (with gftp, on my LAN), I get this from gftp:
> 
> Connected to 10.0.0.50:21
> 220 (text)
> 220 (text)
> USER mpk
> 331 user mpk OK. Password required.
> PASS xxxx
> 530 user authentication failed
> Disconnected from 10.0.0.50.
> 
> On 10.0.0.50, this is in the SElinux troubleshooter:
> 
>>> ALERT 1
> 
> Summary
>     SELinux is preventing the ftp daemon from writing files outside the
> home directory (pure-ftpd).
> 
> Detailed Description
>     SELinux has denied the ftp daemon write access to directories
> outside the home directory (pure-ftpd). Someone has logged in via your
> ftp daemon and is trying to create or write a file. If you only setup
> ftp to allow anonymous ftp, this could signal a intrusion attempt.
> 
> Allowing Access
>     If you do not want SELinux preventing ftp from writing files
> anywhere on the system you need to turn on the allow_ftpd_full_access
> boolean:
> "setsebool -P allow_ftpd_full_access=1"
> 
>     The following command will allow this access:
>     setsebool -P allow_ftpd_full_access=1
> 
> Additional Information
> 
> Source Context                user_u:system_r:ftpd_t
> Target Context                user_u:object_r:var_run_t
> Target Objects                pure-ftpd [ dir ]
> Affected RPM Packages         pure-ftpd-1.0.21-12.fc7 [application]
> Policy RPM                    selinux-policy-2.6.4-8.fc7
> Selinux Enabled               True
> Policy Type                   targeted
> MLS Enabled                   True
> Enforcing Mode                Enforcing
> Plugin Name                   plugins.allow_ftpd_full_access
> Host Name                     d500.localdomain
> Platform                      Linux d500.localdomain 2.6.21-1.3228.fc7
> #1 SMP  Tue Jun 12 15:37:31 EDT 2007 i686 i686
> Alert Count                   6
> First Seen                    Sat 25 Aug 2007 09:54:58 AM EDT
> Last Seen                     Sat 25 Aug 2007 10:30:03 AM EDT
> Local ID                      a8f17786-d787-4b38-86a2-ce3309391690
> Line Numbers
> 
> Raw Audit Messages
> 
> avc: denied { create } for comm="pure-ftpd" egid=0 euid=0
> exe="/usr/sbin/pure-
> ftpd" exit=-13 fsgid=0 fsuid=0 gid=0 items=0 name="pure-ftpd" pid=28641
> scontext=user_u:system_r:ftpd_t:s0 sgid=0 subj=user_u:system_r:ftpd_t:s0
> suid=0 tclass=dir tcontext=user_u:object_r:var_run_t:s0 tty=(none) uid=0
> 
> **
> 
> I issued that command, and it apparently worked (no complaint displayed).
> 
>>> ALERT 2
> 
> Summary
>     SELinux is preventing /usr/sbin/pure-ftpd (ftpd_t) "search" to net
> (proc_net_t).
> 
> Detailed Description
>     SELinux denied access requested by /usr/sbin/pure-ftpd. It is not
> expected that this access is required by /usr/sbin/pure-ftpd and this
> access may signal an intrusion attempt. It is also possible that the
> specific version or configuration of the application is causing it to
> require additional access.
> Allowing Access
>     Sometimes labeling problems can cause SELinux denials. You could
> try to restore the default system file context for net, restorecon -v
> net If this does not work, there is currently no automatic way to allow
> this access. Instead, you can generate a local policy module to allow
> this access - see
> http://fedora.redhat.com/docs/selinux-faq-fc5/#id2961385 Or you can
> disable SELinux protection altogether. Disabling SELinux protection is
> not recommended. Please file a
> http://bugzilla.redhat.com/bugzilla/enter_bug.cgi
> against this package.
> 
> Additional Information
> Source Context                user_u:system_r:ftpd_t
> Target Context                system_u:object_r:proc_net_t
> Target Objects                net [ dir ]
> Affected RPM Packages         pure-ftpd-1.0.21-12.fc7 [application]
> Policy RPM                    selinux-policy-2.6.4-8.fc7
> Selinux Enabled               True
> Policy Type                   targeted
> MLS Enabled                   True
> Enforcing Mode                Enforcing
> Plugin Name                   plugins.catchall_file
> Host Name                     d500.localdomain
> Platform                      Linux d500.localdomain 2.6.21-1.3228.fc7
> #1 SMP  Tue Jun 12 15:37:31 EDT 2007 i686 i686
> Alert Count                   12
> First Seen                    Thu 30 Aug 2007 09:26:07 PM EDT
> Last Seen                     Thu 06 Sep 2007 09:30:33 PM EDT
> Local ID                      8958c16e-27eb-4d3f-ad5c-787c1a960769
> Line Numbers
> 
> Raw Audit Messages
> avc: denied { search } for comm="pure-ftpd" dev=proc egid=0 euid=0
> exe="/usr/sbin/pure-ftpd" exit=-13 fsgid=0 fsuid=0 gid=0 items=0 name="net"
> pid=19097 scontext=user_u:system_r:ftpd_t:s0 sgid=0
> subj=user_u:system_r:ftpd_t:s0 suid=0 tclass=dir
> tcontext=system_u:object_r:proc_net_t:s0 tty=(none) uid=0
> 
> **
> 
> I tried to allow access; I saw that there is a directory 'net' in proc:
> [root@d500 proc]# restorecon -v net
> lstat(net) failed: Permission denied
> 
> Now what? Did I do this wrong, or do I need to create a 'local policy
> module'?
> 
> Btw - if I run pure-ftpd as a standalone, I can login fine (but I don't
> want to).
> 
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
Well first thing I would do is update to the latest selinux policy

yum upgrade selinux-policy

That might fix some/all of your problems.

It probably would be a good idea to update all of the fedora packages.

yum upgrade


Looking at the current policy the creation of the pid file (var_run_t)
should be allowed.  The second avc is fixed in Fedora 8/Rawhide but not
in FC7.  So I will add it in the next update.

A better list to ask about Fedora SELinux questions is
"Fedora SELinux support list for users & developers."
<fedora-selinux-list@redhat.com>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHAk0krlYvE4MpobMRAkWcAJ0Yh3HPZE3jCvZfvqOXI/FmxdSTcgCgkN7h
VcKEfGjvct44CQ+y086hPY0=
=tatZ
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
