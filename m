Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9440rsJ014335
	for <selinux@tycho.nsa.gov>; Sat, 4 Oct 2003 00:00:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h943x4Zt007042
	for <selinux@tycho.nsa.gov>; Sat, 4 Oct 2003 03:59:04 GMT
Received: from sj-iport-3.cisco.com (sj-iport-3-in.cisco.com [171.71.176.72])
	by jazzswing.ncsc.mil  with ESMTP id h943x3M3007039
	for <selinux@tycho.nsa.gov>; Sat, 4 Oct 2003 03:59:03 GMT
Received: from franklin.cisco.com (franklin.cisco.com [171.70.156.17])
	by sj-core-5.cisco.com (8.12.9/8.12.6) with ESMTP id h9440oXg004226
	for <selinux@tycho.nsa.gov>; Fri, 3 Oct 2003 21:00:50 -0700 (PDT)
Received: from Cowboys.cisco.com (200@stealth-10-32-244-139.cisco.com [10.32.244.139]) by franklin.cisco.com (8.8.6 (PHNE_17190)/CISCO.SERVER.1.2) with SMTP id VAA29600 for <selinux@tycho.nsa.gov>; Fri, 3 Oct 2003 21:00:49 -0700 (PDT)
Date: Fri, 3 Oct 2003 21:00:14 -0700
From: Michael Reilly <michaelr@cisco.com>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Question about policy files and users
Message-Id: <20031003210014.7c76f52f.michaelr@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I downloaded the policy files from http://www.coker.com.au/selinux/policy/
and installed them on my Slackware system along with the selinux patches,
utills, etc. from the NSA site (the August release for a 2.4.21 kernel and
the old version of the API patches).

Everything went pretty well - I am now working on cleaning up the policy to
get rid of the remaining avc denied messages.

While working on this I noticed in the policy files I downloaded (and the
original policy files  included in the downloaded files from the NSA site)
in file_contexts/types.fc this entry -

/home/jadmin/(/.*)?                     system_u:object_r:staff_home_t

(I, of course, replaced jadmin with my login name).  My question is why is
the entry not -

/home/jadmin/(/.*)?                     jadmin_u:object_r:staff_home_t

When I created new files in my login directory while the selinux kernel is
running they are labeled jadmin_u:object_r:staff_home_t

Being new to selinux I think I am missing something - why does the home
directory and the files in that directory not set to the id of the owner
(jadmin_u) instead of system_u?  And is my system doing something wrong by
labeling newly created files in my login directory
jadmin_u:object_r:staff_home_t?

BTW - I installed gentoo selinux on a different machine.  Their installation
guide indicates that the later (jadmin_u:object_r:staff_home_t) is correct
and the policy files should be edited to use the jadmin_u).

Thanks for any help you can provide.

michael
-- 
---- ---- ----
Michael Reilly    michaelr@cisco.com
    Cisco Systems, Santa Cruz, CA

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
