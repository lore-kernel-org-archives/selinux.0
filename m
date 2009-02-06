Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n16LTVo2004085
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2009 16:29:31 -0500
Received: from mho-01-bos.mailhop.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n16LQK0d005194
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2009 21:26:20 GMT
Cc: SE Linux <selinux@tycho.nsa.gov>
Message-Id: <DB3575E3-FFF9-412D-A205-F02232694587@nall.com>
From: Joe Nall <joe@nall.com>
To: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <4988675F.30103@redhat.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: I need your new version of mcs with color incoding in Rawhide now...
Date: Fri, 6 Feb 2009 15:29:28 -0600
References: <4988675F.30103@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I pulled the changes together, added test cases and tested on rawhide.  
The result is v0.3.0-6 on github. I tested this version with the  
existing setrans.conf and it is backwards compatible.

git of mcstrans-0.3.0-6:
  git clone git://github.com/joenall/mcstrans.git
  cd mcstrans/
  git checkout 0.3.0-6

Look in /usr/share/mcstrans for examples/test cases and python code to  
exercise the new color api.

To test (in mls/permissive):
  sudo /usr/share/mcstrans/util/try-all

This swaps in various setrans configs and runs tests on each one.  
Backups of /etc/selinux/ recommended prior to test.

There is a setranspatch.te policy that addresses the policy problem  
discussed on the selinux mailing list today. It adds:

allow setrans_t self:context contains;

I can post src rpms if preferred.

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
