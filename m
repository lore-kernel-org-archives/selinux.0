Message-ID: <5356664E.7050309@tycho.nsa.gov>
Date: Tue, 22 Apr 2014 08:53:34 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Why is SELINUXTYPE policy specific?
References: <5353BC31.3070404@gmail.com>
 <CAPzO=Nzkn13La7VDcFjCah8CGmhW7R6Vm+zoMFR80DhPNgD3wg@mail.gmail.com>
 <5355F720.7010605@gmail.com>
In-Reply-To: <5355F720.7010605@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/22/2014 12:59 AM, dE wrote:
> On 04/21/14 13:31, Sven Vermeulen wrote:
>> On Sun, Apr 20, 2014 at 2:23 PM, dE <de.techno@gmail.com> wrote:
>>> There are 3 security models in which SELinux can work -- TE, RBAC and
>>> MLS.
>>>
>>> And there are 6 types of SELinux policies --
>>>
>>> targeted, mls, mcs, standard, strict or minimum.
>>>
>>> Each security model requires it's own set of policies and the
>>> policies can
>>> be 1 of the 6 types. So can all the 3 security modles and 6 types be
>>> intermixed? Won't there be conflicts like with MLS and RBAC?
>> The SELINUXTYPE value should be seen as the name given to a policy
>> store. The contents (the actual policy, the features it supports, the
>> fact that it is MLS-enabled or not) have nothing to do with the name
>> of the store per se. It is just a matter of convenience that policy
>> stores are named in a particular way so that, cross-distributions,
>> security administrators can deduce the type and features of the policy
>> based on the name.
>>
>> For instance, on RHEL6, "targeted" is the name given to the policy
>> store that contains an MCS policy with support for unconfined domains.
>> On Gentoo, this name is rather used for non-MCS policy with support
>> for unconfined domains.
>>
>> Afaik, there is no conflict between RBAC and MLS. With MLS, the
>> SELinux subsystem allows or denies access based on the dominance rules
>> between the domains' security clearance and the resource sensitivity
>> level. RBAC instead allows or denies a SELinux role to be associated
>> with a particular domain.
>>
>> Wkr,
>>    Sven Vermeulen
> 
> So can policies which support RBAC can be made to have a different
> SELINUXTYPE?

You can use any SELINUXTYPE value you want; it is just an arbitrary name
for the policy.  No inherent relationship to the underlying model or
configuration.

> Can targeted, mls, mcs, standard, strict or minimum also be considered
> as different security models? Since all these are made based on the TE
> model, can we make a custom security model based on TE and give it a
> different SELINUXTYPE.

No, they are not different security models, just different
configurations of the same model, and you are mixing the notions of
SELINUXTYPE, TYPE and NAME.  At most, you might say that mcs and mls are
different "models" since they use different sets of constraint
definitions but that's all just configuration data for SELinux...
