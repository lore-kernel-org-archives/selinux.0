Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m25FmD4X020729
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 10:48:13 -0500
Received: from ns1.a61.nl (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m25FmBMB012128
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 15:48:11 GMT
Message-ID: <51324.80.95.164.250.1204732077.squirrel@www.a61.nl>
In-Reply-To: <1204730645.14217.39.camel@gorn>
References: <37866.80.95.164.250.1204712494.squirrel@www.a61.nl>
    <1204730645.14217.39.camel@gorn>
Date: Wed, 5 Mar 2008 16:47:57 +0100 (CET)
Subject: Re: Unreserved portnumbers in corenetwork
From: selinux@a61.nl
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@a61.nl, selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
> Unfortunately there are 3 forces at work.  The first is that for the
> most part, ports should always be labeled, because, for example, port 80
> is always going to be regarded as the http port.  The second is that
> thats not always the case for non well-defined ports (your situation).
> The third is that portcons (the port labeling statements) only work in
> the base module.  So, though we want to make a happy medium between the
> first two, we can't overcome the final one within the constraints of the
> current toolchain.
>

Agree with that. But wouldn't the situation be a little less complicated
if you decide not to define any ports above 1024 in the reference policy?

If you decide to do that, you could create a portcon that allows a single
active module to claim a port above 1024 on a per module basis. A second
module could claim another one, as long as it's not equal to the first
(active) one.

In this way you create a generic handler for modules that need ports above
1024 and can create a reference policy with modules with the same ports.
As long as they are not both active, you wouldn't have any problem.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
