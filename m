Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m89DinGx014648
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2008 09:44:49 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m89Din59025025
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2008 13:44:49 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m89DimGs002132
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2008 09:44:48 -0400
Message-ID: <48C67DCD.2030104@redhat.com>
Date: Tue, 09 Sep 2008 09:44:45 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Murray McAllister <mmcallis@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide draft: "Confined and Unconfined User Domains" review
References: <48C6236D.4020408@redhat.com>
In-Reply-To: <48C6236D.4020408@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Murray McAllister wrote:
> Hi,
> 
> The following is a draft of the "Confined and Unconfined User Domains"
> section for the SELinux User Guide. Any comments and corrections are
> appreciated.
> 
> This is the last part of intro text.
> 
> Thanks.
> 
> 
> Confined and Unconfined User Domains
> 
> Each Linux user account is mapped to an SELinux user identity when a
> user login session is created, and the mapped SELinux user identity is
> used in the security context for processes in that session. By default,
> on Fedora 10, Linux users are mapped to the SELinux unconfined_u user.
> This is seen by running the id -Z and /usr/sbin/semanage login -l commands:
> 
> # id -Z
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> # /usr/sbin/semanage login -l
> 
> Login Name                SELinux User              MLS/MCS Range
> 
> __default__               unconfined_u              s0-s0:c0.c1023
> root                      unconfined_u              s0-s0:c0.c1023
> system_u                  system_u                  s0-s0:c0.c1023
> 
> The first row, __default__, defines that any new Linux users created
> that are not specifically mapped to an SELinux user, are mapped to the
> SELinux unconfined_u user. For a description of each column, refer to
> Chapter 3, SELinux Contexts. Unconfined Linux users are subject to
> executable and writeable memory checks, and are also restricted by MCS
> (and MLS, if the MLS policy is used). If they execute an object that the
> SELinux policy defines can transition from the unconfined_t domain to
> its own confined domain, the unconfined Linux users are still subject to
> the restrictions of that confined domain.
> 
> The following confined user domains are available in Fedora 10:
> 
> guest_t: The guest_t domain is used for minimal-privileged Linux users.
guest_u:  The guest_u SELinux user will default to the guest_t type when
logging in. The guest_t domain ...
> Linux users in this domain are not allowed to use the X Window System,
> run set user ID (setuid) applications, and do not have network access.
> For example, Permission denied errors are returned when using the ping
> and ssh commands. These users are allowed a log in via a terminal
> (including ssh).
> 
Examples of setuid applications su, sudo.  I think you should say that
the power of this is that they can never become root.

guest_t, xguest_t, user_t are also prevented by default from executing
code in their home directory or tmp directories, preventing them from
execuing programs in directories they can write to.

> xguest_t: The xguest_t domain is also for minimal-privileged Linux
> users, but lets them use the X Window System. Linux users in this domain
> are not allowed to run setuid applications, and the only network access
> allowed is Firefox connecting to web pages. These users are allowed to
> log in via the X Window System and a terminal.
> 
> user_t: The user_t domain is for standard Linux users. Linux users in
> this domain are not allowed to run setuid applications. These users are
> allowed to log in via the X Window System and a terminal, and have full
> network access.
> 
> [I think I got this wrong. I got permission denied when trying to use
> ping as a user_u user (useradd -Z user_u test)]
> 
ping is a setuid application.
> staff_t: The staff_t domain is similar to user_t, except that Linux
> users in this domain are allowed to run the setuid sudo application.
> 
These should all be guest_u, xguest_u, staff_u, user_u.

Finally saying they can not run setuid applications is somewhat
incorrect.   The real prevention is they can not run setuid apps without
a defined transition.  So all of the users can run passwd as an example,
which is a setuid app.  But they can not run any application that does
not allow a transition.
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
