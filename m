Message-ID: <55883793.2040400@tycho.nsa.gov>
Date: Mon, 22 Jun 2015 12:28:03 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Miroslav Grepl <mgrepl@redhat.com>, selinux@tycho.nsa.gov,
 Steve Lawrence <slawrence@tresys.com>,
 "jwcart2 >> James Carter" <jwcart2@tycho.nsa.gov>,
 Joshua Brindle <brindle@quarksecurity.com>
Subject: Re: Strange behavior: type boundaries
References: <20150313181459.GB9437@linksys-wireless-usb.network2>
 <55032BCD.7090103@tycho.nsa.gov>
 <20150313184330.GC9437@linksys-wireless-usb.network2>
 <55033162.8040508@tycho.nsa.gov>
 <20150314072253.GA26393@linksys-wireless-usb.network2>
 <5506CFD9.2030606@tycho.nsa.gov> <558832B8.8020705@redhat.com>
In-Reply-To: <558832B8.8020705@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/22/2015 12:07 PM, Miroslav Grepl wrote:
> On 03/16/2015 01:43 PM, Stephen Smalley wrote:
>> On 03/14/2015 03:22 AM, Dominick Grift wrote:
>>> On Fri, Mar 13, 2015 at 02:50:10PM -0400, Stephen Smalley wrote:
>>>> On 03/13/2015 02:43 PM, Dominick Grift wrote:
>>>>> On Fri, Mar 13, 2015 at 02:26:21PM -0400, Stephen Smalley wrote:
>>>>>> On 03/13/2015 02:15 PM, Dominick Grift wrote:
>>>>>>> I was playing with systemd-nspawn/machine, and machinectl allows one to pull in images. I am trying to confine it and i hit issues:
>>>>>>>
>>>>>>> systemd runs systemd-importd, and systemd-importd runs systemd-pull
>>>>>>>
>>>>>>> It seems as if though its some multithreading going on because i get:
>>>>>>>
>>>>>>> type=SELINUX_ERR msg=audit(1426268982.258:2559): op=security_bounded_transition seresult=denied oldcontext=system_u:system_r:systemd_t newcontext=system_u:system_r:importd_t
>>>>>>>
>>>>>>> Even though I am in permissive mode, and a transition rule "allow systemd_t importd_t:process transition;" is present, SELinux does not transition.
>>>>>>>
>>>>>>> When i add a typebounds statement (typebounds systemd_t importd_t), then the scenario changes:
>>>>>>>
>>>>>>> type=SELINUX_ERR msg=audit(1426268121.044:2414): op=security_compute_av reason=bounds scontext=system_u:system_r:systemd_t tcontext=system_u:system_r:importd_t tclass=process perms=transition
>>>>>>> ----
>>>>>>> type=AVC msg=audit(1426268121.044:2415): avc:  denied  { transition } for  pid=9210 comm="(-importd)" path="/usr/lib/systemd/systemd-importd" dev="dm-1" ino=2232532 scontext=system_u:system_r:systemd_t tcontext=system_u:system_r:importd_t tclass=process permissive=1
>>>>>>> ----
>>>>>>> type=SELINUX_ERR msg=audit(1426268121.044:2416): op=security_compute_av reason=bounds scontext=system_u:system_r:importd_t tcontext=system_u:object_r:importd_exec_t tclass=file perms=entrypoint
>>>>>>> ----
>>>>>>> type=AVC msg=audit(1426268121.044:2417): avc:  denied  { entrypoint } for  pid=9210 comm="(-importd)" path="/usr/lib/systemd/systemd-importd" dev="dm-1" ino=2232532 scontext=system_u:system_r:importd_t tcontext=system_u:object_r:importd_exec_t tclass=file permissive=1
>>>>>>> ----
>>>>>>> type=SELINUX_ERR msg=audit(1426268121.046:2418): op=security_compute_av reason=bounds scontext=system_u:system_r:importd_t tcontext=system_u:system_r:systemd_t tclass=fd perms=use
>>>>>>> ----
>>>>>>> type=AVC msg=audit(1426268121.046:2419): avc:  denied  { use } for  pid=9210 comm="systemd-importd" path="/dev/null" dev="devtmpfs" ino=1028 scontext=system_u:system_r:importd_t tcontext=system_u:system_r:systemd_t tclass=fd permissive=1
>>>>>>>
>>>>>>> These rules are present in the policy (the transition is obviously taking place in permissive mode) and so is the typebounds rule, but access looks still denied.
>>>>>>>
>>>>>>> I do not understand what is going on here.
>>>>>>>
>>>>>>> First of all importd_t is bounded to systemd. So why does it appear to be a problem that systemd operates on importd_t entities?
>>>>>>>
>>>>>>> Also why does selinux refuse to type transition without a typebounds, and why does it give me a permission denied with a typebounds 
>>>>>
>>>>>> NO_NEW_PRIVS?  See http://marc.info/?l=selinux&m=140717412324539&w=2
>>>>>> Previously domain transitions on exec were always disabled under
>>>>>> NO_NEW_PRIVS and nosuid mounts.  This was introduced as a way of
>>>>>> supporting e.g. the SELinux sandbox or other cases where NNP is being
>>>>>> used and they want to transition domains on exec.  Typebounds makes this
>>>>>> safe, but typebounds requires you to cap the child type's permissions to
>>>>>> a subset of the parent type's permissions.  This is normally checked by
>>>>>> checkpolicy or libsemanage at policy build/link time but I'm sure Red
>>>>>> Hat has disabled it along with neverallow checking, so you probably
>>>>>> don't see it until the kernel recognizes the discrepancy and dynamically
>>>>>> blocks the access that would violate the bound.
>>>>>
>>>>> Yes that is what i mentioned on #selinux. However i am not using checkpolicy or libsemanage. I am using secilc (and i have it check for neverallow rule violations). I would have expected it to catch it on compile time.
>>>>>
>>>>> However there is still something strange in that importd_t is bounded to systemd_t: thus why would: "systemd_t importd_t:process transition;" be denied?
>>>>>
>>>>> systemd_t is the parent and not the bounded child.
>>>>>
>>>>> A rule "allow systemd_t importd_t:process transition;" is present in the output of "sesearch -A -s systemd_t -t
>>>> importd_t". Yet it still prints a denial.
>>>>
>>>> Typebounds restricts its use both as a source and as a target context.
>>>> Does systemd_t have transition to self?
>>>
>>> Thanks for the hint. That did it.
>>>
>>> It feels wrong/unnatural though because now i have to give the parent more permissions to be able to run the child with less permissions than its parent.
>>>
>>> But ce'st la vie i suppose. At least i know what the problem was now.
>>
>> I agree that the typebounds logic is somewhat less than optimal presently.
> 
> In Fedora, we have unconfined_service_t domain for unconfined services
> started by init. So there is init_t @bin_t -> unconfined_service_t and
> we get op=security_bounded_transition for init_t against
> unconfined_service_t. But of course it is not going to work with
> 
> typebounds init_t unconfined_service_t;
> 
> because there is
> 
> # <audit-1401> op=security_compute_av reason=bounds
> scontext=system_u:system_r:unconfined_service_t:s0
> tcontext=system_u:object_r:bin_t:s0 tclass=file perms=entrypoint
> 
> So this logic breaks our concept with unconfined_service_t.

But the bounds check is only applied if the caller or one of its
ancestors (systemd?) set NO_NEW_PRIVS or the filesystem is mounted nosuid.

And if the type is not bounded, we simply fall back to the original
context on a default transition, just as we did unconditionally prior to
the kernel change when NO_NEW_PRIVS was set.  The kernel change did not
make type bounds a requirement; it just added it as an optional way of
support type transitions under NO_NEW_PRIVS.  Prior to the kernel
change, there was no way to perform a type transition upon exec if
NO_NEW_PRIVS was set.

What definition of typebounds would permit the above scenario yet still
ensure that no privilege escalation can result?  Would we need special
case handling of :file entrypoint and possibly self: rules (to address
Dominick's earlier issue)?  Or dropping the target bounds checks
entirely as was proposed back in
http://marc.info/?l=selinux&m=125770868309928&w=2 ?
