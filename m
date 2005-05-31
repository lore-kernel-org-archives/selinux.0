Subject: RE: file_type_auto_trans is not sufficient
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Karl MacMillan <kmacmillan@tresys.com>, SELinux@tycho.nsa.gov,
   dwalsh@redhat.com
In-Reply-To: <1117559223.28924.202.camel@moss-spartans.epoch.ncsc.mil>
References: <200505311632.j4VGW95F032656@gotham.columbia.tresys.com>
	 <1117558114.4455.0.camel@dhcp83-8.boston.redhat.com>
	 <1117559223.28924.202.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 31 May 2005 13:37:23 -0400
Message-Id: <1117561043.4455.1.camel@dhcp83-8.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Problem is that they both want to create directly in /tmp.  It would be
> preferable if they had a dedicated subtree, e.g. /tmp/gconfd
> and /tmp/orbit, with all per-user subdirectories underneath, so that the
> top-level directory could be typed separately and set up a priori (at
> boot if truly under /tmp, as they might otherwise have been deleted).

So you're saying that the directories should be created ahead of time by
a startup script, and restorecon executed on them... something 
like tmpskel? Maybe that can be used for libICE, which I want to
label /tmp/.ICE-unix as ice_tmp_t.

What about /home, which has the same problem, but directories can't be
created ahead of time (adding to /skel doesn't work - if an application
is installed, the users created prior to installation have no folder).

What about file conflicts - then you can't create directories ahead of
time... 

> BTW, what will per-user /tmp directories due to these conventions
> anyway, even aside from any possible SELinux-related change?

What's the question again?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
