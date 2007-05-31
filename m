Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4VIsRhj026453
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 14:54:28 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4VIsOBu006749
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 18:54:24 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l4VIsEGg020257
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 14:54:14 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l4VIsDXo031756
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 14:54:13 -0400
Received: from [10.12.32.53] (redsox.boston.devel.redhat.com [10.12.32.53])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id l4VIsBvF029104
	for <selinux@tycho.nsa.gov>; Thu, 31 May 2007 14:54:13 -0400
Message-ID: <465F19D1.7040706@redhat.com>
Date: Thu, 31 May 2007 14:54:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: With the release of Fedora Core 7 I have bumped the policy version
 in Rawhide
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Tomorrows rawhide will have selinux-policy-3.0.1. 

This policy is the first release of the merged (strict/targeted) 
policy.  As such there is no longer a selinux-policy-strict.  This is 
real experimental and I expect some problems.  I have been running it 
here for a couple of days. 

With this policy you can install the strict type users staff_u, user_u, 
sysadm_u.  As well as the unonfined_u/system_u.  You should be able to 
mix and match the users.  So if you want to setup a Guest X-Windows 
login you would set it up with a user of user_u:user_r:user_t.  And you 
might have your regular login as system_u:unconfined_r:unconfined_t.

The idea is if you remove the unconfined policy package, you will be 
basically running in strict policy mode.  (This has not been tested.) 

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
