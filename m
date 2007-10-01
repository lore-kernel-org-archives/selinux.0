Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l91E826Q019987
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2007 10:08:02 -0400
Received: from nf-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l91E81r5009203
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2007 14:08:01 GMT
Received: by nf-out-0910.google.com with SMTP id k4so3232339nfd
        for <selinux@tycho.nsa.gov>; Mon, 01 Oct 2007 07:07:38 -0700 (PDT)
Message-ID: <4700FEFD.8000108@gmail.com>
Date: Mon, 01 Oct 2007 09:06:53 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: file names with spaces, file contexts and matchpathcon problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been trying to figure out how to write fcglob expressions for file 
names with spaces which will work in an fc file but haven't succeeded 
yet, can anyone help me? I can use wildcarding (?) but I'd prefer being 
specific like "[ ]" which doesn't work. If I do use a wildcard I can 
then use the matchpathcon  command to retrieve the default context but 
code calling the matchpathcon api with the same path fails claiming that 
the file/directory doesn't exist.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
