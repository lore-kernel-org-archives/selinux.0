Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4MFfLxB010843
 for <selinux@tycho.nsa.gov>; Fri, 22 May 2015 11:41:21 -0400
Message-ID: <555F4E0E.5090109@tresys.com>
Date: Fri, 22 May 2015 11:41:02 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Miroslav Grepl <mgrepl@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: CIL: migrate_store issues with MLS policy
References: <555DEECA.1010409@redhat.com> <555DFB69.1010802@tresys.com>
 <555DFF01.2030207@redhat.com>
In-Reply-To: <555DFF01.2030207@redhat.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/21/2015 11:51 AM, Miroslav Grepl wrote:
> On 05/21/2015 05:36 PM, Steve Lawrence wrote:
>> On 05/21/2015 10:42 AM, Miroslav Grepl wrote:
>>> We try to get working Fedora SELinux policy builds with migrated store.
>>> But we get some issues with MLS policy. We needed to add the following
>>> fixes to make it working.
>>>
>>> https://github.com/mgrepl/selinux-policy/commit/daad0252400284027e8a5c300addf6226f74e312
>>
>> Looks like a bug with the pp2cil converter. Looking into this.
>>

Found this problem, pretty small fix. There is a check we perform for
roles that we are missing for role attributes. So we were incorrectly
associating roleattributes with types that aren't in scope and could be
disabled by an optional.

>>> and
>>>
>>> https://github.com/mgrepl/selinux-policy/commit/113792a78ac27e8a05b4e3b550d7bc40c3c937db
>>>
>>
>> This works for staff_r, user_r, and sysadm_r because of this hack:
>>
>> https://github.com/SELinuxProject/selinux/blob/master/libsepol/src/module_to_cil.c#L2023-L2045
> 
> Thanks, I overlooked it.
>>
>> The issue here is that secadm and auditadm are always defined in their
>> respective modules, but conditionally defined in base if enable_mls is
>> true. Because of this, we can't really use the hack mentioned above,
>> because auditadm_r and secamd_r aren't always in base, which that hack
>> relies on.
>>
>> It's possible we could do the reverse of that for these roles, and only
>> declare secadm_r and auditadm_r when NOT converting a base module. But I
>> this could potentially break things if enable_mls == true and
>> auditadm/secadm modules aren't installed, but something still relies on
>> the roles. Not immediately clear if that's the case. Will have to look
>> into this...
>>
> Ok. The point is if we add another SELinux user we will get the same
> issue also for targeted policy.

The issue is that these two roles (secadm_r and auditadm_r) could be
optionally defined and used in the base module (dependent on
enable_mls). So they could potentially be defined in two places, which
CIL doesn't allow. As I see it there are a few options to how we could
change CIL generation to fix this problem:

1) Generate the auditadm/secadm roles for the base module, only when
they are defined in base. Ignore declarations in modules.

The problem with this is that if enable_mls is false (e.g. targeted
policy), then installing the auditadm.pp module will fail, because the
auditamd_r role isn't defined anywhere. So this won't work very well.

2) Generate the auditadm/secadm roles for non-base modules, only when
defined in a non-base module. Ignore declarations in base.

This solves the above problem. However, if enable_mls is true, there
would then be rules using auditadm_r in the base module. So removing the
auditadm.pp module would fail because nothing defines the role. This
doesn't really work either.

3) Generate the auditadm/secadm roles in base, always. Ignore
declarations in base and non-base modules.

This solves the above problems. It allows one to install or remove the
auditadm module and things will still work as expected. The difference
is that it would be impossible to remove the roles, meaning the roles
and roleallow rules in base will still exist for these roles. However,
this isn't a big deal, because the roles will not be associated with any
types, so they wouldn't be able to do anything. So I think this is the
best option and will solve the problem with out any real functional changes.


As to your comment, this issue will only occur if you have roles
conditionally defined in base and also defined in a module (right now,
that is just auditadm_r and secadm_r). As long as you don't do that, you
can add new roles without a problem.


I will submit patches for this change and the above shortly.

- Steve
