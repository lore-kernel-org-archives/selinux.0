Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8H9GrrT000982
	for <selinux@tycho.nsa.gov>; Fri, 17 Sep 2004 05:16:53 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8H9Gput010176
	for <selinux@tycho.nsa.gov>; Fri, 17 Sep 2004 09:16:52 GMT
Date: Fri, 17 Sep 2004 10:27:56 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Colin Walters <walters@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: SELinux policy discussion.
Message-ID: <20040917092756.GA5296@lkcl.net>
References: <4148A003.6080309@redhat.com> <1095295125.4231.127.camel@nexus.verbum.private> <1095302625.28466.56.camel@localhost.localdomain> <1095307503.4231.152.camel@nexus.verbum.private> <1095318426.32510.30.camel@localhost.localdomain> <1095356254.4231.188.camel@nexus.verbum.private> <1095364389.10058.85.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1095364389.10058.85.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 16, 2004 at 03:53:09PM -0400, Ivan Gyurdiev wrote:
 
> What I want from MAC is to restrict my applications while preserving
> 100% useful functionality and being transparent. I don't want more
> restrictions on my behavior. I don't want to be told that I can't use 

then for _your_ requirements, i believe that the targetted policy
suits your needs must better than the strict one.

targetted policy restricts services but leaves users pretty much
unrestricted.

but remember that unix permissions are checked first _followed_ by
selinux permissions if the unix perms happen to succeed (so if the
unix perms fail there's no need to run the selinux security module).

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
