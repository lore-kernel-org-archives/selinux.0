Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA21186
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2002 08:50:14 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA15156
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2002 13:49:22 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA15152 for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2002 13:49:22 GMT
Date: Tue, 22 Jan 2002 08:49:58 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: starting daemons under Debian
In-Reply-To: <20020118230436.2772532FA2C@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0201220838400.9412-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 19 Jan 2002, Russell Coker wrote:

> I am considering how to make SE Linux integrate smoothly with Debian
> regarding the startup of daemons.
>
> Requiring everyone to change all their init scripts is out of the question of
> course.
>
> One thing I have played with is setting the security contexts so that the
> daemon automatically changes to the correct domain on startup from the
> sysadm_t domain such as the following (and also a minor matching change to
> rbac to make it allow root:sysadm_r:sshd_t):
>
> domain_auto_trans(sysadm_t , sshd_exec_t, sshd_t)
>
> This is minorly ugly, involves more rules than I'd like, but has the benefit
> that running "sshd" at the command line gets the same result as
> "/etc/init.d/ssh start".
>
> The other option is to divert /sbin/start-stop-daemon which is used by Debian
> for starting most (should be all) daemons.  Then my replacement script would
> call run_init to run the real start-stop-daemon.
>
> Any comments on the relative merits of these two schemes?
>
> I realise that the recommended way is probably run_init (it was written for a
> reason), but how bad an idea is it to not use it?

Obviously, we would recommend using run_init.  The other scheme has the
following limitations:
1) It only sets the domain of the daemon process, not the user identity or
role, whereas run_init ensures that the complete security context is set
correctly,
2) It doesn't provide any safeguard to ensure that the administrator truly
wants to start or restart a system process (as opposed to some malicious
code run by the administrator), whereas run_init requires the
administrator to re-authenticate to confirm the action,
3) It requires significant duplication of rules between the initrc_t
domain and the sysadm_t domain.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
