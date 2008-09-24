Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8OD1d65005917
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2008 09:01:39 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8OD1cjk027027
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2008 13:01:39 GMT
Message-ID: <48DA3A19.6070706@redhat.com>
Date: Wed, 24 Sep 2008 09:01:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
Subject: Re: How to find SELinux policy type?
References: <alpine.LRH.1.10.0809240910240.32319@tundra.namei.org> <48D98748.6090408@ak.jp.nec.com>
In-Reply-To: <48D98748.6090408@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

KaiGai Kohei wrote:
> James Morris wrote:
>> Is there a programmatic way to determine the type of SELinux policy
>> configured on a system? (e.g. "targeted")
>>
>> I've looked in the SELinux userspace and SETools repositories but not
>> found a library call to do this.
> 
> I also want to know the way to obtain the list of policy types,
> because it is necessary to make a specfile which provides policy
> modules.
> 
> Thanks
There is no list of policy types since anyone can make up a new policy
type.  The convention used within system-config-selinux is to list the
directory names under /etc/selinux/.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjaOhkACgkQrlYvE4MpobMFiACfbt6gs0dVCDTRgMH2DqgbAmUJ
l7YAoNBOUnViBZkEMnOdemkcJclbMXEw
=pjX3
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
