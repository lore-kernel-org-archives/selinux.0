Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j61JKugA003513
	for <selinux@tycho.nsa.gov>; Fri, 1 Jul 2005 15:20:56 -0400 (EDT)
Received: from south-border.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j61JJfQO020194
	for <selinux@tycho.nsa.gov>; Fri, 1 Jul 2005 19:19:41 GMT
Date: Fri, 1 Jul 2005 15:19:36 -0400 (EDT)
From: The UnSeen <ian@south-border.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: "Rix, Tom" <trix@camber.com>, selinux@tycho.nsa.gov
Subject: Re: SELinux auditing and NISPOM Ch 8
In-Reply-To: <1120152375.11798.113.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.GSO.4.60.0507011517410.25250@sandbox.south-border.com>
References: <C0F7E4581C28614D958C06117024FC9F03D69F@iris.camber.com>
 <1120152375.11798.113.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1120245576=:25250"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-851401618-1120245576=:25250
Content-Type: TEXT/PLAIN; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT


Or, Get RedHat ES/WS 3.0 updates 3 or 4 which have LAuS builtin with the 
possibility of enabling SELinux MAC.  I've not tried both at the same 
time though....

$.02

Ian


On Thu, 30 Jun 2005, Stephen Smalley wrote:

> On Thu, 2005-06-30 at 12:05 -0500, Rix, Tom wrote:
>> Does SELinux provide the level of auditing required by DSS NISPOM
>> chapter 8, legal and illegal rwx accesses?
>> Are there any resources (HOWTO’s) on how SELinux can be applied to
>> meeting any of the Chapter 8 requirements?
>
> SELinux itself only deals with auditing of MAC permission checks.  By
> default, it audits all MAC permission denials (but specific ones can be
> suppressed via dontaudit rules to avoid noise) and it can also be
> configured to audit specific allowed permissions via auditallow rules
> (e.g. to ensure that certain events like policy loads are always
> audited).
>
> The Linux 2.6 kernel provides an audit framework with more general
> auditing functionality, and a fair amount of work has gone into
> enhancing that functionality - see the linux-audit mailing list:
> http://www.redhat.com/mailman/listinfo/linux-audit
>
> If you want to experiment with some of that general auditing
> functionality, you might try Fedora Core 4 and its 'audit' package.
> That functionality should be included in an update to RHEL4, iirc.
>
> --
> Stephen Smalley
> National Security Agency
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

---559023410-851401618-1120245576=:25250--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
