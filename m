Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l9PHRlhM009773
	for <selinux@tycho.nsa.gov>; Thu, 25 Oct 2007 13:27:47 -0400
Message-ID: <4720D211.1000507@tycho.nsa.gov>
Date: Thu, 25 Oct 2007 13:27:45 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: What domain should the X server run in
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The X server runs as xdm_xserver_t if it is started from a display
manager.  It runs as user_xserver_t if it is started with startx.

Is the X server part of the user's session or not?

If it is, then it should always run as user_xserver_t, and the display
managers should be "fixed" to label the X server with the user's context
at login time.

It if isn't, then it should always run in the same domain, and
startx/xinit should be "fixed" to transition into this context.

 From my perspective I would favor the latter option for now since it's 
easier to write policy for.  The user's individual windows can be 
labeled with a per-user type, maintaining separation.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
