Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4OEA8R7008931
	for <selinux@tycho.nsa.gov>; Wed, 24 May 2006 10:10:08 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4OEA7kk005858
	for <selinux@tycho.nsa.gov>; Wed, 24 May 2006 14:10:07 GMT
Subject: Re: HTTPD network access Policy Problem
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Christopher L Tubbs II <chris@tubbs-net.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <44738020.3090200@tubbs-net.com>
References: <44738020.3090200@tubbs-net.com>
Content-Type: text/plain
Date: Wed, 24 May 2006 10:12:49 -0400
Message-Id: <1148479969.31984.183.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-23 at 17:35 -0400, Christopher L Tubbs II wrote:
> I'm reasonably new to SELinux, but I noticed recently that a change I
> made in my policy (from the GUI system-config-securitylevel) a while
> back to allow the HTTPD to have network access so I can use Web-based
> mail scripts now does not seem to work. The only change I've made since
> then was period "yum update" with the occasionally policy updates
> through that. However, despite the fact that the GUI still shows the
> settings that I had changed in the past, the policy is still blocking
> access (It works in Permissive mode). Can anybody perhaps explain why
> this might be, and what specifically I should check to verify the
> settings and make this functional again?

First we need to see the denial messages (avc: denied messages) to see
exactly what permissions are being denied.  You can find them
in /var/log/messages (or /var/log/audit/audit.log if you have auditd
running).

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
