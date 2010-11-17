Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oAHDdfa4012031
	for <selinux@tycho.nsa.gov>; Wed, 17 Nov 2010 08:39:41 -0500
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id oAHDdePC023159
	for <selinux@tycho.nsa.gov>; Wed, 17 Nov 2010 13:39:40 GMT
Message-ID: <4CE3DB1B.2010602@tresys.com>
Date: Wed, 17 Nov 2010 08:39:39 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Roberto Sassu <roberto.sassu@polito.it>
CC: refpolicy@oss1.tresys.com, selinux@tycho.nsa.gov
Subject: Re: [refpolicy] SELinux UBAC question
References: <201011171354.03646.roberto.sassu@polito.it>
In-Reply-To: <201011171354.03646.roberto.sassu@polito.it>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/17/10 07:54, Roberto Sassu wrote:
> i'm using the Fedora 13 operating system with shipped SELinux policy.
> I want to add a basic protection for regular users by using the UBAC feature and
> letting them to log on the system with the confined domain 'user_t'.
> A problem that i have found when using the policy with this feature enabled
> is that root logs on the system with user 'unconfined_u' or 'root' and files created
> or updated after doing an administrative task cannot be accessed by regular users.
> In order to have the system working i have to execute root processes that
> make changes on the system with user 'system_u'.

This should only be the case for user files and domains.  Other system
files, such as those in /etc, should be unaffected.

> One solution to overcome this issue may be to add an exception to the policy,
> as done for the 'system_u' user, so that UBAC will be applied only to SELinux users
> tied to regular users, living other users 'sysadm_u', 'staff_u', 'root', 'unconfined_u'
> unprotected.
> Does this is the right way to modify the policy in order to enforce the protection
> required or there are other alternatives?

It depends on your security goals.  If that still meets your goals, then
yes.  I would not include this upstream as it requires separation of all
users.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
