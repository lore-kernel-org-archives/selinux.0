Message-ID: <44577BC5.3050009@gentoo.org>
Date: Tue, 02 May 2006 11:33:25 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Jeremy Katz <katzj@redhat.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        SE Linux <selinux@tycho.nsa.gov>, Paul Nasrat <pnasrat@redhat.com>,
        James Antill <jantill@redhat.com>
Subject: Re: We are attempting once again to split policy out into	individual
 RPMS.
References: <44576B91.8060607@redhat.com>  <44577454.5040204@gentoo.org> <1146583000.32102.8.camel@orodruin.boston.redhat.com>
In-Reply-To: <1146583000.32102.8.camel@orodruin.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jeremy Katz wrote:
> On Tue, 2006-05-02 at 11:01 -0400, Joshua Brindle wrote:
>   
>> Daniel J Walsh wrote:
>>     
>>> I had more meetings with the install and RPM team at Red Hat about 
>>> splitting out policy into individual packages for RHEL5/FC6.  We had 
>>> many discussions about possible ways of doing this including breaking 
>>> out policy into separate packages, ie http_policy.rpm but this was 
>>> discounted as it was seen as a policy explosion.  Also
>>>       
>> How is it a policy explosion? What does that mean exactly?
>>     
>
> Package explosion. For every package in the "universe", there is more
> metadata to be downloaded and more memory to be used.  Having to have a
> separate subpackage for *every* package containing policy is madness.
>
>   
The vast majority of packages do not need policies. I know we've 
mentioned this before and I don't know where you got the impression that 
every package would need a corresponding policy package.
>>> we discussed only doing the semodule as the last in the transaction 
>>> but this ability is being de-emphasized in the installer, so it was 
>>> thought to keep it simple and install the policy within each RPM that 
>>> ships with policy, sort of the ldconfig model.
>>>
>>>       
>> de-emphasized by the installer?  Not sure I follow, rebuilding the 
>> policy every time is expensive and may get worse (policy server 
>> enforcement).
>>     
>
> There's movement underway to split transactions into minimal closed
> sets.  Which means that you're going to end up running semodule about as
> many times as there are policy packages.  If this takes absurd amounts
> of time, then people further get the impression that SELinux is an
> impediment more than a help :(
>
>   
What is the problem with enclosing the policy packages within a single 
transaction?
>>> Secondly the rpm team would like to be able to execute the equivalent 
>>> of matchpathcon(XYZ.pp)  IE be able to extract the FC file mapping 
>>> from the policy package and combine it with the on disk representation 
>>> to determine the file context to associate with the new files being 
>>> put on disk.
>>>
>>>       
>> hrm, this is unreliable unless you are combining file contexts from all 
>> possible modules being installed. Any given RPM transaction can easily 
>> have multiple policy packages and this needs to be addressed.
>>     
>
> The policy for a given package needs to be able to be contained to that
> package.  Otherwise, it's pretty much impossible to sanely handle policy
> in anything other than the huge blob that there is now[1].  Saying
> otherwise is like saying that the uid/gid that owns a file should be
> able to be specified by combining things from multiple packages.
>
>   
The comparison to uid/gid is bogus, uid/gid are unambiguous, file 
contexts are ordered by specificity because multiple regexes can match 
any given filename. The file_contexts *must* be combined and ordered 
prior to labeling, and if multiple policy packages are being installed 
within a set those must all be included as well. matchpathcon does not 
currently have the sorting mechanism that libsemanage does to properly 
combine policy package file contexts.
>>> At the end of the rpm install, postinstall would do an semodule -i 
>>> XYZ.pp.
>>>       
>> The ideal order is to install all the policy packages first (shouldn't 
>> be too hard to move them to the beginning of the ordered list) and after 
>> they are installed do a single transaction to install them all (you have 
>> to do something like this regardless due to mutual dependencies) and 
>> then proceed to regular packages. This seems much cleaner than the sort 
>> of hackery being described here.
>>     
>
> If policy packages require running a tool for the policy to be active,
> then they fundamentally cannot be at the beginning of a transaction as
> the package containing, eg, semodule will need to be installed too.  And
> the dep tree cascades down from there.  Plus, special casing policy
> packages to be different from every other piece of software shipped is
> more hack-ish, not less.
>
>   
How so? Granted that semodule, libsemanage, etc must come before policy 
packages but why can't policy packages be depended on in a way that 
forces them to the front (behind their own dependencies of course). What 
you are saying is that you want to support selinux modules but not 
really. Further, stating that something is more hacky because it falls 
on RPM to implement the special case rather than implementing the 
special case in the kernel, the selinux libraries, policy and enduring 
some amount of inconsistency in the kernel, the filesystem and policy 
seems pretty short sighted.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
