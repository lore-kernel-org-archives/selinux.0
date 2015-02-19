Message-ID: <54E64694.3060807@tycho.nsa.gov>
Date: Thu, 19 Feb 2015 15:24:52 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Tracy Reed <treed@ultraviolet.org>
Subject: Re: MCS error
References: <20150219014803.GB12937@tracyreed.org>
 <54E60CF9.2090006@tycho.nsa.gov> <20150219195844.GD12937@tracyreed.org>
In-Reply-To: <20150219195844.GD12937@tracyreed.org>
Content-Type: text/plain; charset=windows-1252
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/19/2015 02:58 PM, Tracy Reed wrote:
> On Thu, Feb 19, 2015 at 08:19:05AM PST, Stephen Smalley spake thusly:
>> As Dominick pointed out, Fedora and RHEL migrated away from trying to
>> using MCS on users to using it for specific use cases, e.g. sandbox,
>> sVirt (KVM+SELinux), openshift, etc.  So the MCS constraints may not be
>> applied to anything in that policy except for the domains used for those
>> specific applications.
> 
> We intend to use it to sandbox web apps. This sounds like what RHEL is trying
> to use it for, right? 
> 
> Will it simply not work at all for users in RHEL6 as it used to for RHEL5? That
> seemed a very simple way to set it up and would work perfectly for our needs.
> If it won't work for users do we now have to assign a specific type/domain to
> our app? The app always runs under a specific user so we could actually
> associate that user with a domain instead of unconfined, correct?

Yes, in theory that should work.  You just need to make sure that all of
the domains you want to confine via MCS have the appropriate mcs type
attribute(s) associated with them.

> So the first problem I see is that the login names p16004-16009 are assigned to
> unconfined_u so they will never be denied anything except DAC and MCS will not
> be enforced, correct?

Correct.  IIRC, under the original MCS model, even unconfined_t was
subject to its constraints but once they switched over to using it for
sandbox, libvirt, and friends, they limited its application to specific
domains and therefore unconfined_t was no longer affected by it.

> Is the user p16001 setup correctly in that it has its own assigned SELinux user
> and one specific category assigned to it?

It helps but you still have to make sure that the process runs in a
domain that is MCS-constrained.  Which could either be based on a domain
transition for the web app, or based on the user's default role/domain
(semanage user -l).

> Then we need to fix the MLS/MCS ranges for the other users. Currently
> unconfined_u has s0-s0:c0.c1023 plus a seemingly redundant ,c4,c5 etc. Just as
> a test I am trying to use:
> 
> chcat -l -- -c4 p16005
> 
> to remove the c4 category from p16005 but that didn't work for some reason. We
> need to remove all of the categories except one which should be unique to each
> user since each instance of our web app runs under each user p16001 or p16002
> etc. respectively.

I'd just use semanage login -m to modify the mappings.  Or
system-config-selinux if you like GUIs.

> Currently I have the above setup and can login as p16001 and see files like this:
> 
> -bash-4.1$ id
> uid=16001(p16001) gid=16001(p16001) groups=16001(p16001) context=p16001_u:user_r:user_t:p16001
> -bash-4.1$ 
> -bash-4.1$ ls -laZ
> drwxr-xr-x. root   root   system_u:object_r:default_t:SystemLow .
> drwxrwxr-x. root   root   system_u:object_r:default_t:SystemLow ..
> drwxr-xr-x. p16001 p16001 unconfined_u:object_r:default_t:p16001 p16001
> drwxr-xr-x. p16002 p16002 unconfined_u:object_r:default_t:p16002 p16002
> drwxr-xr-x. p16003 p16003 unconfined_u:object_r:default_t:p16003 p16003
> -bash-4.1$ id
> uid=16001(p16001) gid=16001(p16001) groups=16001(p16001) context=p16001_u:user_r:user_t:p16001
> -bash-4.1$ cd p16002/
> -bash-4.1$ ls -laZ
> drwxr-xr-x. p16002 p16002 unconfined_u:object_r:default_t:p16002 .
> drwxr-xr-x. root   root   system_u:object_r:default_t:SystemLow ..
> -rw-r--r--. p16002 p16002 unconfined_u:object_r:default_t:p16002 testfile
> -bash-4.1$ cat testfile 
> I am 16002
> 
> Why can I cat that file? User p16001 has category p16001 and the file I cat'd
> id category p16002. Seems like enforcement is not working here. Is this what
> Dominick was referring to in that I need to do something else to "opt-in" to
> the enforcement?

Because your domain (user_t) doesn't have the attribute that would opt
it into MCS confinement.

> What are the best resources for learning how to use MCS in RHEL6?

I don't know.  Aside from indirectly leveraging it as part of sandbox or
libvirt, I've never used it (aside from early experimentation when it
was first introduced).

>> The -mls policy might be a better fit if you want to apply it system-wide.
> 
> Isn't MLS even less used/supported than MCS? From my description of our use
> would you say that MCS is the right fit as opposed to MLS? It seems like the
> standard targeted policy for most stuff on the box plus MCS to confine/sandbox
> our apps would be the way to go.

Perhaps, if you can get it to work.  The potential advantage of MLS is
that it is applied to all processes by default (domains can be exempted
through type attributes, but few should be) and the MLS constraints have
been tested and evaluated by independent parties.
