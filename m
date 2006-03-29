Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2TNSkx8013991
	for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2006 18:28:46 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2TNSi77027929
	for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2006 23:28:45 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k2TNSklQ024243
	for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2006 18:28:46 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.11.6) with ESMTP id k2TNSjxW022616
	for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2006 18:28:45 -0500
Message-ID: <442B182D.9060104@redhat.com>
Date: Wed, 29 Mar 2006 18:28:45 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>,
        "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Subject: Need testers for Modules policicy on RHEL4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have back ported the entire selinux tool chain to RHEL4.  I have also 
attempted to create a modular policy to match RHEL4 policy as closely as 
possible.

These packages are out on

ftp://people.redhat.com/dwalsh/SELinux/RHEL4_MODULAR

If anyone wants to play with these and do some testing that would be great.

There is no commitment from Red Hat to ever ship this.  But if it is 
ever going to ship,
we need to find problems with it now.

So if you have a spare RHEL4 box and want to play with modular policy, 
this is your chance.

Thanks,


Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
