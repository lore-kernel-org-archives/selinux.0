Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9E184Wt016166
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2003 21:08:04 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9E183ZK017033
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 01:08:03 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9E182FF017026 for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 01:08:03 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 673C992472
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 11:07:56 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 892CB7F075
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2003 11:07:54 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: trusted vs untrusted packages
Date: Tue, 14 Oct 2003 11:07:53 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200310141107.53852.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We have been having some IRC discussions about trusted RPMs.  But please note 
that I am not an expert on RPM, so I'll probably get terminology wrong (at 
least).  Please correct any errors and CC the list for the benefit of all 
readers.

RPMs can be signed or unsigned.  If an RPM is signed by a trusted organization 
then there should be some differences in an SE Linux install than if it is 
not signed or if we don't trust the signer.

One idea is to have signed packages be installed by rpm running as rpm_t and 
unsigned packages be installed by rpm running as rpm_unsigned_t [1].  So for 
example we could allow rpm_unsigned_t to install files in /sbin as 
sbin_unsigned_t and in /bin as bin_unsigned_t [2].  Then a program installed 
from an untrusted package can't be run from sysadm_t, and if it's run from 
other trusted domains (EG part of the mail server) then it could trigger an 
automatic domain transition to an appropriate domain.

Now this raises some interesting issues.  If a signed package has a program 
which relies on some other program (and has a dependency), what happens if 
the dependency is satisfied by an unsigned package?  Installing the unsigned 
package may not result in the system being fully functional (execution of the 
file in question may be denied).



[1] Names aren't certain yet, just used as an example.  May have 3-4 levels of 
trust too with 3-4 different names.

[2] A relabel of a file system will break this...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
