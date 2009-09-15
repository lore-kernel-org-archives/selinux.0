MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] setfiles fails to relabel if selinux not enabled
Date: Tue, 15 Sep 2009 16:23:24 -0400
Message-ID: <06A6610D4F464D4EBEAFBF2C5F86911E014CEA9F@exchange2.columbia.tresys.com>
In-Reply-To: <1253043181.18198.62.camel@moss-pluto.epoch.ncsc.mil>
References: <1253042418-28141-1-git-send-email-ccase@tresys.com> <1253043181.18198.62.camel@moss-pluto.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, "Caleb Case" <ccase@tresys.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 2009-09-15 Stephen Smalley wrote:
> On Tue, 2009-09-15 at 15:20 -0400, Caleb Case wrote:
>> Setfiles now checks the capabilities on the mounted file systems for
>> 'seclabel' (see setfiles/setfiles.c:723:exclude_non_seclabel_mounts)
on
>> newer kernels (>=2.6.30 see setfiles.c:734). However the 'seclabel'
>> feature is not available if selinux is not enabled. The result is
that
>> setfiles silently fails to relabel any filesystems.
>> 
>> The patch below removes the check for seclabel if selinux is
disabled.
>> 
>> As an alternative maybe seclabel should be available even if selinux
>> is disabled? It seems that whether a fs supports security labels is
>> independent of selinux being enabled.
> 
> That would be difficult as the seclabel option is driven by policy,
> not just by the presence/absence of xattr handlers (the issue is
> whether SELinux will honor setxattr operations, which is not the case
> for filesystems using genfscon or context mount options).
> 
> So I guess this is the best we can do.
> 

What is the best we can do? Should we always attempt to relabel if
selinux is disabled or not?

>> ---
>>  policycoreutils/setfiles/setfiles.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>> diff --git a/policycoreutils/setfiles/setfiles.c
>> b/policycoreutils/setfiles/setfiles.c
>> index 313767a..db2857f 100644
>> --- a/policycoreutils/setfiles/setfiles.c
>> +++ b/policycoreutils/setfiles/setfiles.c
>> @@ -750,6 +750,8 @@ static void exclude_non_seclabel_mounts()
>>  	/* Check to see if the kernel supports seclabel */
>>  	if (uname(&uts) == 0 && strverscmp(uts.release, "2.6.30") < 0)
>>  		return;
>> +	if (is_selinux_enabled() <= 0)
>> +		return;
>> 
>>  	fp = fopen("/proc/mounts", "r");
>>  	if (!fp)






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
