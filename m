Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9AC8pfo012002
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 08:08:51 -0400
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9AC8CTb012732
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 12:08:12 GMT
Received: by wx-out-0506.google.com with SMTP id i26so2042340wxd
        for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 05:08:52 -0700 (PDT)
Message-ID: <6a9b0ede0610100508o7c9d65c0t19b0185e8ffaf19a@mail.gmail.com>
Date: Tue, 10 Oct 2006 17:38:51 +0530
From: "abcde efghi" <svmdcv@gmail.com>
To: selinux@tycho.nsa.gov
Subject: glibc error on rhel4
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi

grep  -nri  "haithere"  *
 *** glibc detected *** free(): invalid next size (fast): 0x0000000000616990
 ***
 Aborted (core dumped)

uname -orp
2.6.9-42.ELsmp x86_64 GNU/Linux

with selinux enabled i am getting this error.why is it so?

thanks in advance

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
