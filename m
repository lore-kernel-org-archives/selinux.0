Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4MKRoow006074
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2007 16:27:50 -0400
Message-ID: <4653523E.6010403@tycho.nsa.gov>
Date: Tue, 22 May 2007 16:27:42 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: russell@coker.com.au, eparis@parisplace.org
Subject: SysV shared memory segments and X
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Having reviewed the various X protocol extensions I can comment on the 
way X uses shared memory segments, following up on the threads 
concerning labeling of shared memory segments:

http://marc.info/?l=selinux&m=115401962007617&w=2
http://marc.info/?l=selinux&m=115765873100144&w=2

X server uses shared memory to talk to client applications in two 
places: sharing of image data and sharing of font metrics.

In the former case, the client application creates the shared memory 
segment and passes the ID through the protocol to the X server which 
attaches to it.  Then client can read/write image data to the segment 
using ShmPutImage, ShmGetImage, etc.  When attaching, the X server calls 
getpeercred() on the client's UNIX socket and manually checks the values 
against the ownership and permissions of the segment.  This check was 
apparently buggy for some years:

http://www.securityfocus.com/bid/4396/discuss

In the latter case, which is different since the font metrics are 
read-only, the _server_ creates a world-readable shared memory segment 
and passes its ID to the client which attaches to it to read out the 
font metrics.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
