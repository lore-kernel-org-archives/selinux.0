Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GLgL6C002345
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 17:42:21 -0400
Message-ID: <55A8253E.3000407@schaufler-ca.com>
Date: Thu, 16 Jul 2015 14:42:22 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
References: <1436989569-69582-1-git-send-email-seth.forshee@canonical.com>
 <87615k7pyu.fsf@x220.int.ebiederm.org> <20150716135947.GC77715@ubuntu-hedt>
 <55A7C920.7090206@schaufler-ca.com> <20150716185750.GB51751@ubuntu-hedt>
In-Reply-To: <20150716185750.GB51751@ubuntu-hedt>
Content-Type: text/plain; charset=windows-1252
Cc: Serge Hallyn <serge.hallyn@canonical.com>, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 7/16/2015 11:57 AM, Seth Forshee wrote:
> On Thu, Jul 16, 2015 at 08:09:20AM -0700, Casey Schaufler wrote:
>> On 7/16/2015 6:59 AM, Seth Forshee wrote:
>>> On Wed, Jul 15, 2015 at 10:15:21PM -0500, Eric W. Biederman wrote:
>>>> Seth I think for the LSMs we should start with:
>>>>
>>>> diff --git a/security/security.c b/security/security.c
>>>> index 062f3c997fdc..5b6ece92a8e5 100644
>>>> --- a/security/security.c
>>>> +++ b/security/security.c
>>>> @@ -310,6 +310,8 @@ int security_sb_statfs(struct dentry *dentry)
>>>>  int security_sb_mount(const char *dev_name, struct path *path,
>>>>                         const char *type, unsigned long flags, void *data)
>>>>  {
>>>> +       if (current_user_ns() != &init_user_ns)
>>>> +               return -EPERM;
>>>>         return call_int_hook(sb_mount, 0, dev_name, path, type, flags, data);
>>>>  }
>>> This just makes it impossible to mount from a user namespace. Every
>>> mount from current_user_ns() != &init_user_ns will fail.
>>>
>>>> Then we should push this down into all of the lsms.
>>>> Then when we should remove or relax or change the check as appropriate
>>>> in each lsm.
>>>>
>>>> The point is this is good enough to see that it is trivially safe,
>>>> and this allows us to focus on the core issues, and stop worrying about
>>>> the lsms for a bit.
>> Given the extent to which LSMs are deployed I find it a bit
>> worrisome that they might not be considered a "core issue".
>>
>>>> Then we can focus on each lsm one at at time and take the time to really
>>>> understand them and talk with their maintainers etc to make certain
>>>> we get things correct.
>> The "Do the easy stuff, fix the hard stuff after we've sold the product"
>> approach works really well until you get to the point of fixing the hard
>> stuff. This is the origin of the 90/90 rule of software development.
>>
>>>> This should remove the need for your patches 5, 6 and 7. For the
>>>> immediate future.
>>> I'm still not entirely sure what you were trying to do, maybe refuse to
>>> mount whenever a security module is loaded? I think this could be a good
>>> option to start, but couldn't we restrict it to only the LSMs which use
>>> xattrs for security labels? In situations where the filesystem cannot
>>> supply security policy metadata I can't think of any reason to disallow
>>> the mounts.
>> This whole notion of mounting a generic filesystem (e.g. ext4) that
>> is "owned" by a user (as opposed to the system) has lots of implications,
>> and I seriously doubt that many of them have been accounted for.
>>
>> Think back to the "negative group access" issue. You can't just
>> ignore issues that are inconvenient, or claim that you have a reasonable
>> system just because *you* can't think of a problem.
> I've spent a lot of time considering the implications and previous
> vulnerabilities, and I've addressed everything I turned up. Now I'm
> asking for review from those with more experience with and expertise of
> the code in question. I'm not sure what more I should be doing.

Part of the problem I see is that you're looking at the details
when there's an architectural issue. That's OK, it happens all
the time, but we have to pull the issue up slightly higher in
order to address the underlying difficulties.

