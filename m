Subject: Re: Selinux testsuite updated in latest LTP release
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joy Latten <latten@austin.ibm.com>
Cc: SELinux-dev@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <1144966405.2462.41.camel@faith.austin.ibm.com>
References: <1144966405.2462.41.camel@faith.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 09:14:03 -0400
Message-Id: <1145020443.11164.32.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-04-13 at 17:13 -0500, Joy Latten wrote:
> LTP has released ltp-20060411, their April release which contains
> the selinux testsuite with refpolicy!
> 
> Is there an selinux command/flag in which I can determine whether
> system is running refpolicy or old monolithic policy? 
> If so, I can modify testsuite such that it can run either policy. I am
> unable to determine this piece of info, so currently by default, the
> refpolicy gets used when running the testsuite.

There isn't a test for refpolicy vs. example policy per se, although
there is a way to test for managed vs. non-managed policy.  Example
policy would always fall into the non-managed category, whereas
refpolicy can be built either way (monolithic or modular), although it
is deployed in FC5 as modular/managed.

libsemanage provides a semanage_is_managed() interface; this is called
by semodule, setsebool, and semanage.  You could create a trivial python
script or C program that calls it to test whether the policy is managed
(if so, assume refpolicy; if not, assume example policy).  First you'd
want to check whether libsemanage even exists on the system, as it won't
in older releases (like FC4).  If it doesn't exist, then you can assume
example policy.  If it does exist, then you should run your python
script to call semanage_is_managed() to check whether policy is being
managed via libsemanage.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
