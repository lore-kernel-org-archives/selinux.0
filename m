Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7OJP3Ob010341
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2005 15:25:03 -0400 (EDT)
Received: from mail22.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7OJEbDh000551
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2005 19:14:38 GMT
Date: Wed, 24 Aug 2005 15:14:34 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Daniel J Walsh <dwalsh@redhat.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>,
   Darrel Goeddel <dgoeddel@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Ok I plead ignorance to the way MLS works.
In-Reply-To: <430CAE01.70405@redhat.com>
Message-ID: <Pine.LNX.4.63.0508241513540.12556@excalibur.intercode>
References: <430A33E5.1030100@redhat.com>  <1124815922.7874.124.camel@moss-spartans.epoch.ncsc.mil>
  <1124817712.7874.138.camel@moss-spartans.epoch.ncsc.mil>
 <1124820200.7874.163.camel@moss-spartans.epoch.ncsc.mil>  <430C75B4.3020008@redhat.com>
  <1124892792.11553.26.camel@moss-spartans.epoch.ncsc.mil>  <430C8944.6090306@redhat.com>
  <430CA3EC.8080102@trustedcs.com> <1124902596.11553.66.camel@moss-spartans.epoch.ncsc.mil>
 <430CAE01.70405@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 24 Aug 2005, Daniel J Walsh wrote:

> Ok, I changed the kernel to s0, and now all domains run in s0.  Problem is I
> want root to login as
> s0:c0.c127
> 

This will cause all of the files created by root to be labeled with all 
categories.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
