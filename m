Subject: Re: make relabel: invalid context
From: Karl MacMillan <kmacmillan@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <20040328192930.GA12067@bern.cip.informatik.uni-muenchen.de>
References: <D571AD7F-7F4B-11D8-A7FC-000A95D903E6@student.kuleuven.ac.be>
	 <200403262039.i2QKdELb020746@turing-police.cc.vt.edu>
	 <5D73C9A0-7F6C-11D8-A718-003065725CB8@student.kuleuven.ac.be>
	 <200403270025.i2R0PK2l029036@turing-police.cc.vt.edu>
	 <20040328192930.GA12067@bern.cip.informatik.uni-muenchen.de>
Content-Type: text/plain
Message-Id: <1080565591.26822.16.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Mon, 29 Mar 2004 08:06:31 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-03-28 at 14:29, Thomas Bleher wrote:
> * Valdis.Kletnieks@vt.edu [2004-03-27 02:52]:
> > Is it possible that you've installed the SELinux software on the box, but
> > are still running on a non-SELinux kernel, and need a reboot?
> 
> I hit this problem when trying to use a version 16 policy on a kernel
> which was not configured for it (that is vanilla 2.6.4). Try to set
> POLICYCOMPAT = -c in the Makefile and also delete
> /etc/security/selinux/policy.16 , this should fix it.
> 

This problem should go away soon - support for version 16 (conditional)
policies is slated be included in kernel 2.6.5.

Karl

> Thomas
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
