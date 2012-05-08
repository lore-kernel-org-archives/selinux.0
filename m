Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q48Gw2cV011483
	for <selinux@tycho.nsa.gov>; Tue, 8 May 2012 12:58:02 -0400
Message-ID: <4FA95098.1050201@tresys.com>
Date: Tue, 8 May 2012 12:58:00 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: RFC: packet checks always on option
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I recently became aware that the packet checks are now disabled when there are no SECMARK rules.  I missed the threads discussing this change (I realize its been some time), and the non-enforcement of a check isn't obvious.  Refpolicy's support of unlabeled packet usage also obscured the change.

My understanding on the rationale for this change was:

* when flushing iptables, it would lead to all networking being denied, which is opposite of the expected behavior of iptables (i.e. doesn't follow "least surprise")
* if you have no SECMARK rules, you probably don't care about the checks anyway

I completely understand these arguments, as they are reasonable functional arguments.  However, this behavior is "allow by default": the opposite of what SELinux stands for.  SELinux doesn't stop file checks if you mount an xattr filesystem that has no labels.  High assurance systems would actually want the old behavior so that networking would be denied if:

* iptables rules fail to load
* iptables rules maliciously flushed, e.g. by compromised domain that has net_admin
* during boot and shutdown you can guarantee no network access

I think this behavior should be restored, but in a pragmatic way.  I think we should have an option to toggle between packet checks always being on and packet checks on only if there are SECMARK rules.  Then distros can ship with the latter setting.  For the systems that care about it, they can use the former setting.  Then everyone wins.

Options for implementing this are:

* a policy capability
* a policy option similar to unknown permissions checking
* a SELinux option similar to how compat_net was

I think the policy capability is not the best choice, since it doesn't exactly follow the concept of a policy capability.  A policy capability would imply that there are no packet checks under any circumstance if the policy capability is off, which wouldn't be the case.  I don't know which of the latter two options are better, other than the latter wouldn't require toolchain changes.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
