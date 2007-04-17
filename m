Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3HL1rXR030059
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 17:01:53 -0400
Received: from soda.ext.ti.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3HL1qC3022217
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 21:01:52 GMT
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id l3HL1Q4I030395
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 16:01:41 -0500
Received: from dlee70.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.7/8.13.7) with ESMTP id l3HL1Li4010910
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 16:01:21 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: SELinux vs MVFS (via IBM's Rational ClearCase)
Date: Tue, 17 Apr 2007 16:01:15 -0500
Message-ID: <9E8AB4F8CD83E542A3EF3F7DD3E7C55F014A49CA@dlee11.ent.ti.com>
From: "James, Jay" <jay.james@ti.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is anyone here familiar with the work that IBM is doing on ticket
RATLC00762574 in their Rational ClearCase issue queue? 

See item 9 here:
http://www-1.ibm.com/support/docview.wss?rs=984&uid=swg21159882

"Secure Linux (SELinux) and ClearCase
If the security feature of Linux known as SELinux is enabled on a
ClearCase host, normal operations can fail. ClearCase is currently not
supported on Secure Linux (SELinux). Change request RATLC00762574 has
been submitted requesting support for ClearCase on SELinux."


There is a request for more information from IBM on this but I figured I
would try to get some input from this list as well.


Apparently there are some inconsistencies in the way MVFS filesystems
interact with SELinux filesystems (or at the very least when in the
config file, "SELINUX=enabled") and so I can foresee an organization
hitting the wall with RHEL4 rollouts, finding out late in the game.

Basically to sum up my own specific experience:
A /bin/mv operation fails from an ext3 partition on an SELinux enabled
RHEL4 box ("mv: cannot create regular file", "Permission denied") to an
MVFS filesystem -but- a copying (/bin/cp) operation from ext3 to MVFS
works fine, no problems whatsoever (given requisite perms, of course).

So, disable SELinux, and the move operation is back to normal.

Note:
Previous versions of mv (from RHEL3) still work while in
"SELinux=enabled" mode, but negates the RHEL4 baseline integrity, so
while that may be a workaround for some, its obviously not a real fix
for all.

Would anyone care to lend some extra info either via the list or perhaps
offline with me?



Jay C. James
Unix Administration
TISD



"no extra charge applied for typos or formatting annoyances"











--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
