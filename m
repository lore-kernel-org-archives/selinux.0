Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8FD4bvd029614
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2008 09:04:37 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8FD3mFP028390
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2008 13:03:49 GMT
Message-ID: <48CE5D27.7060609@redhat.com>
Date: Mon, 15 Sep 2008 09:03:35 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Murray McAllister <mmcallis@redhat.com>
CC: James Morris <jmorris@namei.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide draft: "Confined and Unconfined User Domains" review
References: <48C6236D.4020408@redhat.com> <48C67DCD.2030104@redhat.com> <48CDBA0A.3000801@redhat.com> <48CDC478.3050101@redhat.com>
In-Reply-To: <48CDC478.3050101@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Murray McAllister wrote:
> Murray McAllister wrote:
>> Daniel J Walsh wrote:
>>> Murray McAllister wrote:
>>>> Hi,
>>>>
>>>> The following is a draft of the "Confined and Unconfined User Domains"
>>>> section for the SELinux User Guide. Any comments and corrections are
>>>> appreciated.
>>>>
>>>> This is the last part of intro text.
>>>>
>>>> Thanks.
>>>>
>>>>
>>>> Confined and Unconfined User Domains
>>>>
>>>> Each Linux user account is mapped to an SELinux user identity when a
>>>> user login session is created, and the mapped SELinux user identity is
>>>> used in the security context for processes in that session. By default,
>>>> on Fedora 10, Linux users are mapped to the SELinux unconfined_u user.
>>>> This is seen by running the id -Z and /usr/sbin/semanage login -l
>>>> commands:
>>>>
>>>> # id -Z
>>>> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>>>> # /usr/sbin/semanage login -l
>>>>
>>>> Login Name                SELinux User              MLS/MCS Range
>>>>
>>>> __default__               unconfined_u              s0-s0:c0.c1023
>>>> root                      unconfined_u              s0-s0:c0.c1023
>>>> system_u                  system_u                  s0-s0:c0.c1023
>>>>
>>>> The first row, __default__, defines that any new Linux users created
>>>> that are not specifically mapped to an SELinux user, are mapped to the
>>>> SELinux unconfined_u user. For a description of each column, refer to
>>>> Chapter 3, SELinux Contexts. Unconfined Linux users are subject to
>>>> executable and writeable memory checks, and are also restricted by MCS
>>>> (and MLS, if the MLS policy is used). If they execute an object that
>>>> the
>>>> SELinux policy defines can transition from the unconfined_t domain to
>>>> its own confined domain, the unconfined Linux users are still
>>>> subject to
>>>> the restrictions of that confined domain.
>>>>
>>>> The following confined user domains are available in Fedora 10:
>>>>
>>>> guest_t: The guest_t domain is used for minimal-privileged Linux users.
>>> guest_u:  The guest_u SELinux user will default to the guest_t type when
>>> logging in. The guest_t domain ...
>>>> Linux users in this domain are not allowed to use the X Window System,
>>>> run set user ID (setuid) applications, and do not have network access.
>>>> For example, Permission denied errors are returned when using the ping
>>>> and ssh commands. These users are allowed a log in via a terminal
>>>> (including ssh).
>>>>
>>> Examples of setuid applications su, sudo.  I think you should say that
>>> the power of this is that they can never become root.
>>>
>>> guest_t, xguest_t, user_t are also prevented by default from executing
>>> code in their home directory or tmp directories, preventing them from
>>> execuing programs in directories they can write to.
>>>
>>>> xguest_t: The xguest_t domain is also for minimal-privileged Linux
>>>> users, but lets them use the X Window System. Linux users in this
>>>> domain
>>>> are not allowed to run setuid applications, and the only network access
>>>> allowed is Firefox connecting to web pages. These users are allowed to
>>>> log in via the X Window System and a terminal.
>>>>
>>>> user_t: The user_t domain is for standard Linux users. Linux users in
>>>> this domain are not allowed to run setuid applications. These users are
>>>> allowed to log in via the X Window System and a terminal, and have full
>>>> network access.
>>>>
>>>> [I think I got this wrong. I got permission denied when trying to use
>>>> ping as a user_u user (useradd -Z user_u test)]
>>>>
>>> ping is a setuid application.
>>>> staff_t: The staff_t domain is similar to user_t, except that Linux
>>>> users in this domain are allowed to run the setuid sudo application.
>>>>
>>> These should all be guest_u, xguest_u, staff_u, user_u.
>>>
>>> Finally saying they can not run setuid applications is somewhat
>>> incorrect.   The real prevention is they can not run setuid apps without
>>> a defined transition.  So all of the users can run passwd as an example,
>>> which is a setuid app.  But they can not run any application that does
>>> not allow a transition.
>>>> -- 
>>>> This message was distributed to subscribers of the selinux mailing
>>>> list.
>>>> If you no longer wish to subscribe, send mail to
>>>> majordomo@tycho.nsa.gov
>>>> with
>>>> the words "unsubscribe selinux" without quotes as the message.
>>>
>>
>> Hi,
>>
>> I have made some changes:
>>
>> Confined and Unconfined Users
>>
>> Each Linux user is mapped to an SELinux user via SELinux policy. This
>> allows Linux users to inherit the restrictions on SELinux users. By
>> default, on Fedora 10, Linux users are mapped to the SELinux
>> unconfined_u user. This Linux user mapping is seen by running the
>> /usr/sbin/semanage login -l command as the Linux root user:
>>
>> # /usr/sbin/semanage login -l
>>
>> Login Name                SELinux User              MLS/MCS Range
>>
>> __default__               unconfined_u              s0-s0:c0.c1023
>> root                      unconfined_u              s0-s0:c0.c1023
>> system_u                  system_u                  s0-s0:c0.c1023
>>
>> The following defines the default-mapping:
>>
>> __default__               unconfined_u              s0-s0:c0.c1023
>>
>> The following example demonstates adding a new Linux user, and that
>> Linux user being mapped to the SELinux unconfined_u user:
>>
>> 1. As the Linux root user, create a new Linux user named newuser:
>>
>> # /usr/sbin/useradd newuser
>>
>> 2. As the Linux root user, assign a password to the Linux newuser user:
>>
>> # passwd newuser
>> Changing password for user newuser.
>> New UNIX password: Enter a password
>> BAD PASSWORD: it is based on a dictionary word
>> Retype new UNIX password: Enter the same password again
>> passwd: all authentication tokens updated successfully.
>>
>> 3. Log out of your current session, and log in as the Linux newuser user.
>>
>> 4. When you log in, pam_selinux maps the Linux user to an SELinux user
>> (in this case, unconfined_u), and sets up the resulting SELinux
>> context. The Linux user's shell is then launched with this SELinux
>> context. To view the SELinux context for a Linux user, run the id -Z
>> command:
>>
>> [newuser@localhost ~]$ id -Z
>> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>>
>> If mcstrans is running, s0-s0:c0.c1023 is translated to
>> SystemLow-SystemHigh:
>>
>> [newuser@localhost ~]$ id -Z
>> unconfined_u:unconfined_r:unconfined_t:SystemLow-SystemHigh
>>
>> Confined and unconfined Linux users are subject to executable and
>> writeable memory checks, and are also restricted by MCS (and MLS, if
>> the MLS policy is used). If unconfined Linux users execute an
>> application that SELinux policy defines can transition from the
>> unconfined_t domain to its own confined domain, unconfined Linux users
>> are still subject to the restrictions of that confined domain. The
>> security benefit of this is that, even though a Linux user is running
>> unconfined, they can not override the SELinux policy for a confined
>> application, just because they (the user) are unconfined.
>>
>> The following confined SELinux users are available in Fedora 10:
>>
>> [ I have put most of this into a table, with with colums: User,
>> Domain, X Window System, su and sudo, Execute in home directory and
>> /tmp, Networking, and used ticks+crosses to minimize too much text]
>>
>> * Linux users in the guest_t, xguest_t, and user_t domains can only
>> run set user ID (setuid) applications if SELinux policy permits it
>> (such as passwd). They can not run the su and /usr/bin/sudo setuid
>> applications, and therefore, can not become the Linux root user with
>> these applications.
>>
>> * Linux users in the guest_t domain have no network access.
>>
>> * The only network access Linux users in the xguest_t domain have is
>> Firefox connecting to web pages.
>>
>> * By default, Linux users in the guest_t, xguest_t, and user_t domains
>> can not execute applications in their home directories or /tmp/,
>> preventing them from executing applications (which inherit users'
>> permissions) in directories that they have write access to. This
>> prevents flawed or malicious applications from modifying files users'
>> own.
>>
>> * Linux users in the guest_t can only log in via a terminal (including
>> ssh).
>>
>> * Linux users in the xguest_t, user_t and staff_t domains can log in
>> via the X Window System and a terminal.
> 
> What sudo access does staff_t have?
None by default.  This is something that needs to be setup by the admin.
Out of the box staff_u can reach sysadm_r which allows him to become
sysadm_t.

If you want to setup staff_u to be able to reach unconfined_t through
sudo, My blog explains how.


http://danwalsh.livejournal.com/18578.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
