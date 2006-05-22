Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4MI35eO022762
	for <selinux@tycho.nsa.gov>; Mon, 22 May 2006 14:03:05 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4MI31dN004403
	for <selinux@tycho.nsa.gov>; Mon, 22 May 2006 18:03:04 GMT
Received: by wr-out-0506.google.com with SMTP id 36so1108829wra
        for <selinux@tycho.nsa.gov>; Mon, 22 May 2006 11:03:01 -0700 (PDT)
Message-ID: <4471FCD0.9010704@gmail.com>
Date: Tue, 23 May 2006 03:02:56 +0900
From: Tetsuji Maverick Rai <tetsuji.maverick.rai@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: is it a newbie'sh question?: where is the log for violated	access
 ?
References: <4471F07A.1000409@gmail.com> <1148319371.24463.100.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1148319371.24463.100.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Tue, 2006-05-23 at 02:10 +0900, Tetsuji Maverick Rai wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Hi all,
>>
>> I thought when an access violation occurs, it's logged in
>> /var/log/audit.log or messages, but it doesn't look so.
>>....snip.....
>> Thanks in advance.
> 
> If running auditd, then it is audit.log.  Otherwise, it is messages.
> Cases where there is no audit message include:
> a) The syscall failed before reaching the SELinux hook, e.g. a DAC
> denial or some other error condition,
> b) SELinux denied access but policy has a dontaudit rule to silence the
> audit message for that particular (domain, type, class, permission)
> tuple to avoid flooding the logs with common patterns of access.
> 
> Note that su didn't originally change SELinux security context at all
> (only the Linux uid) - we intentionally kept changing Linux uid separate
> from changing SELinux security context.  Later, during Fedora SELinux
> integration, pam_selinux was inserted into su's pam config in an attempt
> to unify them, but that caused more problems than it solved, ultimately
> leading to its removal again in the latest Fedora.  So su'ing to
> apache's uid has no bearing on the SELinux security context.  Use runcon
> -t httpd_t to run a process in apache's domain (although it will likely
> fail immediately on the transition or entrypoint checks).
> 

Thank you!   In my case, auditd isn't running, and my errors seem to
include case a) or b) and that's the reason I didn't see the error
(warning) messages.

I'm not using fedora (using Gentoo) so it's close to the original, I
think.  Then I will use SELinux in the normal way.

Anyway my configuration seems effective at least for http server and in
the future, more.  Thank you!

regards,

- -Tetsuji
- --
Tetsuji 'Maverick' Rai
Main http://maverick6664.bravehost.com/
Profile:
http://setiweb.ssl.berkeley.edu/beta/view_profile.php?userid=123
pubkey http://mav.atspace.com/tmr_at_gmail.txt
PGP Key ID: 82335CD9
Key fingerprint = 41CA 94B4 2A89 3FF1 5B11  BC37 D597 E667 8233 5CD9

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFEcfzP1ZfmZ4IzXNkRAvfJAJIC9aHfQTuyOdc2QshGTAL26sdzAKCjSd/x
tdaLujua84fRFxqxpD7ktA==
=V5PY
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
