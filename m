Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7LFrYp9024482
	for <selinux@tycho.nsa.gov>; Fri, 21 Aug 2009 11:53:34 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7LFsgFD000896
	for <selinux@tycho.nsa.gov>; Fri, 21 Aug 2009 15:54:42 GMT
Received: from int-mx07.intmail.prod.int.phx2.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.20])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n7LFrW56022071
	for <selinux@tycho.nsa.gov>; Fri, 21 Aug 2009 11:53:32 -0400
Received: from localhost.localdomain (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by int-mx07.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n7LFrVnL008545
	for <selinux@tycho.nsa.gov>; Fri, 21 Aug 2009 11:53:32 -0400
Message-ID: <4A8EC2F9.3040707@redhat.com>
Date: Fri, 21 Aug 2009 11:53:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Semodule syntax is broken.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently when rpm ships, it does an 

semodule -b base.pp -i a.pp b,pp c.pp

It should be able to do 

semodule -b base.pp -u a.pp b.pp c.pp

But -u blows up if c.pp was not previously installed.  It should follow the rpm -U syntax; upgrade if the previous package exists and install if it does not.  If we want to add a -F (freshen) this could only upgrade pre-existing modules, and ignore others.

If I was to change to -u, I would need to add a fourth field to policy modules and upgrade it each time I added a patch.  It would be a pain, but I guess I could deal with it.

BUT  A bigger problem is how to deal with an administrator that wants to remove a package and ensure it does not get reinstalled.  If an administrator decides he does not want to install unconfined.pp, we do not want an selinux-policy upgrade to re-install the package.

semodule -r should set a flag when a package gets removed.  Then semodule -u or semodule -i would not install the package unless the  administrator specifies a -f.

semodule -r unconfined

Would create a file in the policy store /etc/selinux/targeted/modules/active/modules/unconfined.exclude.  

semodule -u and semodule -i would respect, and just print out an error message.

semodule -u unconfined.pp
Warning: unconfined.pp is excluded from the policy store, use -f to force the install

Add -q qualifier to quiet this message

# semodule -f -u unconfined.pp
Would install the package and remove the flag.


I would like to get consensus on this before I implement.  Or others can implement.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
