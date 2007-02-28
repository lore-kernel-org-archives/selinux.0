Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1SEEgZB010962
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 09:14:42 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1SEG42u023164
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 14:16:05 GMT
Subject: Re: rpm-script needs to be able to look at running processes on
	the system
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45E31365.8060806@redhat.com>
References: <45E31365.8060806@redhat.com>
Content-Type: text/plain
Date: Wed, 28 Feb 2007 09:16:23 -0500
Message-Id: <1172672183.11157.53.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 12:05 -0500, Daniel J Walsh wrote:
> mcs is causing avc messages if usr logs in to root as s0, and wants to 
> do a yum update, rpm_script is not allowed to look at running processes 
> unless these privs are added.

Already in there, a few lines down.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
