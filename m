Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3RIffZI031961
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 14:41:41 -0400
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3RIffKw021058
	for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 18:41:41 GMT
Received: by wx-out-0506.google.com with SMTP id s17so1009386wxc
        for <selinux@tycho.nsa.gov>; Fri, 27 Apr 2007 11:41:41 -0700 (PDT)
Message-ID: <463243E3.2060602@gmail.com>
Date: Fri, 27 Apr 2007 13:41:39 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: launching apps at level (MLS) and polyinstantiation
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm working on an application that launches other applications at a 
specified level. I have also configured polyinstantiation for a some 
directories. What I have found is that I had to make this application 
pam aware in order for the child process to get polyinstantiated 
directories. One issue is the reauthentication I've already 
authenticated why should I have to reauthenticate so that a child 
process can use polyinstantiated directories? Currently this app works 
when run as root but not as other users because the unshare call in 
pam_namespace fails for lack of permissions (CAP_SYS_ADMIN?). What do I 
need to do so that the application has this capability? I tried making 
the app setuid but that didn't help.

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
