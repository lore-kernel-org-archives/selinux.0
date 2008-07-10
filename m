Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6AJ0o8X023053
	for <selinux@tycho.nsa.gov>; Thu, 10 Jul 2008 15:00:50 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6AJ0n5d011428
	for <selinux@tycho.nsa.gov>; Thu, 10 Jul 2008 19:00:50 GMT
Received: by an-out-0708.google.com with SMTP id d30so727725and.75
        for <selinux@tycho.nsa.gov>; Thu, 10 Jul 2008 12:00:49 -0700 (PDT)
Message-ID: <dd18b0c30807101200u12c70303oae012931a6aa903@mail.gmail.com>
Date: Thu, 10 Jul 2008 19:00:49 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: policycoreutils in SID
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello; I updated my system with debian sid a few days ago, and notice
audit2allow -d was giving me this:
 File "/usr/bin/audit2allow", line 23
    import python-sepolgen.audit as audit
                 ^
SyntaxError: invalid syntax

the bug report is here:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=486120
is there a workaround for this, or a new package?
regards;

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
