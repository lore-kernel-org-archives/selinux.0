Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0B1oRIi004042
	for <selinux@tycho.nsa.gov>; Mon, 10 Jan 2005 20:50:27 -0500 (EST)
Received: from smtp804.mail.sc5.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j0B1mUXK013607
	for <selinux@tycho.nsa.gov>; Tue, 11 Jan 2005 01:48:32 GMT
Message-ID: <41E330AA.80609@sbcglobal.net>
Date: Mon, 10 Jan 2005 19:49:30 -0600
From: Lee <FriedBob@sbcglobal.net>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: audit ... denied messages
References: <41E293C2.9040608@sbcglobal.net> <41E2CA19.4060602@diyab.net>
In-Reply-To: <41E2CA19.4060602@diyab.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Timothy Wood wrote:

| Are you passing enforcing=1 to the kernel at boot time?

Yes, these errors/messages only occur when I pass "selinux=1" to the
kernel at boot, which I assume does the same thing as "enforcing=1" ?

| Those packages will give you basic system functionality while in
| enforcing mode.  Some services and other things will need the policy
| fixed, at least somewhat, in order for them to work in enforcing mode.

Well, I guess I need to find out where and what needs to be fixed. :)

| Can you include some of these messages?

I've got 5 pages of errors that I copied from dmesg.  One of them
changes the aspect of my problems, as I saw a line telling me my
reiserfs partition doesn't support labeling.  Here's a few select lines
from them.   Seems I need a kernel patch for the reiser issue, so I'll
look for that.


~ audit(1105370321.810:0): avc:  denied  { read } for  pid=446
exe=/sbin/ldconfig name=libartsc.so.0.0.0 dev=hdc1 ino=749412
scontext=system_u:system_r:ldconfig_t tcontext=system_u:object_r:usr_t
tclass=file
audit(1105370321.811:0): avc:  denied  { getattr } for  pid=446
exe=/sbin/ldconfig path=/opt/kde/lib/libartsc.so.0.0.0 dev=hdc1
ino=749412 scontext=system_u:system_r:ldconfig_t
tcontext=system_u:object_r:usr_t tclass=file
audit(1105370322.118:0): avc:  denied  { read } for  pid=446
exe=/sbin/ldconfig name=libmcop.so dev=hdc1 ino=749444
scontext=system_u:system_r:ldconfig_t tcontext=system_u:object_r:usr_t
tclass=lnk_file
audit(1105370322.511:0): avc:  denied  { read } for  pid=446
exe=/sbin/ldconfig name=libSegFault.so dev=hdc1 ino=650924
scontext=system_u:system_r:ldconfig_t tcontext=system_u:object_r:lib_t
tclass=file
audit(1105370322.512:0): avc:  denied  { getattr } for  pid=446
exe=/sbin/ldconfig path=/lib/libSegFault.so dev=hdc1 ino=650924
scontext=system_u:system_r:ldconfig_t tcontext=system_u:object_r:lib_t
tclass=file


And I've got some others along the same lines from after I log in, but
will spare you from them unless they are requested.
- --
~  == FriedBob ==

"Hence to fight and conquer in all your battles is not supreme
excellence; supreme excellence consists in breaking the enemy's
resistance without fighting."
~  - Sun Tzu
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFB4zCpvxumKxmOCzIRAqgOAJ46N8OYAUn9Dg7cKKtgpwBYENF2TgCeNLRO
yMFpTlX6e8XVO64XYkuLqA8=
=J+Z2
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
