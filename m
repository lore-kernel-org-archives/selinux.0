Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4IL04lM003495
	for <selinux@tycho.nsa.gov>; Fri, 18 May 2007 17:00:04 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4IL03qK014816
	for <selinux@tycho.nsa.gov>; Fri, 18 May 2007 21:00:03 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l4IL03KF030676
	for <selinux@tycho.nsa.gov>; Fri, 18 May 2007 17:00:03 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l4IKxupL019643
	for <selinux@tycho.nsa.gov>; Fri, 18 May 2007 17:00:02 -0400
Received: from [10.12.32.53] (redsox.boston.devel.redhat.com [10.12.32.53])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id l4IKxtxJ011534
	for <selinux@tycho.nsa.gov>; Fri, 18 May 2007 16:59:56 -0400
Message-ID: <464E13CB.1070609@redhat.com>
Date: Fri, 18 May 2007 16:59:55 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Fedora Core 7 has frozen and Fedora 8 Development has started
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a good time to get experimental code/updates into the rawhide 
stream. 

My goals for Fedora 8:

* Continued consolidation of targeted and strict policy.
          - Remove selinux-policy-strict package
          - Add all user roles from strict policy to targeted
          - Remove unconfined.pp and you have ~= Strict
          - Add new roles
                    - guest_r - terminal sessions only, no network, no 
setuid apps
                    - xguest_r - X-Windows version of guest_t
                    - webadm_r - UID 0 role that can administer http
                    - logadm_r  - UID 0 role that can administer 
syslog/audit


* Begin using Trusted X Extensions
          - Limited control on Screen Capture
          - Control access to keyboard input

* Continue confining all System Domains in Fedora.  (What used to be in 
Extras)

Others???



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
