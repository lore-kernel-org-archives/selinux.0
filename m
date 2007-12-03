Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB3KcGWi005858
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2007 15:38:16 -0500
Subject: Interface for DOI mapping
From: Dave Quigley <dpquigl@tycho.nsa.gov>
To: Labeled NFS <labeled-nfs@linux-nfs.org>, SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 03 Dec 2007 15:32:45 -0500
Message-Id: <1196713965.31856.19.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,
    With help from Neil I have the actual daemon code working for DOI
translations. Now I have to come up with an interface for allowing an
LSM to specify its translations. Either in the form of a separate
library or in the daemon code itself I intend to dlopen a shared library
and make calls into it. The question is what functionality do we want
here and where should it be placed. 

In the long run it would be nice to have a server which maintains the
mappings for all of the clients in its domain similar to kerberos.
However the client also needs to be able to operate without such a
server. 

If you have suggestions for this feel free to make them now while I am
still designing this.

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
