Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5EK2F5A029312
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 16:02:15 -0400
Received: from atlrel6.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5EK2Fs2016527
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 20:02:15 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070614195502.420663549@hp.com>
Date: Thu, 14 Jun 2007 15:55:02 -0400
To: selinux@tycho.nsa.gov
Cc: cpebenito@tresys.com
Subject: [PATCH 0/5] NetLabel reference policy patches
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset does two main things:

 1. Converts the unused netmsg initial SID into the base NetLabel SID
 2. Adds NetLabel corenet policy interface calls into those domains which
    require network access

The basic idea behind this change to the policy has been discussed on this
list before, but as a recap, the motivating force behind the change in #1 is
the ability to easily allow/disallow NetLabel labeled/unlabeled traffic on
a per-domain basis.

I've also just reposted the current kernel patch for reference in examining
this patchset.  While testing every single modified domain in this patchset
is almost impossible for little 'ole me I have run this policy on a recent
Fedora Rawhide system using the patched kernel and have not seen any
"{tcp,udp,rawip}_socket recvfrom" AVC denials during boot or normal operation.

Please consider these patches for inclusion into the Reference Policy.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
