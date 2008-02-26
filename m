Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1QIK6xv028042
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 13:20:06 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1QIK6QG023943
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 18:20:06 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Global requirements were not met
Date: Tue, 26 Feb 2008 13:14:18 -0500
Message-ID: <1204049658.32061.189.camel@gorn>
In-Reply-To: <33491.80.95.164.250.1204041990.squirrel@www.a61.nl>
References: <33491.80.95.164.250.1204041990.squirrel@www.a61.nl>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: <selinux@a61.nl>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-02-26 at 17:06 +0100, selinux@a61.nl wrote:
> Still having problems setting up modules dor JBoss + Java:
> 
> I believe our JBoss module has a fine start now. We decided to write a
> complete new java-module (jbossjava) so we will be able to get java to
> work is strict-mode.
> 
> See the following files:
> myjboss.if: http://pastebin.com/f4df202a2
> myjboss.te: http://pastebin.com/d7318637b
> myjboss.fc: http://pastebin.com/f2f66ff68
> 
> jbossjava.if: http://pastebin.com/f179749e8
> jbossjava.te: http://pastebin.com/f1731b45d
> jbossjava.fc: http://pastebin.com/f52227f13
[...]
>    1:selinux-policy-strict  ########################################### [
> 33%]
> libsepol.print_missing_requirements: jbossjava's global requirements were
> not met: type/attribute jboss_rx_t
> libsemanage.semanage_link_sandbox: Link packages failed
> semodule:  Failed!
[...]
> Apparently, jbossjava doesn't have any access to the interfaces in
> myjboss.pp. why?

Its not an interface problem, jboss_rx_t isn't declared.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
