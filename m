Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9TCUEXZ007353
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 08:30:14 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9TCStMb023259
	for <selinux@tycho.nsa.gov>; Fri, 29 Oct 2004 12:28:55 GMT
Subject: Re: make policy complains on file_contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Alex Ackerman <alex@darkhonor.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <A52BEA1D8EE8634B9196A136333637B1DAF0@maat.darkhonor.net>
References: <A52BEA1D8EE8634B9196A136333637B1DAF0@maat.darkhonor.net>
Content-Type: text/plain
Message-Id: <1099052805.19703.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 29 Oct 2004 08:26:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-10-28 at 16:24, Alex Ackerman wrote:
> I'm trying to build a policy for Eclipse (http://www.eclipse.org) and
> I'm using the existing policy for Mozilla as a guide. However, I am
> finding problems when trying to compile the policy.  The error I
> receive is:
> 
> Building file_contexts ...
> /usr/bin/checkpolicy -o policy.18 policy.conf
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> security:  6 users, 6 roles, 1204 types, 28 bools
> security:  53 classes, 265518 rules
> /usr/bin/checkpolicy:  policy configuration loaded
> /usr/bin/checkpolicy:  writing binary representation (version 18) to
> policy.18
> Validating file_contexts ...
> /usr/sbin/setfiles -q -c policy.18 file_contexts/file_contexts
> /usr/sbin/setfiles:  invalid context
> system_u:object_r:user_eclipse_rw_t on line number 898
> make: *** [policy.18] Error 1
> 
> The line in question in file_contexts/program/eclipse.fc is:
> HOME_DIR/\.eclipse(/.*)?        system_u:object_r:ROLE_eclipse_rw_t
> 
> Eclipse stores user configuration and workspace information in the
> user's home directory (.eclipse and workspace). So I followed the
> Mozilla model exactly (actually, just cut and pasted into the new file
> and renamed mozilla -> eclipse).  Any ideas how to decipher solve this
> one?

The most likely cause is that the type (user_eclipse_rw_t) is not
defined in your policy.  Note that the mozilla policy, like many other
policies, is primarily defined via a macro (defined in
macros/program/mozilla_macros.te) that is included by each user domain
to instantiate a mozilla program domain for each user domain.  The
relevant line in macros/base_user_macros.te is:
ifdef(`mozilla.te', `mozilla_domain($1)')

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
