Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jB9L5RMA022997
	for <selinux@tycho.nsa.gov>; Fri, 9 Dec 2005 16:05:27 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jB9KvOpK018792
	for <selinux@tycho.nsa.gov>; Fri, 9 Dec 2005 20:57:24 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id jB9KwC2B020491
	for <selinux@tycho.nsa.gov>; Fri, 9 Dec 2005 15:58:12 -0500
Message-ID: <4399EFE6.5040206@redhat.com>
Date: Fri, 09 Dec 2005 15:58:14 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Joe Orton <jorton@redhat.com>,
   Mark J Cox <mjc@redhat.com>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   Nalin Dahyabhai <nalin@redhat.com>
Subject: Adding two new booleans to httpd to tighten it's security.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Currently policy allows httpd to connect to relay ports and to 
mysql/postgres ports.

Adding these booleans
    * httpd_can_network_relay
    * httpd_can_network_connect_db

And turning this feature off by default.  This is going into tonights 
reference policy and into FC4 test release.
If we had these turned off we would have prevented the last apache worm 
virus. 

This could cause problems for people who run httpd relays or have their 
apache databases talking to mysql and postgres databases over the network.

You can turn the features back on by executing:
setsebool -P httpd_can_network_relay=1
or
setsebool -P httpd_can_network_connect_db=1

Will consider adding this feature to RHEL in a future update.

Comments?

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
