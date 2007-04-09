Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l39J8viE024517
	for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2007 15:08:57 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l39J8qgm009672
	for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2007 19:08:53 GMT
Received: by an-out-0708.google.com with SMTP id d33so1687721and
        for <selinux@tycho.nsa.gov>; Mon, 09 Apr 2007 12:08:33 -0700 (PDT)
Message-ID: <461A8F2E.5070701@gmail.com>
Date: Mon, 09 Apr 2007 14:08:30 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: seobject.py setransRecords.get_all method return values 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When you have aliases in your setrans.conf 
seobject.setransRecords().get_all returns a dictionary containing values 
with the last alias whereas the first alias  is what I'd like (this is 
also what the os uses). Alternatively it could return an ordered list of 
all of the aliases as the dictionary values or maybe this would be a 
different method.

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
