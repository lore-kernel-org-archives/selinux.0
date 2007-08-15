MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch 0/4] libsemanage: genhomedircon replacement
Date: Wed, 15 Aug 2007 16:44:23 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588EDEBA8@exchange.columbia.tresys.com>
In-Reply-To: <1187209889.20485.138.camel@moss-spartans.epoch.ncsc.mil>
References: <20070815204411.705994826@tresys.com> <1187190639.2674.51.camel@localhost.localdomain> <46C31BD0.5060200@tresys.com> <1187192832.2674.74.camel@localhost.localdomain> <6FE441CD9F0C0C479F2D88F959B01588EDEB74@exchange.columbia.tresys.com> <1187198560.20485.45.camel@moss-spartans.epoch.ncsc.mil> <1187205378.2838.12.camel@localhost.localdomain> <1187207793.20485.103.camel@moss-spartans.epoch.ncsc.mil> <1187209022.2838.38.camel@localhost.localdomain> <1187209889.20485.138.camel@moss-spartans.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: "Todd Miller" <tmiller@tresys.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2007-08-15 at 16:17 -0400, Karl MacMillan wrote:
>> On Wed, 2007-08-15 at 15:56 -0400, Stephen Smalley wrote:
>>> On Wed, 2007-08-15 at 15:16 -0400, Karl MacMillan wrote:
>>>> On Wed, 2007-08-15 at 13:22 -0400, Stephen Smalley wrote:
>>>>> On Wed, 2007-08-15 at 11:57 -0400, Joshua Brindle wrote:
>>>>>> Karl MacMillan wrote:
>>>> [...]
>>>>>>> Perhaps it would be better to set it explicitly rather than
>>>>>>> based on the user. Either by giving people a way to set MLS
>>>>>>> file contexts separately from the type (which might help
>>>>>>> with MLS customization in general) or just doing a chcon on
>>>>>>> the containing home directory and having that be inherited
>>>>>>> (and not set on relabel for home directories).
>>>>>>> 
>>>>>> 
>>>>>> So... Right now its based on the policy because the home
>>>>>> directory contexts are regenerated when the policy changes,
>>>>>> you are suggesting making it more difficult to use? Right now
>>>>>> you can change someones level with semanage and restorecon -R
>>>>>> their home directory which is fairly easy. Setting the
>>>>>> contexts explicitly seems like much more burden on the local
>>>>>> admin. 
>>>>> 
>>>>> I thought genhomedircon wasn't setting the level at all (just
>>>>> using whatever is in the template, i.e. s0), and then they were
>>>>> using pam_namespace to instantiate per-level subdirs.
>>>>> 
>>>> 
>>>> Which sounds better (and safer - relabeling the level would be
>>>> questionable). However, having a mechanism to set levels separate
>>>> from type (and potentially user) sounds helpful. That way an admin
>>>> could specify, for example, that a log file should be Secret
>>>> without having to specify the type.
>>>> 
>>>>> I'm trying to understand whether the issue here is limited in
>>>>> scope to home directory labels or actually extends to the entire
>>>>> notion of per-role types (tmp files, ttys, derived program
>>>>> domains, etc).  I know that has long been an area of concern,
>>>>> not only for file relabeling but also for e.g. modules (requires
>>>>> templating that would go beyond even simple interfaces).
>>>>> 
>>>> 
>>>> I wonder too. I think that we need a means to create
>>>> limited-privilege login sessions and control movement between
>>>> privileged domains (and related domains through transitions). This
>>>> can be done with much of the current role infrastructure (see
>>>> Dan's work on guest_t and xguest_t). We can keep the process
>>>> domains without instantiating corresponding file types.
>>>> 
>>>> However, the problem with the current per-role templates is that
>>>> they are instantiated for _every_ role, which is clearly wrong for
>>>> certain types of locked-down roles. If I want a git-role that only
>>>> allows a user to login to a bash shell, execute git, and read /
>>>> write certain file types having a git_firefox_t is not desirable.
>>>> 
>>>>> genhomedircon does serve another purpose, btw - setting the
>>>>> SELinux user identity for the user's home directory. So if you
>>>>> want to do separation based on SELinux user via constraints, you
>>>>> still need a mechanism for getting the user home directories to
>>>>> have the right SELinux user identity.
>>>>> 
>>>> 
>>>> I have two suggestions (which may be totally off-base):
>>>> 
>>>> 1) Remove the selinux user concept entirely and merge it with the
>>>> DAC user identities. We would simply preserve the role
>>>> authorizations and allow constraints on the dac users (there are
>>>> some interesting details in there I know). The constraints could
>>>> be limited to user equality / inequality and not refer
> to specific users to simplify things.
>>> 
>>> By remove/merge, do you mean just use the Linux username as the
>>> SELinux user identity, like we used to do before seusers?
>  You can
>>> even do that today just by removing seusers or making it empty.  The
>>> problem with that approach I thought was that it required
>>> regenerating and loading kernel policy each time we add or remove a
>>> Linux user. 
>>> 
>> 
>> No, I mean removing the separate user identity entirely and allowing
>> selinux to directly use the linux user identity where appropriate
>> (e.g., for constraints). This may be an awful idea, it's just that we
>> abandoned
> 
> s/may be/is/
> 
>> SELinux knowledge of individual users because of scalability problems
>> (which seems somewhat unfortunate) and added a somewhat redundant
>> level of indirection. Allowing direct interaction with the linux user
>> identity would solve the scalability while giving selinux a chance to
>> have policy around individual users.
> 
> It isn't quite redundant.  Today the SELinux user is an
> "authorized role set", while the role field indicates the
> active role.  So it still functions as a bound on what roles
> are reachable by the user, and means that newrole isn't
> completely trusted (can't jump to an arbitrary role, but only
> to one in the "authorized role set" identified by the SELinux user).
> 
> If we gave that up, then newrole would be a completely
> trusted program, i.e. it would fully adjudicate what roles
> can be entered by what users.
> 
> The Linux uid is less useful to us, as we certainly don't
> want to encode uids (integers) into the SELinux policy, so
> defining user-role authorizations based on Linux uid in
> kernel policy isn't going to be workable.
> 

We don't have to encode uids into the policy, it can just be part of the
constraint language:

constrain dir_file_class_set { read write execute } 
( uid1 == uid2 );



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
