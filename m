Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m07G8cpK018563
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2008 11:08:38 -0500
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m07G8alk029512
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2008 16:08:37 GMT
Received: by fg-out-1718.google.com with SMTP id 16so3658925fgg.40
        for <selinux@tycho.nsa.gov>; Mon, 07 Jan 2008 08:08:36 -0800 (PST)
Message-ID: <cadfc0e40801070808w30f405c0t6cec02573413e7b4@mail.gmail.com>
Date: Mon, 7 Jan 2008 10:08:36 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: TypeError: in method 'getpidcon', argument 1 of type 'pid_t'
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

import selinux
import os

pid = os.getpid()
print "Type of pid ", type(pid)
(ret,con) = selinux.getpidcon(pid)
type = con.split(":", 4)
print type

Running this script results in:

Type of pid  <type 'int'>
Traceback (most recent call last):
  File "test.py", line 8, in <module>
    (ret,con) = selinux.getpidcon(pid)
TypeError: in method 'getpidcon', argument 1 of type 'pid_t'

How do I make a pid_t in python? Or is the swig broke?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
