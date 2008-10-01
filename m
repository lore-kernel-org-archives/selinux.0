Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m91DeXUc031016
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 09:40:33 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m91DdTZL006466
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 13:39:29 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m91DeV0N028620
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 09:40:31 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m91DeUMV008088
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 09:40:31 -0400
Received: from localhost.localdomain (vpn-10-65.bos.redhat.com [10.16.10.65])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m91DeUsf004404
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 09:40:30 -0400
Message-ID: <48E37DCD.1010800@redhat.com>
Date: Wed, 01 Oct 2008 09:40:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: genhomedircon problems
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I want to open up a discussion about genhomedircon and see if we can get
some good ideas on how to fix it.

genhomedircon searches the passwd database for users homedirs, it looks
for unigue home directory roots and attempts to setup the labeling
correctly.  So if it find home directories in /home and /var/home it
would setup the file_context.homedirs to label the contents correctly.

Over the years several problems have arisen.  What is a real users home
directory?  Currently Linux does not provide a way to guarantee an entry
in the /etc/passwd file is for a "real" user or just an account setup to
run as service under.  genhomedir looks in /etc/login.defs for the
UID_MIN and decides that all UIDs < UID_MIN are not login users.  It
also eliminates all acconts which have shells not in /etc/shells or
shells labeled /bin/false or /sbin/nologin.  In certain situations we
have directories which serve as both a login directory and a service
directory, but have no good solution.  Oracle requires an account like
the following, but this causes random AVCs and complains about the
parent directory,  We can't set the shell to nologin since dbadmins
actually do login to the account.

 /usr/sbin/useradd -M -g dba -d /usr/lib/oracle/xe -s /bin/bash oracle

I think we need a way for an admin to tell genhomedircon to ignore this
account.

Another problem with genhomedircon is it attempts to dump the entire
passwd database even in a network environment, we have seen bug reports
where genhomedircon has taken a ton of time to run, because the users
had over a hundred thousand users and LDAP was choking.  I don't know if
there is a good way around this other then to tell genhomedircon not to
run, which we need to make easier for an admin to setup.  I am not sure
we even document how to turn off genhomedircon.  Or we allow
genhomedircon to run but not dump the passwd database.

Finally we need a way to specify an admin to specify a directory as a
root homedir directory.  Sometimes admin set up directories like
/export/home/ as a root directory and then bind mount or symbolicly link
this directory to /home, The entries in the /etc/passwd file all point
to the /home directory, but we get labeling wrong, and the admin can not
fix the problem.

Thoughts?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjjfc0ACgkQrlYvE4MpobNVdQCfS4y0DbwiOLMP315nC6mcRQOK
SmEAn2Fp5MzTAyH11QfvNJdE13m3OGqq
=1AM8
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
