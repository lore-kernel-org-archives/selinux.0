Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA9Dnrkh018502
	for <selinux@tycho.nsa.gov>; Thu, 9 Nov 2006 08:49:53 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA9DnA18018379
	for <selinux@tycho.nsa.gov>; Thu, 9 Nov 2006 13:49:10 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id kA9Do31D001993
	for <selinux@tycho.nsa.gov>; Thu, 9 Nov 2006 08:50:03 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id kA9Do3jG000445
	for <selinux@tycho.nsa.gov>; Thu, 9 Nov 2006 08:50:03 -0500
Received: from [10.11.14.182] (vpn-14-182.rdu.redhat.com [10.11.14.182])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id kA9Do0ZT014273
	for <selinux@tycho.nsa.gov>; Thu, 9 Nov 2006 08:50:02 -0500
Message-ID: <45533208.6050806@redhat.com>
Date: Thu, 09 Nov 2006 08:50:00 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: I would like to propose that we add compression to handle all policy
 files on disk.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We are currently storing three sets of pp files on disk in Fedora as 
well as a policy.21 file
To get an idea of how much space we can save, I did this little 
experiment.    I believe this change is
critical for minimal installs, and if we want to eventually use SELinux 
on certain small platforms.

I think just changing libsemanage to handle compressed policy packages 
and to create its itermediary files as compressed files and changing 
libselinux able to read a compressed policy.21 file.

# tar cvf /tmp/selinux /etc/selinux/targeted /usr/share/selinux/targeted/
# gzip -c /tmp/selinux > /tm/selinux.gz

# du /tmp/selinux*
57380   /tmp/selinux
3772    /tmp/selinux.gz


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
