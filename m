Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0J37kRb018866
	for <selinux@tycho.nsa.gov>; Sun, 18 Jan 2004 22:07:47 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0J36axr008293
	for <selinux@tycho.nsa.gov>; Mon, 19 Jan 2004 03:06:36 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id i0J36aYc008290
	for <selinux@tycho.nsa.gov>; Mon, 19 Jan 2004 03:06:36 GMT
Message-ID: <400B49EE.2080502@redhat.com>
Date: Sun, 18 Jan 2004 22:07:26 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Bill McCarty <bmccarty@pt-net.net>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: RHEL 3 policy and policy-sources RPMs
References: <222304176.1074345262@[192.168.0.100]>
In-Reply-To: <222304176.1074345262@[192.168.0.100]>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Bill McCarty wrote:

> Hi all,
>
> (1) I'm setting up another SELinux host on RHEL3, in addition to the 
> one I successfully set up a few days back. I downloaded RPMs from 
> people.redhat.com, but find that prelink.te and several other TE files 
> (rpm.te, slocate.te) have syntax errors that prevent me from 
> successfully making the policy. For instance:
>
> ERROR 'syntax error' at token '-' on line 102125:

Sorry about that a couple of packages had fallen behind on the RHEL3 
tree.  You need to upgrade your version of Check Policy.  The "-XYZ" 
syntax has been added to say get everything in this category except XYZ.

>
>
>> allow prelink_t {root_dir_type file_type -shadow_t} :{ file dir lnk_file
>> } { getattr read}; /usr/bin/checkpolicy:  error(s) encountered while
>> parsing configuration
>
>
> It appears that an unwanted dash has been introduced. Unfortunately, 
> after deleting the offending dashes, I ran into other problems:
>
>> security:  3 users, 5 roles, 1066 types
>> security:  30 classes, 134765 rules
>> assertion on line 130825 violated by allow rpm_t shadow_t:file {
>> relabelfrom relabelto }; assertion on line 130824 violated by allow
>> prelink_t shadow_t:file { read }; assertion on line 130824 violated by
>> allow rpm_t shadow_t:file { relabelfrom relabelto }; assertion on line
>> 130824 violated by allow locate_t shadow_t:file { read }; make: ***
>> [/etc/security/selinux/policy.15] Error 1
>
>
> As a temporary expedient, I changed the relevant lines of assert.te to:
>
> neverallow ~{ auth auth_write } shadow_t:file ~{ getattr read 
> relabelfrom relabelto };
> neverallow ~auth_write shadow_t:file ~{ read getattr lock ioctl 
> relabelfrom relabelto};
>
> After these changes, the policy compiles. I don't yet know how well it 
> works.
>
> Obviously, I understand that this policy is under active development 
> and I don't want to seem to whine about such problems. But, are there 
> better or worse times for users to work with it <g>? If so, I'd like 
> to get in sync.
>
I try to keep everything in sync, and most of the active work is being 
done for Fedora Core.  But I will try to keep everything in sync on 
RHEL3 in the future.

> (2) Also, I'm curious why some policy source files are found in both 
> the policy and policy-sources RPMs.
>
I didn't know that I will look.

> Thanks, in any case, to Daniel and other who're working on this policy!
>
> Cheers,
>
> ---------------------------------------------------
> Bill McCarty
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
