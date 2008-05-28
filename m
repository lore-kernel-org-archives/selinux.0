Subject: rbacsep: collapsing xserver
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 28 May 2008 10:38:53 -0400
Message-Id: <1211985533.5008.116.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've got to the point where I am collapsing the derived types in the
xserver module.  It would be nice to collapse all of the X server
domains into xserver_t, but we have xdm_xserver_t which has permissions
greater than user_xserver_t, staff_server_t, etc.  However, just about
everyone runs their xserver in xdm_xserver_t due to logging in via xdm.
Thoughts on collapsing all of the xservers anyway?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
