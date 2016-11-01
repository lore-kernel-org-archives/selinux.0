Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA1LMYD6011568
 for <selinux@tycho.nsa.gov>; Tue, 1 Nov 2016 17:22:34 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id A5E991A1A8
 for <selinux@tycho.nsa.gov>; Tue,  1 Nov 2016 22:22:30 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Y_uUzoBrkK1t for <selinux@tycho.nsa.gov>;
 Tue,  1 Nov 2016 22:22:28 +0100 (CET)
Received: from [IPv6:2a02:a03f:6c:e500:edf:2fd8:fc0a:f176] (unknown
 [IPv6:2a02:a03f:6c:e500:edf:2fd8:fc0a:f176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id A790B1A06E
 for <selinux@tycho.nsa.gov>; Tue,  1 Nov 2016 22:22:28 +0100 (CET)
To: selinux@tycho.nsa.gov
From: Laurent Bigonville <bigon@debian.org>
Subject: Backtrace in sandbox command
Message-ID: <1c0ea850-6b78-05f7-28ed-4c59781a05b7@debian.org>
Date: Tue, 1 Nov 2016 22:22:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

I get the following backtrace in sandbox because there are no types 
marked with the "sandbox_type" attribute in my test policy:

Traceback (most recent call last):
   File "/usr/bin/sandbox", line 529, in <module>
     rc = sandbox.main()
   File "/usr/bin/sandbox", line 513, in main
     self.__parse_options()
   File "/usr/bin/sandbox", line 308, in __parse_options
     """) % "\n\t".join(list(sepolicy.info(sepolicy.ATTRIBUTE, "sandbox_type"))[0]['types'])
IndexError: list index out of range

It seems that sepolicy.info() is not returning a RuntimeError exception 
if there are not types returned.

There is a 2nd call to sepolicy.info() later in the code where the same 
exception is catch.

In both cases, sepolicy.info() is returning an iterator. Has anything 
changed in sepolicy behavior here?

Laurent Bigonville
