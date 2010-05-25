Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4PLaZkv026553
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2010 17:36:35 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id o4PLbs4f010434
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2010 21:37:54 GMT
Date: Tue, 25 May 2010 17:36:33 -0400
Subject: install giving the wrong label
From: Chad Sellers <csellers@tresys.com>
To: SE Linux <selinux@tycho.nsa.gov>
Message-ID: <C821BB21.B8234%csellers@tresys.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I just found a problem with /usr/bin/install. It appears that it will label
things improperly if they have an extra / in the target name. For instance:

# install foo /usr
# ls -lZ /usr/foo
-rwxr-xr-x. root root system_u:object_r:usr_t:s0       /usr/foo

but

# install foo //usr
# ls -lZ /usr/foo
-rwxr-xr-x. root root system_u:object_r:default_t:s0       /usr/foo

The same thing goes for targets like /var/www//foo, where the // is later in
the filename.

This appears to result from install calling matchpathcon() with the target
passed in directly. My question is, whose responsibility should this be?
Should matchpatchcon() scrub filenames passed into it, or should callers be
required to pass proper filenames to matchpathcon()?

Thanks,
Chad Sellers


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
