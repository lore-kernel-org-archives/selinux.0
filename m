Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j42FC6gA019832
	for <selinux@tycho.nsa.gov>; Mon, 2 May 2005 11:12:07 -0400 (EDT)
Subject: Re: Updated Policy in Sourceforge CVS
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1114805046.6480.15.camel@moss-lions.epoch.ncsc.mil>
References: <1114805046.6480.15.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 May 2005 11:12:06 -0400
Message-Id: <1115046726.3337.6.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Oops.  I was in a sub-directory when I committed on Friday.  Everything
that was suppose to have been committed on Friday is now committed.

Sorry for any confusion that might have caused.


 On Fri, 2005-04-29 at 16:04 -0400, James Carter wrote:
> 1.23.14 2005-04-29
> 
> * Added afs policy from Andrew Reisse.
> 
> * Merged patch from Lorenzo Hernández García-Hierro which defines
> execstack and execheap permissions.  The patch excludes these
> permissions from general_domain_access and updates the macros for X,
> legacy binaries, users, and unconfined domains.
> 
> * Added nlmsg_relay permisison where netlink_audit_socket class is used.
> Added nlmsg_readpriv permission to auditd_t and auditctl_t.
> 
> * Merged some minor cleanups from Russell Coker and David Hampton.
> 
> * Merged patch from Dan Walsh.  Many changes made to allow targeted
> policy to run closer to strict and now almost all of non-userspace is
> protected via SELinux.  Kernel is now in unconfined_domain for targeted
> and runs as root:system_r:kernel_t.  Added transitionbool to
> daemon_sub_domain, mainly to turn off httpd_suexec transitioning.
> Implemented web_client_domain name_connect rules.  Added yp support for
> cups.  Now the real hotplug, udev, initial_sid_contexts are used for the
> targeted policy.  Other minor cleanups and fixes.  Auditd fixes by Paul
> Moore.
> 
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
