Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8ODUPdV011663
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2008 09:30:25 -0400
Received: from rv-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8ODTSbr021575
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2008 13:29:28 GMT
Received: by rv-out-0708.google.com with SMTP id f25so2687417rvb.54
        for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2008 06:30:24 -0700 (PDT)
References: <alpine.LRH.1.10.0809240910240.32319@tundra.namei.org> <48D98748.6090408@ak.jp.nec.com> <48DA3A19.6070706@redhat.com>
Message-Id: <3017AED7-03AE-457D-A47A-D7A6C8F18860@gmail.com>
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <48DA3A19.6070706@redhat.com>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (iPhone Mail 5F136)
Subject: Re: How to find SELinux policy type?
Date: Wed, 24 Sep 2008 06:30:20 -0700
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, James Morris <jmorris@namei.org>,
        SELinux <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Have you tried issueing the command
Sestatus -vv
Should give you the name of the policy

justin P. Mattock



On Sep 24, 2008, at 6:01 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> KaiGai Kohei wrote:
>> James Morris wrote:
>>> Is there a programmatic way to determine the type of SELinux policy
>>> configured on a system? (e.g. "targeted")
>>>
>>> I've looked in the SELinux userspace and SETools repositories but  
>>> not
>>> found a library call to do this.
>>
>> I also want to know the way to obtain the list of policy types,
>> because it is necessary to make a specfile which provides policy
>> modules.
>>
>> Thanks
> There is no list of policy types since anyone can make up a new policy
> type.  The convention used within system-config-selinux is to list the
> directory names under /etc/selinux/.
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>
> iEYEARECAAYFAkjaOhkACgkQrlYvE4MpobMFiACfbt6gs0dVCDTRgMH2DqgbAmUJ
> l7YAoNBOUnViBZkEMnOdemkcJclbMXEw
> =pjX3
> -----END PGP SIGNATURE-----
>
> --
> This message was distributed to subscribers of the selinux mailing  
> list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
>  with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
