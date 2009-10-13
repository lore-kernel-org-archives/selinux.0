Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9D7Z0Qg009217
	for <selinux@tycho.nsa.gov>; Tue, 13 Oct 2009 03:35:00 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9D7YAQ5025463
	for <selinux@tycho.nsa.gov>; Tue, 13 Oct 2009 07:34:10 GMT
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Cc: Raphael Geissert <geissert@debian.org>, 549610-forwarded@bugs.debian.org
Subject: /lib/libsemanage.so.1 links to  /usr/lib/libustr-1.0.so.1 
Date: Tue, 13 Oct 2009 02:20:55 -0500
Message-ID: <87aazvu5d4.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

        As demonstrated by

$ ldd /lib/libsemanage.so.1
        linux-gate.so.1 =>  (0xb8092000)
        libsepol.so.1 => /lib/libsepol.so.1 (0xb8015000)
        libselinux.so.1 => /lib/libselinux.so.1 (0xb7ffa000)
        libbz2.so.1.0 => /lib/libbz2.so.1.0 (0xb7fe9000)
        libustr-1.0.so.1 => /usr/lib/libustr-1.0.so.1 (0xb7fbf000)
        libc.so.6 => /lib/i686/cmov/libc.so.6 (0xb7e60000)
        libdl.so.2 => /lib/i686/cmov/libdl.so.2 (0xb7e5c000)
        /lib/ld-linux.so.2 (0xb8093000)

	libsemanage1 links to libustr which is located under the,
 possible separate or external, /usr partition, which would render
 libsemanage unusable in such setups. (This dependency has been around
 since 2.0.9).

        Should we move libsemanage1 to /usr/lib? The only reason for it
 to be in /lib would be for early boot, where /usr might not be
 available, but at this point, it is likely not usable without /usr
 anyway. 

        manoj
-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
