Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l04AswoI031910
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 05:54:58 -0500
Received: from smtp-out-0101.amazon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l04AthOg000333
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 10:55:44 GMT
Received: from ex-gate-02.ant.amazon.com (ex-gate-02.sea3.amazon.com [172.20.6.102])
	by smtp-in-5103.iad5.amazon.com (8.12.11/8.12.10) with ESMTP id l04Atfo0012806
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 02:55:41 -0800
Subject: creating a new role/user to administer a service
From: Ronan Waide <waider@amazon.com>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1167908139.19878.12.camel@waider.desktop.amazon.com>
Mime-Version: 1.0
Date: Thu, 04 Jan 2007 10:55:39 +0000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I've been digging through SELinux by example, the list archives, Dan
Walsh's livejournal, and the Fedora strict policy source, but I'm still
a bit stumped on how to get this working:

I'd like to create an administrative role/user for BIND. specifically, I
do not, if possible, want to use something like sysadm_r; I would rather
that otherwise unprivileged users are either designated as bindadm_u
from login, or newrole into bindadm_r in order to manage the daemon. The
former is preferable, as I was hoping to make use of ssh keys to enable
remote management without multiple password entry.

After several false starts I thought I had something with the following
(requires trimmed):

------
type bindadm_t;
role bindadm_r types { bindadm_t };
gen_user( bindadm_u, staff, bindadm_r, s0, s0 - s15:c0.c1023, c0.c1024
);

semanage login -a -s bindadm_u -r bindadm_r waider
------

I began tracking the AVC violations that logging in with this account
caused, and got as far as being able to get a shell prompt with the
context bindadm_u:bindadm_r:user_t. At this point I tried getting
newrole -t bindadm_t to work, but couldn't get past the password check
requirement (allow bindadm_r chkpasswd_exec_t) since nothing I did
seemed to resolve the violation.

At this point I am, as I said, stumped. I feel like I'm missing
something obvious, but after several weeks of reading I'm still no
closer to the answer. Perhaps someone could shed some light on this, or
perhaps point me at a suitable role/user-addition document?

Cheers,
Waider.
-- 
Ronan Waide / TechOps EU Systems Engineer / waider@amazon.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
