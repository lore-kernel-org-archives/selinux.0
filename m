Message-Id: <200506302043.j5UKh17f031735@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>, "'Rix, Tom'" <trix@camber.com>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: SELinux auditing and NISPOM Ch 8
Date: Thu, 30 Jun 2005 16:42:59 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1120152375.11798.113.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Stephen Smalley
> Sent: Thursday, June 30, 2005 1:26 PM
> To: Rix, Tom
> Cc: selinux@tycho.nsa.gov
> Subject: Re: SELinux auditing and NISPOM Ch 8
> 
> On Thu, 2005-06-30 at 12:05 -0500, Rix, Tom wrote:
> > Does SELinux provide the level of auditing required by DSS NISPOM
> > chapter 8, legal and illegal rwx accesses?
> > Are there any resources (HOWTO's) on how SELinux can be applied to
> > meeting any of the Chapter 8 requirements?
> 
> SELinux itself only deals with auditing of MAC permission checks.  By
> default, it audits all MAC permission denials (but specific ones can be
> suppressed via dontaudit rules to avoid noise) and it can also be
> configured to audit specific allowed permissions via auditallow rules
> (e.g. to ensure that certain events like policy loads are always
> audited).
> 

Just to clarify - SELinux by itself probably does not meet these requirements
because failures from standard linux access control will not be audited.

> The Linux 2.6 kernel provides an audit framework with more general
> auditing functionality, and a fair amount of work has gone into
> enhancing that functionality - see the linux-audit mailing list:
> http://www.redhat.com/mailman/listinfo/linux-audit
> 
> If you want to experiment with some of that general auditing
> functionality, you might try Fedora Core 4 and its 'audit' package.
> That functionality should be included in an update to RHEL4, iirc.
> 

This framework should meet the requirements - it is designed to meet the CAPP
audit requirements which are very similar to NISPOM Ch 8. It will require
configuration, however, that as far as I know no one has done.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> --
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
