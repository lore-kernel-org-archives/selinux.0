Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6K1rkXv005503
	for <selinux@tycho.nsa.gov>; Sun, 19 Jul 2009 21:53:46 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n6K1rNgY020911
	for <selinux@tycho.nsa.gov>; Mon, 20 Jul 2009 01:53:24 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n6K1riFr001006
	for <selinux@tycho.nsa.gov>; Sun, 19 Jul 2009 21:53:44 -0400
Date: Mon, 20 Jul 2009 11:53:38 +1000
From: Scott Radvan <sradvan@redhat.com>
To: SE Linux <selinux@tycho.nsa.gov>, fedora-selinux-list@redhat.com
Subject: Trying to cause a denial with rsync and SELinux
Message-ID: <20090720115338.247ede30@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello all,


I'm having troubles invoking _any_ denial whatsoever for rsync related
tasks, in order for me to demonstrate in my book how to then work
around it. 

I've made a custom init script for rsync as there is no existing one in
Fedora 11, so I labeled it initrc_exec_t so that the rsync daemon
transitions to rsync_t:

# ps -eZ | grep rsync
unconfined_u:system_r:rsync_t:s0  326 ?        00:00:00 rsync

According to the information I have, now that it's running as rsync_t,
the following Booleans should have an effect:

allow_rsync_anon_write

	No mattter the state of this Boolean, I can still write to 
	public_content_rw_t files, locally or over the LAN.

rsync_client

	I have very little information on this Boolean and what it
	actually implies, what it requires in terms of labels, etc. but
	no matter its state, rsync operates normally as a client
	reading and writing to a daemonized process on another machine.

rsync_export_all_ro

	Perhaps I'm misinterpreting this one as well, but no matter its
	state, I can read _and_ write the test files in the directory
	specified by the rsync daemon, locally and over the network.

Really, I'm probably misinterpreting these Booleans and their actual
implications, or doing something completely wrong.

I simply need a way that I can get SELinux to give me a denial related
to rsync (running as a daemon) which I can then document and demonstrate
the work-around for. My problem remains that everything works too _well_
and SELinux doesn't seem to be denying any of the access or transfers
I'm performing, whatever the state of these Booleans, based on my
limited understanding of them.

Does anyone have a better understanding of these particular Booleans,
what they actually imply, what labels the files need in order to be
affected by them, any other condition they require to enforce upon the
system...and mainly how I can intentionally invoke a denial based on
one of them?


Thanks in advance,


-- 
Scott Radvan
Content Author, Platform (Installation and Deployment)
Red Hat Asia Pacific (Brisbane) http://www.apac.redhat.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
