Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iANFDWIi011933
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 10:13:32 -0500 (EST)
Received: from omx1.americas.sgi.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iANFC25q013713
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 15:12:02 GMT
Message-ID: <41A35397.1080001@sgi.com>
Date: Tue, 23 Nov 2004 10:13:27 -0500
From: Prarit Bhargava <prarit@sgi.com>
MIME-Version: 1.0
To: linux-ia64@vger.kernel.org, selinux@tycho.nsa.gov
Subject: SELinux & ia64
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

SELinux appears to cause warnings while attempting mounts both at 
boot-time and run-time:

kernel unaligned access to 0xa0000002003a0056, ip=0xa0000001002076d0
kernel unaligned access to 0xa0000002003a005e, ip=0xa0000001002076d0
kernel unaligned access to 0xa0000002003a0066, ip=0xa0000001002076d0
kernel unaligned access to 0xa0000002003a006e, ip=0xa0000001002076d0

I've tracked this to the usage of le32_to_cpu in 

security/selinux/ss/policydb.c

The code in question uses:

    len = le32_to_cpu(buf[0]);

and should be

    len = le32_to_cpu(get_unaligned(&buf[0]));

However, this is probably not a good solution as the get_unaligned macro 
can be expensive
on platforms other than ia64. 

I'm tempted to redefine the le32_to_cpu function for policydb.c for the 
ia64 platform, but
before I go down that road I was wondering if anyone had hit this issue 
elsewhere in the kernel?

Prarit.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
