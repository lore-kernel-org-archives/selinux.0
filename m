Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0TLZ0rv000738
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 16:35:00 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0TLa1UJ005726
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 21:36:02 GMT
Message-ID: <45BE68BF.3030607@mentalrootkit.com>
Date: Mon, 29 Jan 2007 16:35:59 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Catalin DIMA <dima@univ-paris12.fr>
CC: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Problems installing current version of refpolicy with FC6
References: <45BE44FC.8080303@univ-paris12.fr> <45BE4FC6.4090502@mentalrootkit.com> <45BE6262.5080902@univ-paris12.fr>
In-Reply-To: <45BE6262.5080902@univ-paris12.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Catalin DIMA wrote:
> Karl MacMillan wrote:
> 
>> Just to check - are you certain that you want the full policy? You may 
>> be able to do the teaching you need with policy modules only.
> 
> Do you mean I should compile&load the modular policy ? I certainly would 
> like to do this, as it's supposed to be easily configurable & suitable 
> for experimenting small modules.
> 
>> Did you enable mcs? The standard FC6 policy is targeted-mcs and the 
>> presence of the mcs components in the file system labels may be the 
>> cause of your problems.
> 
> I tried again this build.conf format :
> 
> TYPE = targeted-mcs
> NAME = refpolicy
> DISTRO = redhat
> DIRECT_INITRC=n
> MONOLITHIC=n
> MLS-SENS=16
> MLS_CATS=256
> 
> Done make conf, make install and make load, then configured for 
> refpolicy & asked for relabeling, and the system gets stuck...
> 

Could you elaborate on where it gets stuck. Does the labeling happen? 
You might try relabeling in permissive.

> Btw, forgot to mention the libsepol.sepol_genbools: error while reading 
> /etc/selinx/refpolicy/booleans error...
> 

In permissive or enforcing?

> In permissive refpolicy mode, the only selinux message talks about 
> NetworkManager.
> 

Just to clarify, things work fine in permissive mode and you are only 
getting a single AVC message, correct? Could you check /var/log/messages 
and /var/log/audit/audit.log for avc messages after a permissive boot. 
Also check the selinux messages in dmesg for errors.

>> The unknown boolean messages should be harmless I believe.
>>
>> You can extract the build.conf from the policy source rpm as well, 
>> which is likely a good starting point.
> 
> The problem is the same with the rpm and the bz2...
> 

Not certain what you mean here - the source rpm or the binary rpm? I was 
suggesting that you rebuild refpolicy using the configuration from the 
source rpm - which means extracting the correct build.conf, 
modules.conf, and booleans.conf, seusers, and users_extra files and 
installing the in the source tree. You can read the spec file to see how 
this is done during the build process.

Dan - do you have better directions on how to get a patched and 
configured refpolicy tree out of the source rpm?

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
