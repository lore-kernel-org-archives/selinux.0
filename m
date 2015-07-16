Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GF9KWg005893
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 11:09:21 -0400
Message-ID: <55A7C920.7090206@schaufler-ca.com>
Date: Thu, 16 Jul 2015 08:09:20 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Seth Forshee <seth.forshee@canonical.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <87615k7pyu.fsf@x220.int.ebiederm.org> <20150716135947.GC77715@ubuntu-hedt>
In-Reply-To: <20150716135947.GC77715@ubuntu-hedt>
Content-Type: text/plain; charset=windows-1252
Cc: Serge Hallyn <serge.hallyn@canonical.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-security-module@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, selinux@tycho.nsa.gov,
 linux-fsdevel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 7/16/2015 6:59 AM, Seth Forshee wrote:
> On Wed, Jul 15, 2015 at 10:15:21PM -0500, Eric W. Biederman wrote:
>> Seth I think for the LSMs we should start with:
>>
>> diff --git a/security/security.c b/security/security.c
>> index 062f3c997fdc..5b6ece92a8e5 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -310,6 +310,8 @@ int security_sb_statfs(struct dentry *dentry)
>>  int security_sb_mount(const char *dev_name, struct path *path,
>>                         const char *type, unsigned long flags, void *data)
>>  {
>> +       if (current_user_ns() != &init_user_ns)
>> +               return -EPERM;
>>         return call_int_hook(sb_mount, 0, dev_name, path, type, flags, data);
>>  }
> This just makes it impossible to mount from a user namespace. Every
> mount from current_user_ns() != &init_user_ns will fail.
>
>> Then we should push this down into all of the lsms.
>> Then when we should remove or relax or change the check as appropriate
>> in each lsm.
>>
>> The point is this is good enough to see that it is trivially safe,
>> and this allows us to focus on the core issues, and stop worrying about
>> the lsms for a bit.

Given the extent to which LSMs are deployed I find it a bit
worrisome that they might not be considered a "core issue".

>> Then we can focus on each lsm one at at time and take the time to really
>> understand them and talk with their maintainers etc to make certain
>> we get things correct.

The "Do the easy stuff, fix the hard stuff after we've sold the product"
approach works really well until you get to the point of fixing the hard
stuff. This is the origin of the 90/90 rule of software development.

>>
>> This should remove the need for your patches 5, 6 and 7. For the
>> immediate future.
> I'm still not entirely sure what you were trying to do, maybe refuse to
> mount whenever a security module is loaded? I think this could be a good
> option to start, but couldn't we restrict it to only the LSMs which use
> xattrs for security labels? In situations where the filesystem cannot
> supply security policy metadata I can't think of any reason to disallow
> the mounts.

This whole notion of mounting a generic filesystem (e.g. ext4) that
is "owned" by a user (as opposed to the system) has lots of implications,
and I seriously doubt that many of them have been accounted for.

Think back to the "negative group access" issue. You can't just
ignore issues that are inconvenient, or claim that you have a reasonable
system just because *you* can't think of a problem.

> Seth
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
