Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9TNSpTj008470
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2008 19:28:52 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9TNSpgv025983
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2008 23:28:51 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id m9TNSk13020259
	for <selinux@tycho.nsa.gov>; Wed, 29 Oct 2008 19:28:47 -0400
Message-ID: <4908F1AA.9060006@redhat.com>
Date: Thu, 30 Oct 2008 09:28:42 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Subject: Re: user guide draft: "Examples: Booleans for NFS"
References: <4905320C.4090807@redhat.com> <49085722.7010901@redhat.com>
In-Reply-To: <49085722.7010901@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Murray McAllister wrote:
>> Hi,

>>
>> Apache HTTP Server
>>
>> To allow access to NFS file systems (files labeled with the nfs_t type):
>> /usr/sbin/setsebool -P httpd_use_nfs on
>>
>> To allow access to Samba file systems (files labeled with the cifs_t type):
>> /usr/sbin/setsebool -P httpd_use_cifs on
[snip]
> Looks good, only problem with describing booleans is that they might not
> exist on all versions of policy.  The description above will require 5.3
> policy on RHEL5.

I added a note:

These Booleans exist in SELinux policy as shipped with Fedora 10. They 
may not exist in policy shipped with other versions of Fedora or other 
operating systems.

I'll keep these things in mind when the guide is forked for Red Hat 
Enterprise Linux.

Cheers.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
