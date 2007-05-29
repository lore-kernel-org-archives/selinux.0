Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4TDxmMR028316
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2007 09:59:48 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4TDxmGV013890
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2007 13:59:48 GMT
Received: by wr-out-0506.google.com with SMTP id i28so756705wra
        for <selinux@tycho.nsa.gov>; Tue, 29 May 2007 06:59:48 -0700 (PDT)
Message-ID: <465C31D0.2040606@gmail.com>
Date: Tue, 29 May 2007 08:59:44 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: unshare behavior when polyinstantiating
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've run into some polyinstantiation bugs but want to make sure I 
understand what unshare(CLONE_NEWNS) does before I submit a patch. Is it 
the case that the new namespace created by unshare is related to the 
current process and when this process exits the namespace is destroyed 
or is no longer valid? All mounts and unmounts done in the new namespace 
have no affect on the parent processes namespace, correct?

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
