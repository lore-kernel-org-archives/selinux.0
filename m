Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3HI7uxk019731
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 14:07:56 -0400
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3HI7sC3022578
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 18:07:55 GMT
Received: by wx-out-0506.google.com with SMTP id s17so2202229wxc
        for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 11:07:51 -0700 (PDT)
Message-ID: <cadfc0e40704171107l770c48cak16f504b6b0a0dcc0@mail.gmail.com>
Date: Tue, 17 Apr 2007 13:07:51 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: selinux@tycho.nsa.gov
Subject: directory polyinstantiation failure
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

pam_namespace complains that "Pathnames must start with '/'" when I
try and polyinstantiate "$HOME/$USER/.mozilla". Is there a particular
reason that I shouldn't be able to polyinstantiate a dot directory or
is this a bug?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
