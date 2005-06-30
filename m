Subject: Re: SELinux auditing and NISPOM Ch 8
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Rix, Tom" <trix@camber.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <C0F7E4581C28614D958C06117024FC9F03D69F@iris.camber.com>
References: <C0F7E4581C28614D958C06117024FC9F03D69F@iris.camber.com>
Content-Type: text/plain; charset=utf-8
Date: Thu, 30 Jun 2005 13:26:15 -0400
Message-Id: <1120152375.11798.113.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-30 at 12:05 -0500, Rix, Tom wrote:
> Does SELinux provide the level of auditing required by DSS NISPOM
> chapter 8, legal and illegal rwx accesses?  
> Are there any resources (HOWTO’s) on how SELinux can be applied to
> meeting any of the Chapter 8 requirements? 

SELinux itself only deals with auditing of MAC permission checks.  By
default, it audits all MAC permission denials (but specific ones can be
suppressed via dontaudit rules to avoid noise) and it can also be
configured to audit specific allowed permissions via auditallow rules
(e.g. to ensure that certain events like policy loads are always
audited).

The Linux 2.6 kernel provides an audit framework with more general
auditing functionality, and a fair amount of work has gone into
enhancing that functionality - see the linux-audit mailing list:
http://www.redhat.com/mailman/listinfo/linux-audit

If you want to experiment with some of that general auditing
functionality, you might try Fedora Core 4 and its 'audit' package.
That functionality should be included in an update to RHEL4, iirc.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
