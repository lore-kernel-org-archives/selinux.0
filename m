Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j53HU5gA002479
	for <selinux@tycho.nsa.gov>; Fri, 3 Jun 2005 13:30:05 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j53HNFhg019032
	for <selinux@tycho.nsa.gov>; Fri, 3 Jun 2005 17:23:15 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j53HNdUf026092
	for <selinux@tycho.nsa.gov>; Fri, 3 Jun 2005 13:23:39 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j53HNdO28815
	for <selinux@tycho.nsa.gov>; Fri, 3 Jun 2005 13:23:39 -0400
Subject: Bonobo
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: selinux@tycho.nsa.gov, David Malcolm <dmalcolm@redhat.com>,
   Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain
Date: Fri, 03 Jun 2005 13:23:00 -0400
Message-Id: <1117819380.22249.31.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(sorry for 2 mails - posting on list this time) 

What can be done to restrict bonobo? 

My understanding is that bonobo allows applications to start other
apps, based on searching for a particular capability. Mozilla uses
bonobo, evolution uses bonobo, and pretty much any gnome app seems
to use bonobo. What role should SElinux play in this process to 
make the system more secure?

We've patched policy to implement per-domain labeling of orbit sockets,
which restricts which apps can talk to which others over orbit. However,
that doesn't seem sufficient. Currently bonobo runs as ROLE_t, and
clients need to connect to it to launch other applications. That means:

(1) All bonobo clients are given the right to connect to
ROLE_orbit_tmp_t sockets, which is the same as the orbit
socket type for any ROLE_t applications.

I want to put bonobo in its own domain, but then it needs
to be able to launch ROLE_t apps, and that becomes a problem.

(2) Bonobo can launch applications that ROLE_t can launch.
The bonobo client could trick the bonobo server to launch the
wrong applications. 

I'm interested in how userspace object managers work, and whether
such a thing would be appropriate in this situation. It seems
like it would be useful to enforce what can launch what else
over bonobo, independent of the "search-by-capability" thing.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