You want to provide a mechanism whereby an unprivileged user (Seth)
can mount a filesystem for his own use. You want full filesystem
semantics, but you're willing to accept restrictions on certain
filesystem features to avoid opening security holes. You are not
willing to accept restrictions that make the filesystem unusable,
such as making it read-only.

I am going to present a suggestion. Feel free to correct my
assumptions and my reasoning. For simplicity let's use loop-back
mounting of a filesystem contained in a file as an example. The
principles should apply to newly created memory based filesystems
or disk partitions "owned" by Seth.

Seth wants to mount a file (~seth/myfs) which contains an ext4
filesystem. There is already a filesystem object, with security
attributes, that the system knows how to deal with. If Seth mounts
this as a filesystem he, and potentially other people, will be
able to access the content of this object without accessing the
object itself.

	seth$ mount --justforme -t ext4 ~seth/myfs /tmp/seth
	seth$ chmod 777 /tmp/seth
	seth$ ls -la /tmp/seth
	drwxrwxrwx.  3  seth     seth   260 Jul 16 12:59 .
	drwxrwxrwxt 18  root     root  4069 Jul 16 11:13 ..
	seth$

Everything's fine at this point. Wilma is also using the system,
being the sort who likes to hide things in out of the way places

	wilma$ cp ~/scandals /tmp/seth
	wilma$ chmod 600 /tmp/seth/scandals

puts her list of scandals on the unsuspecting filesystem, and changes
the mode to ensure that no one can find out what went on after the
office party.

Seth unmounts /tmp/seth. He looks in ~seth/myfs, finds out what really
happened at the office party, and the story goes from there.

Wilma did everything correctly according to the system security policy,
but the system security policy did not protect her as advertised. The
system was tricked into behaving as if it was in control of the content
of the filesystem when in fact it was not.

One way to fix this problem is for unprivileged mounts to recognize the
attributes of the object mounted and to propagate those attributes to all
the objects they present. All files on /tmp/seth would be owned by seth
and protected by the mode bits, ACL and LSM requirements of ~/seth/myfs.
opening a file on /tmp/seth would require the same permissions as opening
the file containing the mounted filesystem. These attributes would have to
be immutable, or at least demonstrably more restrictive (chmod might be
allowed in some cases, but chown would never be) when changed. I don't see
how a user other than seth could create a new file, as you'd either have
a magical change in ownership or a false sense of security.

I don't see that the presence of user namespaces changes anything. You
may reduce the set of uids available, but the problems with putting a
uid into someone else's file is just as real.

> I welcome feedback about anything I've missed, but stating generally
> that you think I probably missed something isn't very helpful.

True enough. I hope I've explained myself above.

> The LSM issue is thornier than the rest of it though, which is why I
> specifically asked for review there in the cover letter. There's a lot
> of complexity and nuance, and I still don't have a grasp on all the
> subtleties. One such subtlety is the full impact of simply ignoring the
> security labels on disk (but I am still confused as to why this is
> different from filesystems which don't support xattrs at all).

If you can mount a filesystem such that the labels are ignored you
are effectively specifying that the Smack label on the files be 
determined by the defaulting rules. With CAP_MAC_ADMIN that's fine.
Without it, it's not.

> I was unaware of Lukasz's patches until yesterday, and I will have a
> look at them. But since we don't have the LSM support for user
> namespaces yet, I don't see the problem with doing something safe for
> LSMs initially and evolving the LSM integration for user ns mounts along
> with the rest of the user ns integration.

Ignoring the security attributes is not safe!

> Your point is taken about my less-than-expert opinion about the other
> security modules. We should at minimum get acks from the maintainers of
> those modules that unprivileged mounts will not compromise MAC.

I am the Smack maintainer. Unprivileged mounts as you have
described them compromise MAC. They compromise DAC, too.


> For Smack specifically, I believe my only concern was the SMACK64EXEC
> attribute, as all the other attributes only affected subjects' access to
> the files. So maybe it would be possible to simply ignore this attribute
> in unprivileged mounts and respect the others, even lacking more
> complete LSM support for user namespaces.

SMACK64EXEC is analogous to the setuid bit, but I would rather see
exec() of programs with this attribute refused that for it to be
blindly ignored.

> Seth
>
