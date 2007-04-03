Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l33BiMqa020961
	for <selinux@tycho.nsa.gov>; Tue, 3 Apr 2007 07:44:22 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l33BiKJV013596
	for <selinux@tycho.nsa.gov>; Tue, 3 Apr 2007 11:44:21 GMT
Received: by ug-out-1314.google.com with SMTP id y2so317883uge
        for <selinux@tycho.nsa.gov>; Tue, 03 Apr 2007 04:44:19 -0700 (PDT)
Message-ID: <9d1b82480704030444n6dcc45c2t574e100c98b41816@mail.gmail.com>
Date: Tue, 3 Apr 2007 17:14:18 +0530
From: Pravin <shindepravin@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: Compatibility between binary policy file and kernel version
Cc: "SELinux List" <selinux@tycho.nsa.gov>
In-Reply-To: <1175535336.5889.72.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <9d1b82480704020747v1f05b267j874c4bb2d3f1f941@mail.gmail.com>
	 <1175526715.5889.55.camel@moss-spartans.epoch.ncsc.mil>
	 <1175535336.5889.72.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
> Also, are there any differences in the kernel configs between those
> kernels, particularly for security-related options?

well, there was difference in kernel config files.
After some trial and error, i found out following three config
options, after setting them filesystem labels were recognized :-).

{{{
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
}}}

> grep SECURITY .config
>
This is output of grep SECURITY .config
after above modifications
{{{
CONFIG_EXT2_FS_SECURITY=y
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
CONFIG_SECURITY_CAPABILITIES=y
# CONFIG_SECURITY_SECLVL is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
# CONFIG_SECURITY_SELINUX_DISABLE is not set
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SELINUX_ENABLE_SECMARK_DEFAULT is not set
}}}

I dont know if I have to do any other modifications also.

> Do you have SECURITY_SELINUX_POLICYDB_VERSION_MAX enabled or disabled?
> (should be disabled on FC5 and later).

Its disabled.

>
> --
> Stephen Smalley
> National Security Agency
Thanx for help
-- 
 Pravin Shinde

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
