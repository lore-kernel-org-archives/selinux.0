Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA4BbYoN011431
 for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2014 06:37:34 -0500
Received: from [192.168.0.11] (ppp118-209-31-33.lns20.mel4.internode.on.net
 [118.209.31.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: russell@coker.com.au)
 by smtp.sws.net.au (Postfix) with ESMTPSA id 36F612085D
 for <selinux@tycho.nsa.gov>; Tue,  4 Nov 2014 22:37:28 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: user_r/sysadm_r/staff_r/unconfined_r
From: Russell Coker <russell@coker.com.au>
Date: Tue, 04 Nov 2014 22:37:18 +1100
To: selinux@tycho.nsa.gov
Message-ID: <0AFA7D5E-B2E1-43BA-875B-AC941EB36E50@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The role separation seems to give no benefit apart from sysadm_r/unconfined_r given that we have seuser based constraints and MCS labels to separate users and that they all use the same types.

The current policy doesn't support even logging in with a user other than unconfined_r on Debian/Unstable without significant changes.

Is there any reason for not ripping out all but 2 roles, one for root (and other sysadmin accounts but not GNOME/KDE sessions) and the other for regukar users?

Doing that will make the policy smaller and simpler (for us and users) while not losing any functionality for most users. Where most users probably means everyone who doesn't develop their own policy. The people who do develop their own policy which depends on multiple roles probably have to do plenty of work on systems with the current policy anyway.

I think that sysadm_r/unconfined_r should not transition for programs like gpg.

NB staff_r is my invention. Before that we only had sysadm_r and user_r. I invented staff_r before MCS and the seuser constraints were developed. 
-- 
Sent from my Samsung Galaxy Note 3 with K-9 Mail.
