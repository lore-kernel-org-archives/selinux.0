Date: Wed, 19 Sep 2007 10:22:29 -0400
Subject: Re: concept of a permissive domain
From: Chad Sellers <csellers@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, <selinux@tycho.nsa.gov>
Message-ID: <C316A8E5.2C67E%csellers@tresys.com>
In-Reply-To: <46F11C6C.4070306@redhat.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 9/19/07 8:56 AM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Chad Sellers wrote:
>> On 9/18/07 4:24 PM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>> 
>>> On Thu, 2007-09-13 at 16:16 -0400, Eric Paris wrote:
>>>> On Thu, 2007-09-13 at 15:38 -0400, Stephen Smalley wrote:
>>>>> On Thu, 2007-09-13 at 15:25 -0400, Daniel J Walsh wrote:
>>>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>>>> Hash: SHA1
>>>>>> 
>>>>>> Stephen Smalley wrote:
>>>>>>> On Thu, 2007-09-13 at 10:46 -0400, Karl MacMillan wrote:
>>>>>>>> On Thu, 2007-09-13 at 10:08 -0400, Stephen Smalley wrote:
>>>>>>>>> On Tue, 2007-09-11 at 17:26 -0400, Karl MacMillan wrote:
>>>>>>>>>> On Tue, 2007-09-11 at 16:31 -0400, Daniel J Walsh wrote:
>>>>>>>>>> [...]
>>>>>>>>>>> One other feature/requirement would be to not override dontaudit
>>>>>>>>>>> rules.
>>>>>>>>>>> So if I have a domain in permissive mode and I have a dontaudit rule
>>>>>>>>>>> on
>>>>>>>>>>> reading /etc/shadow.  The app should still be denied reading
>>>>>>>>>>> /etc/shadow.  (This is not a show stopper, but would allow us to
>>>>>>>>>>> force
>>>>>>>>>>> apps to take the code paths they will take in enforcing mode.)
>>>>>>>>>> This isn't specific to per-domain permissive, right? It would be
>>>>>>>>>> useful
>>>>>>>>>> in general for permissive.
>>>>>>>>> I would be opposed to such a change, as it is a semantic change to
>>>>>>>>> what
>>>>>>>>> dontaudit means.
>>>>>>>>> 
>>>>>>>>> Keep in mind that allow, auditallow, and dontaudit/auditdeny are all
>>>>>>>>> independent of one another today and none of them imply the other,
>>>>>>>>> e.g.
>>>>>>>>> allow a b:file read;
>>>>>>>>> auditallow a b:file *;
>>>>>>>>> dontaudit a b:file *;
>>>>>>>>> is perfectly valid and means:
>>>>>>>>> - Let a read files labeled b,
>>>>>>>>> - Audit all permission grantings from a to files labeled b,
>>>>>>>>> - Don't audit any permission denials from a to files labeled b.
>>>>>>>>> 
>>>>>>>> I agree that changing the dontaudit semantic has problems - however the
>>>>>>>> reason Dan suggested is still valid. Currently, generating policy in
>>>>>>>> permissive mode can lead to bogus or overly permissive policy. It would
>>>>>>>> be nice to have some solution to that problem.
>>>>>>> Can't you handle that in the tool, by giving matching interfaces with
>>>>>>> dontaudit rules precedence over ones with allow rules and asking the
>>>>>>> user?
>>>>>>> 
>>>>>>> I'd actually rather see an improved capability for (more easily)
>>>>>>> generating policy incrementally in enforcing mode.  That would make it
>>>>>>> more suitable for production use and avoid the problem above.
>>>>>>> 
>>>>>> Said large financial institution rols out policy for managing huge money
>>>>>> transactions in permissive mode.   Policy build with a pam for verifying
>>>>>> users.
>>>>> Note that I said it would be better to provide a capability to let
>>>>> people develop policy incrementally while in enforcing mode, not
>>>>> permissive mode.
>>>> A fine goal, but not really feasible ATM.  It also doesn't allow for
>>>> going live and testing in production at the same time.  This is still a
>>>> 'must have perfect coverage before usage' model.  Just because you
>>>> develop you way means we don't have to worry about the permissive-denial
>>>> issue but it doesn't solve the 'you are fired' issue.  Great in theory,
>>>> but when talking about some ginormous app that noone fully understands I
>>>> wouldn't want to be the one who sticks his neck out.
>>>> 
>>>>>> Users selected app_uses_pam in policy design tool.
>>>>>> 
>>>>>> Tool adds
>>>>>> 
>>>>>> dontaudit financeapp_t shadow_t:file r_file_perms;
>>>>>> 
>>>>>> App in permissive mode reads shadow perms.  Dontaudit covers it up.
>>>>> So don't do that.  Don't include new dontaudit rules while generating
>>>>> policy in permissive mode, and let the user decide whether to select the
>>>>> dontaudit branch or the allow branch in the final form of the generated
>>>>> policy.  For that matter, we should really minimize use of dontaudit
>>>>> rules whenever possible - if we can fix the code to _default_ to the
>>>>> less privileged code path and only try the more privileged code path if
>>>>> it truly needs it, then we should do that.
>>>> You rule out the possibility of running in production without enforcing.
>>>> Obviously your customers would never do that, but a customer going from
>>>> no MAC to some non-enforcing MAC to enforcing MAC, would like to
>>>> actually test things along the way.  Its a different customer base.  And
>>>> we don't have to harm one to help the other.
>>>> 
>>>> Fixing the code is always the better way to go than dontaudit,
>>>> thankfully they exist because that isn't always possible.  Good thing we
>>>> were thinking about this issue before.
>>>> 
>>>>>> App runs for three months.  policy writer sees no avc messages for a
>>>>>> long time,  Thinks everything is fine.
>>>>>> 
>>>>>> Turns on enforcing mode, app tries to authenticate on mysql, gets
>>>>>> denials apps blow up, millions lost, people say selinux sucks, policy
>>>>>> writer is fired.
>>>>>> 
>>>>>> If I want the current behavior to see full permissive mode, I can
>>>>>> semodule -DB or build my policy without dontaudit.
>>>>>> 
>>>>>> permissive mode not following code path of dontaudit would causes major
>>>>>> problems.
>>>>> Let me say it again - dontaudit rules don't affect whether or not
>>>>> something is allowed in SELinux today;
>>>> correct
>>>> 
>>>>> they are NOT deny rules.  If you
>>>>> want deny rules, add those (gasp).  Permissive mode is simply following
>>>>> the code path of allowing everything, as requested.
>>>> it's not following ANY code path now.  enforcing=0 is following the path
>>>> you describe.
>>>> 
>>>> Start looking at this as a whole new type of domain, not just some
>>>> extension of enforcing=X (although I do plan to tie them into each other
>>>> at some level in the code since they provide similar features).
>>>> 
>>>> We need denial rules, we just don't have to call them that.  We just
>>>> need to define how dontaudit and auditallow rules work in this new type
>>>> of domain.  Then decide if that somehow interferes if the domain is not
>>>> a permissive domain.  Aside from Karl's little flub, noone is arguing we
>>>> should change anything having to do with enforcing=0 or enforcing=1 and
>>>> a non-permissive-domain.  We don't need to rewrite how dontaudit rules
>>>> affect enforcing domains or non-enforcing-systems, we just need an
>>>> extended definition for permissive domains.  Seems dontaudit and
>>>> auditallow can work very nicely to solve real practical problems
>>>> constraining large applications in environments which may not be friends
>>>> to problems introduced by SELinux.  Everyone agrees running an
>>>> application and just allowing whatever it asks for isn't the best way to
>>>> write policy, but when it's all you have, and all you are going to
>>>> reasonably have I'm not hearing a argument why we can't do what Dan
>>>> wants, other than 'that's not what it means today.'
>>>> 
>>>> dontaudit as an 'implicit denial in permissive domains' isn't what we
>>>> have today, but then again, we don't have permissive domains today.
>>> I think we need to be careful that we aren't making SELinux harder to
>>> understand.  You are introducing a new construct that doesn't correspond
>>> precisely with either "unconfined" domains under enforcing mode or all
>>> domains under permissive mode today, and then you'll have to explain to
>>> users how they each differ and how to use them in a coherent way.  Maybe
>>> it would be useful to talk again about why we can't go with the "make
>>> the domain unconfined in policy and use auditallow" approach.  There is
>>> the log-once aspect of permissive mode, but possibly that could be made
>>> selectable for domains, and there is the difference in the log messages
>>> (granted vs. denied), but the tools can certainly deal with that.
>>> 
>> I have to say I agree - this is getting complicated. I'm having visions of
>> trying to explain all the different "unconfined" scenarios to customer
>> developers and it makes me want to cry. I understand the reason for
>> permissive domains (in fact I think there are more use cases than have been
>> mentioned here), but creating another "the rules don't apply" construct that
>> has different behavior from any of the current constructs adds too much
>> complexity.
>> 
>> One other note - how does a special debug domain that allows everything
>> except things that are dontaudit'd solve the use case that's been thrown
>> around. If I'm the IT guy, and I'm using this permissive domain to try out a
>> policy for 3 months in a permissive environment, I certainly don't want
>> certain items to be denied. Even worse, the current idea would have them
>> denied and not even audit'd. So, instead of causing a problem 3 months from
>> now when I switch to enforcing, it causes problems the day I install policy.
>> Millions are still lost, people still say SELinux sucks, and I (the policy
>> writer) still get fired (with 3 months less pay as well).
>> 
>> Chad
>> 
> I would argue just the opposite.  Lets use the pam case.  Currently pam
> tries to read /etc/shadow and fails over to using unix_chkpwd.
> (Something we are working to change, BTW).  So in the permissive domain
> you suggest, we run for three months with myapp_t able to read
> /etc/shadow, even with the standard dontaudit rule.  Everything works
> fine, no AVC messages. Lets turn off the "permissive" bit.  Suddenly the
> myapp can't read /etc/shadow. It goes down a totally different code path
> and boom blows up.  By running it in this permissive mode, you are never
> testing code paths that happen when myapp gets Perimission Denied.
> 
I understand the problem and agree that it is indeed a problem. I was just
trying to point out that having a domain that is mostly permissive, but
denies things that are dontaudit'd exchanges one problem for another. We're
creating a concept for the IT guy to be able to test out his policy without
breaking the app (permissive), then adding a feature to it that gives the
policy the opportunity to break the app (by denying some things).

