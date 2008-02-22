Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1MGVQ6B001552
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 11:31:26 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1MGVPYC012834
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 16:31:25 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m1MGBE5R025269
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 11:11:14 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m1MGBD8P005525
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 11:11:13 -0500
Received: from [10.11.14.227] (vpn-14-227.rdu.redhat.com [10.11.14.227])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m1MGBDcp012862
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 11:11:13 -0500
Subject: segfault in semodule
From: Eric Paris <eparis@redhat.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 22 Feb 2008 11:11:08 -0500
Message-Id: <1203696668.2914.25.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I added "allow-unknown = deny" in semanage.conf and ran semodule -R

[root@dhcp231-146 ~]# semodule -R
error parsing semanage configuration file: syntax error
semodule:  Could not create semanage handle
semodule: handle.c:123: semanage_is_connected: Assertion `sh != ((void *)0)' failed.
Segmentation fault

It was supposed to bail (allow-unknown is not a valid entry, it should
be handle-unknown) but it wasn't supposed to segfault.  Maybe someone
who knows this code can find/fix it really quickly, if not I'm sure I'll
get to look at it when it gets to the top of my list in 10 or 12
months  :)

policycoreutils-2.0.43-2.fc9.x86_64

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
