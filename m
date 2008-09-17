Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8H5ipEL012260
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2008 01:44:51 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8H5i174019417
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2008 05:44:01 GMT
Message-ID: <48D09912.20101@redhat.com>
Date: Wed, 17 Sep 2008 15:43:46 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide draft: "Confined and Unconfined User Domains" review
References: <48C6236D.4020408@redhat.com> <48C67DCD.2030104@redhat.com>	 <48CDBA0A.3000801@redhat.com> <1221477007.13007.13.camel@sulphur.notebook.internal>
In-Reply-To: <1221477007.13007.13.camel@sulphur.notebook.internal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dominick Grift wrote:
> On Mon, 2008-09-15 at 11:27 +1000, Murray McAllister wrote:
> 
>> Hi,
>>
>> I have made some changes:
>>
>> Confined and Unconfined Users
>>
>> Each Linux user is mapped to an SELinux user via SELinux policy. This
> 
> I would call it SEinux user group because you can map several users to
> the same SELinux user group.
If I called this an SELinux group, would it cause confusion to users 
seeing "SELinux user" (instead of group) in the output of semanage user 
and semanage login?

>>  
>> allows Linux users to inherit the restrictions on SELinux users. By 
>> default, on Fedora 10, Linux users are mapped to the SELinux
> 
> I would say the Linux users are by default mapped to the __default__
> login, which (usually) in Fedora is mapped to unconfined_u SELinux user
> group.
I moved the text around a bit:

Each Linux user is mapped to an SELinux user via SELinux policy. This 
allows Linux users to inherit the restrictions on SELinux users. This 
Linux user mapping is seen by running the /usr/sbin/semanage login -l 
command as the Linux root user:

[output]

By default, on Fedora 10, Linux users are mapped to the SELinux 
__default__ login, which is mapped to the SELinux unconfined_u user. The 
following defines the default-mapping:

__default__               unconfined_u              s0-s0:c0.c1023
> 
> Please note though that currently __default__ login is mapped to user_u
> SELinux usr group in rawhide. You can verify this in rawhide by semanage
> login -a. I do not now if this can be considered a bug.
I think we talked on irc and you mentioned you might have changed this 
to user_u. I installed a new rawhide machine today, and __default__ and 
root are mapped to unconfined_u.
> 
>>  
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
> 
> This may in many cases be right however in SELinux world root is not all
> powerfull by itself. in this example you assume that root runs in the
> unconfined_t domain, which it does by default however one can run root
> in other domains as well.
Thanks! What about:

The following example demonstates adding a new Linux user, and that 
Linux user being mapped to the SELinux unconfined_u user. It assumes 
that the Linux root user is running unconfined, as it does by default on 
Fedora 10:
> 
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
>> (in this case, unconfined_u), and sets up the resulting SELinux context. 
>> The Linux user's shell is then launched with this SELinux context. To 
>> view the SELinux context for a Linux user, run the id -Z command:
>>
> 
> That is if __default__ login is mapped to unconfined SELinux user group.
Do I need to add a note about this, or is it clear that it is mapped to 
unconfined_u by default?
> 
>> [newuser@localhost ~]$ id -Z
>> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>>
>> If mcstrans is running, s0-s0:c0.c1023 is translated to 
>> SystemLow-SystemHigh:
> 
> I am not sure if by default that user is assigned all categories.
I added a new user (useradd) and they were assigned to all categories by 
default.
> 
>> [newuser@localhost ~]$ id -Z
>> unconfined_u:unconfined_r:unconfined_t:SystemLow-SystemHigh
>>
>> Confined and unconfined Linux users are subject to executable and 
>> writeable memory checks, and are also restricted by MCS (and MLS, if the 
>> MLS policy is used). If unconfined Linux users execute an application 
>> that SELinux policy defines can transition from the unconfined_t domain 
>> to its own confined domain, unconfined Linux users are still subject to 
>> the restrictions of that confined domain. The security benefit of this 
>> is that, even though a Linux user is running unconfined, they can not 
>> override the SELinux policy for a confined application, just because 
>> they (the user) are unconfined.
>>
>> The following confined SELinux users are available in Fedora 10:
>>
>> [ I have put most of this into a table, with with colums: User, Domain, 
>> X Window System, su and sudo, Execute in home directory and /tmp, 
>> Networking, and used ticks+crosses to minimize too much text]
>>
>> * Linux users in the guest_t, xguest_t, and user_t domains can only run 
>> set user ID (setuid) applications if SELinux policy permits it (such as 
>> passwd). They can not run the su and /usr/bin/sudo setuid applications, 
>> and therefore, can not become the Linux root user with these applications.
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
>> prevents flawed or malicious applications from modifying files users' own.
>>
>> * Linux users in the guest_t can only log in via a terminal (including 
>> ssh).
>>
>> * Linux users in the xguest_t, user_t and staff_t domains can log in via 
>> the X Window System and a terminal.
>>
>>
>> Thanks for your help.
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.

Thanks :)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