> But I think we need to move forward with some kind of
> permissive/unconfined domain.  Whether this is a kernel change or tool
> chain change, I don't care.  I just want it soon.  We talked about it
> back at the Summit and no movement has happened.
> 
Sounds good to me.

> As far as being fully permissive or allowing dontaudit rules to block,
> lets go fully permissive for now.  Meaning, when you turn a domain to
> permissive it works the same way permissive mode works now.
> We can revisit the dontaudit/enforce at a later date.

Sounds good.

> The tools
> (audit2allow/sepolgen) can easily be changed to generate rules for
> looking at granted versus denied.  GRANTED would also stop
> setroubleshoot from screaming constantly.
> 
> We need a way to build a policy module:
> 
> auditallow = unconfined_domain - (allow_rules + dontaudit_rules)
> 
> or set a flag in the kernel that says allow XYZ_T to run in permissive mode.
> 
> The ability to put a domain in permissive mode needs to be put in the
> toolchain, so a user can set it also.
> 
> semodule/semanage --permissive myapp_t
> 
> 
> User Scenarios:
> 
> 1. Policy developer - discussed to death.
> 2. User wants app to work, knows it does stuff that SELinux would block
> but does not want to deal with it, so sets it permissive.
> 3. Diagnosing whether SELinux is causing the problem.  Often we tell
> users when they don't see AVC messages, to put the machine in permissive
> mode to see if SELinux is the culprit.
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.7 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iD8DBQFG8RxsrlYvE4MpobMRAkOQAJ9it8yEBxJOfWzb1oJtahqq6/ns5QCfZYdw
> SDoZwkRhxTg6QgORE0Aerdw=
> =sPj8
> -----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
