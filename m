Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h32G9tx6023978
	for <selinux@tycho.nsa.gov>; Wed, 2 Apr 2003 11:09:55 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h32G9rxH005535
	for <selinux@tycho.nsa.gov>; Wed, 2 Apr 2003 16:09:53 GMT
Received: from facesaver.epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h32G9rDl005532 for <selinux@tycho.nsa.gov>; Wed, 2 Apr 2003 16:09:53 GMT
Subject: Re: Motif for selinux?
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: ccallen <ccallen@windowpane.com>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <000d01c2f7fa$f3c67730$398314d1@windowpane.com>
References: <000d01c2f7fa$f3c67730$398314d1@windowpane.com>
Content-Type: text/plain
Message-Id: <1049299790.9861.36.camel@moss-sooners.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 02 Apr 2003 11:09:51 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As Russell already mentioned you can get KDM from
http://www.coker.com.au/selinux/   Several patched versions of GDM
(2.0.98.1, 2.2.3.1, and 2.4.0.7) are available from
http://sourceforge.net/project/showfiles.php?group_id=21266  Neither of
these patches were developed by the NSA SELinux team.  In general using
them requires giving a lot of trust to the X-server, which isn't ideal. 
Other the other hand, using one of these does improve the usability of
the system.

I haven't looked at open motif, but I doubt that any changes need to be
made for it to function correctly in an SELinux system.  Did you believe
all code needs to be modified to run in SELinux? (Most doesn't) Or, was
there some particular aspect of Motif that you expect to change when run
in SELinux?  GDM and KDM for instance need to get extra information
(e.g., what role the user wants to use) from the user on login.

On Mon, 2003-03-31 at 22:01, ccallen wrote:
> In build / install doc states that there are a modified versions of
> gdm & kdm that will work with selinux, where can these projects be
> found? Is there a modified version of open motif that will work with
> selinux?

-- 
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
