Subject: Re: Policy Logic vs. Policy component?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20050605101828.68291.qmail@web51501.mail.yahoo.com>
References: <20050605101828.68291.qmail@web51501.mail.yahoo.com>
Content-Type: text/plain
Date: Mon, 06 Jun 2005 09:59:16 -0400
Message-Id: <1118066356.23249.21.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2005-06-05 at 03:18 -0700, Park Lee wrote:
> In Figure 2 of "The Flask Security Architecture:System
> Support for Diverse Security Policies", There is a
> statement:
> "The security server consults the labeling rules in
> the policy logic, determines a security context for
> the new object, ... ".
> 
> Here, can we replace the words "policy logic" with
> "policy component"?
> and Why it is called "policy logic"?

A policy component would be something like TE, RBAC, or MLS.  Policy
logic is a more general term.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
