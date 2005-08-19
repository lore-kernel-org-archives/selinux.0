Message-Id: <200508191842.j7JIgsss003461@gotham.columbia.tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "'James Morris'" <jmorris@namei.org>,
   "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Steve G'" <linux_4ever@yahoo.com>, <SELinux-dev@tresys.com>
Subject: RE: [RFC] Checking the loaded policy against a policy on disk
Date: Fri, 19 Aug 2005 14:42:54 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <Pine.LNX.4.63.0508191105290.24678@excalibur.intercode>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Can you point me to the LSPP requirement which states that we need to
> do this? 

I was wondering that myself. I don't recall any such requirement. As long as
the policy files are protected against unauthorized access and procedures
for start up/initialization are documented in appropriate manual, we
shouldn't be "required" to have a demonstrable association (thought
something like this might be otherwise useful). I believe the requirements
are for TCB/TSF protection, not periodic guarantee checks (except for
FPT_AMT which explicitly only applies to hardware). Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
