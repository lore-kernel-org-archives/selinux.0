Message-ID: <52D00A39.5020100@tycho.nsa.gov>
Date: Fri, 10 Jan 2014 09:56:57 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
Subject: Re: Changing unlabeled_t on files to invalid_label_t.
References: <52CF1A53.9080501@redhat.com>
 <CACLa4pvs_qwHn3sf-y0bMZ5wSPs6C39nFZGsptDqo=kje2E5tg@mail.gmail.com>
 <52D006E2.5030906@tycho.nsa.gov> <2516775.9uuOuGk0G5@sifl>
In-Reply-To: <2516775.9uuOuGk0G5@sifl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SE-Linux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/10/2014 09:49 AM, Paul Moore wrote:
> On Friday, January 10, 2014 09:42:42 AM Stephen Smalley wrote:
>> On 01/09/2014 06:07 PM, Eric Paris wrote:
>>> I believe we need a new initial sid.  SECINITSID_INVALID_LABEL....
>>
>> Difficult (impossible?) to do in a fully backward compatible manner (to
>> include the case of loading new policy on old kernel, whether initially
>> or update/reload on an already running kernel with an older policy).
> 
> Do we really need to worry about being able to load new policy into a old 
> kernel?  In general I thought the backward compatible issue was that newer 
> kernels needed to support older userspace, not the other way around.

Well, you'll at least need code in the kernel to handle the case where
the policy does not define any new initial SIDs that you introduce in
the policy, remapping them to e.g. unlabeled or something.

And you likely want to ensure that people don't accidentally load new
policy into old kernel and break things, whether by tying the new
initial SIDS to a policy capability or policy version.
