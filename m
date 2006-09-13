Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8DJB1Iw006892
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 15:11:01 -0400
Received: from macii.ads-oh.atg.titan.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8DJA9Nu025731
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 19:10:09 GMT
Mime-Version: 1.0
Message-Id: <p06002030c12ded62fc17@[192.168.50.32]>
Date: Wed, 13 Sep 2006 14:16:27 -0400
To: selinux@tycho.nsa.gov
From: Rosalie Hiebel <rosalie.hiebel@L-3Com.com>
Subject: Polyinstantiation based on context with MLS
Cc: <janak@us.ibm.com>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We're trying to understand the policy rules in relation to how 
instance directories of polyinstantiated directories get created when 
polyinstantiation is done by context.

My goal is to have a different instance directory created/mounted for 
each different context in which an application is running when it 
accesses this directory.  For example, if running in a context with 
MLS level s1-s1, I would expect to see a different instance than when 
running in that same context but whose MLS level is s2-s2.

The problem is that I cannot get a different instance set up in these 
2 cases;  whether running at s1 or s2, the instance directory has a 
context with an MLS level of SystemLow-SystemHigh.  This is the MLS 
range I had set up for the polyinstantiated dir (/var/poly) and the 
directory which contains the instances (/var/poly/poly-inst).

I added an entry to /etc/security/namespace.conf which contained "context"
   /var/poly   /var/poly/poly-inst context root,adm

My understanding was that the actual instance directory creation and 
mounting for a process was done through the pam_namespace module. 
Also, if my application called these pam session routines to set up 
instance directories, it would have to first call setexeccon prior to 
setting up a pam session.  (Otherwise, pam would override the 
"context" setting in namespace.conf and create/mount an instance 
based on user instead of context.)

To have instance directories actually created by context, I had my 
test program obtain its current context, set the mls level in this 
context to either "s1-s1" or "s2-s2", and then pass this context to 
both setcon and setexeccon.  It then calls the pam routines 
pam_start() and pam_open_session().  (I had set up a dummy "test" 
service in /etc/pam.d, and I passed this service name to pam_start 
along with a  "conversation" routine which simply returned 
PAM_SUCCESS.)

When I ran my test program, I looked at /var/log/secure, and 
pam_namespace indicated it had successfully set up and mounted the 
instance directory.

It appears that pam_namespace calls security_compute_member to obtain 
the context which it sets the newly created instance directory to 
after creating it.  Does the policy decide this based on the 
"type_member" rules ?  If this is the case, then this rule seems to 
state only what the type is, and the remaining part of the context 
seems to always be the context of my /var/poly directory.  If this is 
true, then how can it ever achieve having a different instance based 
on any component of the context (such as the MLS level) being 
different ?

I'd appreciate any suggestions.

Rosalie

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
