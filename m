Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3H8nkqo017208
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 04:49:46 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3H8nkM3002048
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 08:49:46 GMT
Received: by wr-out-0506.google.com with SMTP id q50so1987060wrq
        for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 01:49:46 -0700 (PDT)
Message-ID: <4624897D.5030205@gmail.com>
Date: Tue, 17 Apr 2007 16:46:53 +0800
From: Ken YANG <spng.yang@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: autoreconf fails in setools of revision 4290
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


hi all,

i use autoconf-2.61-8.fc7 in fc7 rawhide

autoreconf of this version fails in building setools of
revision 4290.

i also test setools 3.1 tags, it fails with the same errors:

......
sediff/Makefile.am:45: notdir $@: non-POSIX variable name
sediff/Makefile.am:45: (probably a GNU make extension)
sediff/Makefile.am:48: notdir $@: non-POSIX variable name
sediff/Makefile.am:48: (probably a GNU make extension)
sediff/Makefile.am:51: notdir $@: non-POSIX variable name
sediff/Makefile.am:51: (probably a GNU make extension)
autoreconf: automake failed with exit status: 1

thanks in advance

Ken YANG


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
