Message-ID: <48973F71.9020402@redhat.com>
Date: Mon, 04 Aug 2008 13:42:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Paul Howarth <paul@city-fan.org>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Patch to make libselinux shut up when SELinux is disabled.
References: <4880CFD1.1040102@redhat.com>	 <1216402063.17602.322.camel@moss-spartans.epoch.ncsc.mil>	 <4880D585.9000405@redhat.com> <1216403646.17602.339.camel@moss-spartans.epoch.ncsc.mil> <4880E5E1.8050303@redhat.com> <48971AFA.3070708@city-fan.org>
In-Reply-To: <48971AFA.3070708@city-fan.org>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Paul Howarth wrote:
> Daniel J Walsh wrote:
>> Stephen Smalley wrote:
>>> On Fri, 2008-07-18 at 13:40 -0400, Daniel J Walsh wrote:
>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>> Hash: SHA1
>>>>
>>>> Stephen Smalley wrote:
>>>>> On Fri, 2008-07-18 at 13:16 -0400, Daniel J Walsh wrote:
>>>>> SELinux complains about things like restorecon or rpm when conflicts
>>>>> exist in file_context file even when SELinux is disabled.
>>>>>
>>>>> It should just shut up....
>>>>>
>>>>>> I think that's the wrong place to do it:
>>>>>> - the fact that the application called libselinux at all except to
>>>>>> test
>>>>>> is_selinux_enabled() when SELinux is disabled is either a bug in the
>>>>>> application or an indication that the application wants SELinux
>>>>>> behavior
>>>>>> regardless,
>>>>>> - silencing all log messages coming from libselinux is too broad.
>>>>>> And of course, file_contexts conflicts should be caught during policy
>>>>>> build time aside from local customizations; if not, then we need to
>>>>>> change the policy build process to do that even for modular policy
>>>>>> builds.
>>>> Well it could be argued that libraries should never write to the
>>>> terminal...
>>> selinux_set_callback() lets the application control that behavior.
>>>
>>>> Try explaining this to the users we are telling selinux disabled does
>>>> not effect their machines.  They just come away with the opinion that
>>>> SELinux Sucks and is broken.  Besides we are even complaining when they
>>>> are warnings and SELinux is disabled.
>>> Which reflects a bug in the application - why is it calling matchpathcon
>>> if is_selinux_enabled() <= 0?
>>>
>>> As far as the warning goes, the log callback does get a type parameter
>>> so it can distinguish warnings vs. errors.  But we don't want to hide
>>> these kinds of duplications or conflicts - we just want them to be
>>> caught earlier.
>>>
>>>> The problem seems to be a broken genhomedircon, but we don't currently
>>>> prevent users (rpm post install scripts)  from adding conflicting file
>>>> context in file context.local
>>>> plain text document attachment (diff)
>>>>
>>>> The tools just complain about it after the fact.
>>>>
>>>> # semanage fcontext -a -t httpd_sys_content_t /tmp
>>> Ah, that's interesting.  So the setfiles -c execution by libsemanage
>>> only validates the base file contexts.  I'm trying to remember why we
>>> did that.  Seems like that could be changed easily enough.
>>>
>>>> # matchpathcon /etc
>>>> # matchpathcon /etc/
>>>> /etc/selinux/targeted/contexts/files/file_contexts: Multiple different
>>>> specifications for /tmp  (system_u:object_r:httpd_sys_content_t:s0 and
>>>> system_u:object_r:tmp_t:s0).
>>>> /etc/    system_u:object_r:etc_t:s0
>>>>
>>>> Nice.
>>> That's a real bug in the file_contexts file that shouldn't be hidden
>>> from the user.
>>>
>>> I do agree that a) the application shouldn't be calling matchpathcon if
>>> is_selinux_enabled() <= 0, and b) we ought to catch these kinds of
>>> errors at policy build time for the base policy, and c) we ought to
>>> catch these kinds of errors at semodule/semanage invocation time for
>>> local customizations.  That is what we should be fixing.  Not silencing
>>> the messenger.
>>>
>> setfiles works while selinux is disabled.  It could be the kerberos
>> libraries, or udev.  I still think warnings on a disabled system should
>> be quietly ignored or thrown in syslog at most.  Having the machine
>> scream at boot, is a mistake.
>>
>> kerberos libraries can not call selinux_set_callback() since they do not
>> know if the process has set it already.
>>
>> Yes I agree semanage should stop this from happening at compile time.
> 
> This may present a problem for policy developers. For instance, I am
> writing new policy for spamass-milter, which currently shares spamd_t
> with spamassassin. I need spamass-milter to transition into a different
> domain, so I need to specify a new context for /usr/bin/spamass-milter
> in my policy module. This conflicts with the existing context for the
> same file (spamd_exec_t) in the main selinux-policy-targeted package and
> I get warnings like this on most rpm/selinux operations:
> 
> /etc/selinux/targeted/contexts/files/file_contexts: Multiple different
> specifications for /usr/sbin/spamass-milter
> (system_u:object_r:milter_spamass_exec_t:s0 and
> system_u:object_r:spamd_exec_t:s0).
> 
> For whatever reason, the context from my local module "wins" and I get
> the desired result. However, if semanage didn't allow this, I believe
> I'd need to fork the selinux-policy package for the duration of my
> development to prevent the unwanted context specification from being
> used. Or is there some other way around this?
> 
> Paul.
Paul after discussions at the OLS/SELinux mini summit.  Karl MacMillan
had an interesting talk about how we are perhaps going to far with Least
Priv.  And the idea of common security goals came up.  He was talking
about grouping applications with common security constraints into a
greater policy, this would eliminate lots of potential bugs without
decreasing security that greatly.  The best example of this in my
opinion has been our treatment of spam.  We have multiple packages
within Fedora/Debian whose main goals are the prevention of spam email
reaching the user.  Spamassassin, razor, pyzor/spamass-milter probably
more.  Each one of these has a written policy for it and interacts with
the multiple email clients.  These have caused a huge amount of
AVCs/Bugzilla's.  And they all pretty much have the same security
problems.  We want to prevent either a daemon or a user app from reading
untrusted mail and then doing something bad.  So in Rawhide I have
worked to consolodate these policies into two types spamd_t and a
spamc_t policy.   Where the difference is a spam daemon or spam client
application.  Then we can begin collapsing the rules and labeling down
to the directories that all of the similar apps need to use.  Hopefully
this will simplify the policy and eliminate the breakage we currently
have in handling spam.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkiXP3AACgkQrlYvE4MpobOLsACfe0oxR0yX7+eEnBruoUsjjkif
dnkAn1bbZkPT7FT0kUYR6OO7haN8C4Va
=dcuN
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
