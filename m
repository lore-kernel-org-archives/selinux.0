Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0GE4Dbh011887
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2008 09:04:13 -0500
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0GE4Dx1016505
	for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2008 14:04:13 GMT
Received: by py-out-1112.google.com with SMTP id a78so323397pyh.32
        for <selinux@tycho.nsa.gov>; Wed, 16 Jan 2008 06:04:13 -0800 (PST)
Reply-To: w.chimiak@ieee.org
To: SE Linux <selinux@tycho.nsa.gov>
Subject: MCS/MLS
Date: Wed, 16 Jan 2008 08:52:25 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200801160852.25646.w.chimiak@ieee.org>
From: Bill Chimiak <wch1m1@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Just a quick message about MCS/MLS for those troubleshooting:

I was fooling about with MCS/MLS with FC6, the move to FC8 created 
kernel messages on the screen when doing any network activity as a user.
I traced it back to some MCS statements I had made.  Networking worked fine
for the root., thank goodness.

enforce=0 did not help matters, nor did setenforce=0.  
User networking was down.  Needless to say selinux=0 worked also, but
creates its own problems.

I brute-forced the distro by doing a yum erase selinux (policies, etc)
and reinstalled them and then all worked well.

Thanks for setroubleshoot rpm - very useful!

-- 
William Chimiak
Laboratory for Telecommunications Sciences
8080 Greenmead Road
College Park, MD
240-949-2778

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
