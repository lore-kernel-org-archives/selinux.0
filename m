Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5OJLP3E025273
	for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2003 15:21:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5OJLO5e001267
	for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2003 19:21:24 GMT
Received: from citation.av8.net ([130.105.12.4])
        by jazzband.ncsc.mil  with ESMTP id h5OJLD92001242 for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2003 19:21:21 GMT
Received: from vista.av8.net (vista.av8.net [130.105.36.10])
	by citation.av8.net (8.9.3/8.9.3) with ESMTP id PAA22121
	for <selinux@tycho.nsa.gov>; Tue, 24 Jun 2003 15:15:35 -0400
Date: Tue, 24 Jun 2003 15:15:37 -0400 (EDT)
From: Dean Anderson <dean@av8.com>
To: selinux@tycho.nsa.gov
Subject: proftpd
In-Reply-To: <Pine.LNX.4.44.0306241033090.11428-100000@vista.av8.net>
Message-ID: <Pine.LNX.4.44.0306241457400.11428-100000@vista.av8.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm having some trouble with the proftpd program, specifically, it won't
seem to transition from the initrc domain to the ftpd_t domain

I have the ftpd.te file moved into domains/programs, and I added

define(`ftpd_daemon')

to the top of the file.

I did a make policy; make load

I relabeled the files (after changing the path to the proftpd binary to
/usr/local/sbin/proftpd in file_contexts/programs/ftpd.fc

ls --context /usr/local/sbin/proftpd
shows system_u:object_r:ftpd_exec_t

grep ftpd_exec_t policy.conf shows a type transition line:
type_transition initrc_t ftpd_exec_t:process ftpd_t

Yet, no effect. Rebooting also has no effect.

I was able to get radiusd properly labeled and working (similar changes of
paths)...

Any ideas?

Interestingly, the radius.te file has this:

domain_auto_trans(system_crond_t, radiusd_exec_t, radiusd_t)

However, radius is not started by cron. What is up with this?






		--Dean



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
