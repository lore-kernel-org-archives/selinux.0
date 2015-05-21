Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4LFpa1J020835
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 11:51:36 -0400
Message-ID: <555DFF01.2030207@redhat.com>
Date: Thu, 21 May 2015 17:51:29 +0200
From: Miroslav Grepl <mgrepl@redhat.com>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: CIL: migrate_store issues with MLS policy
References: <555DEECA.1010409@redhat.com> <555DFB69.1010802@tresys.com>
In-Reply-To: <555DFB69.1010802@tresys.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/21/2015 05:36 PM, Steve Lawrence wrote:
> On 05/21/2015 10:42 AM, Miroslav Grepl wrote:
>> We try to get working Fedora SELinux policy builds with migrated store.
>> But we get some issues with MLS policy. We needed to add the following
>> fixes to make it working.
>>
>> https://github.com/mgrepl/selinux-policy/commit/daad0252400284027e8a5c300addf6226f74e312
> 
> Looks like a bug with the pp2cil converter. Looking into this.
> 
>> and
>>
>> https://github.com/mgrepl/selinux-policy/commit/113792a78ac27e8a05b4e3b550d7bc40c3c937db
>>
> 
> This works for staff_r, user_r, and sysadm_r because of this hack:
> 
> https://github.com/SELinuxProject/selinux/blob/master/libsepol/src/module_to_cil.c#L2023-L2045

Thanks, I overlooked it.
> 
> The issue here is that secadm and auditadm are always defined in their
> respective modules, but conditionally defined in base if enable_mls is
> true. Because of this, we can't really use the hack mentioned above,
> because auditadm_r and secamd_r aren't always in base, which that hack
> relies on.
> 
> It's possible we could do the reverse of that for these roles, and only
> declare secadm_r and auditadm_r when NOT converting a base module. But I
> this could potentially break things if enable_mls == true and
> auditadm/secadm modules aren't installed, but something still relies on
> the roles. Not immediately clear if that's the case. Will have to look
> into this...
> 
Ok. The point is if we add another SELinux user we will get the same
issue also for targeted policy.
> 
>> Please check my commit messages.
>>
>> Regards,
>> Miroslav
>>
> 


-- 
Miroslav Grepl
Software Engineering, SELinux Solutions
Red Hat, Inc.
