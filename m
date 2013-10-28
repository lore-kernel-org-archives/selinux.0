Message-ID: <526EB450.3080707@tycho.nsa.gov>
Date: Mon, 28 Oct 2013 15:00:32 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Laurent Bigonville <bigon@debian.org>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: Re: avc_has_perm() returns -1 even when SELinux is in permissive
 mode
References: <20131027144337.5b89c5a8@fornost.bigon.be> <1382975775.2954.44.camel@flatline.rdu.redhat.com> <526E97CF.1050904@tycho.nsa.gov> <4233501.EyuflYia3d@sifl> <526EABE3.6090506@redhat.com>
In-Reply-To: <526EABE3.6090506@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/28/2013 02:24 PM, Daniel J Walsh wrote:
> On 10/28/2013 02:10 PM, Paul Moore wrote:
>> On Monday, October 28, 2013 12:58:55 PM Stephen Smalley wrote:
>>> On 10/28/2013 11:56 AM, Eric Paris wrote:
>>>> On Mon, 2013-10-28 at 10:46 -0400, Daniel J Walsh wrote:
>>>>> Maybe the solution here is to add logging messages to the function.
>>>>>
>>>>> My opionion is that if something is wrong with SELinux, IE The labels
>>>>> are wrong, the policy is wrong or the app is wrong, we should not
>>>>> block in permissive mode.
>>>>>
>>>>> Having the tool write "foobar_t is not a valid source context" would
>>>>> be better then what we have now, which is a silent denial even in 
>>>>> permissive mode.>
>>>> I understand Stephen's argument.  But agree with dwalsh/bigon that 
>>>> hiding this in the library is a lot better than moving the logic to 
>>>> userspace programs.  So this might not be so super simple to do.  How 
>>>> about the idea of a new interface which always returns 0 in
>>>> permissive? But it does a couple of extra things.  These are just rough
>>>> early thoughts....
>>>>
>>>> 0) new interface just like avc_has_perm() but which always returns 0
>>>> in permissive.
>>>>
>>>> 1) a new SELINX_USER_ERR audit message.  On EINVAL we check if the 
>>>> scontext/tcontext are valid and print the equivalent of a SELINUX_ERR 
>>>> message into the audit log if not.
>>>>
>>>> 2) a new /sys/fs/selinux/context like mechanism, which will both 
>>>> validate the context and will force it into the sid cache.  So 
>>>> subsequent broken calls to avc_has_perm() will not generate a second 
>>>> SELINX_USER_ERR message, since the second call to 'access' will find a 
>>>> valid type and will give a denial for that unlabeled_t type?
>>>>
>>>> maybe /sys/fs/selinux/access should be changed/new interface added to
>>>> do all of this in kernel?  generating a real SELINUX_ERR in kernel and 
>>>> forcing the invalid label into the sid cache?
>>>>
>>>> I really do think that userspace object managers should be allowed to 
>>>> call avc_has_perm() and either get an error that should be handled as
>>>> a hard failure or a 0...   checking permissive in userspace object 
>>>> managers just seems prone to breakage...
>>>
>>> I'm ok with changing avc_has_perm as long as: a) Something gets
>>> logged/audited so you'll see that something went wrong in permissive mode
>>> and not just get silent failures in enforcing mode,
>>>
>>> b) We are careful about what error conditions are remapped to 0 in 
>>> permissive mode.  If we just hit a memory allocation failure, we 
>>> shouldn't hide that from the caller.  It should only affect things 
>>> relating to policy.
> 
>> I'm far from an expert on the SELinux userland libraries, but as far as my
>> two cents are concerned I like the idea of changing avc_has_perm() to
>> incorporate the permissive/enforcing logic.  I think asking applications to
>> worry about things like that is a step in the wrong direction.
> 
>> I also agree with Stephen's comments above: logging is important and the
>> only failures that should be ignored by avc_has_perm() are those relating
>> to access denials from policy, error conditions should propagate to the
>> caller.
> 
> The only functions that can fail are the following:
> 
> 		rc = avc_lookup(ssid, tsid, tclass, requested, aeref);
> 		if (rc) {
> 			rc = security_compute_av_flags_raw(ssid->ctx, tsid->ctx,
> 							   tclass, requested,
> 							   &entry.avd);
> 			if (rc)
> 				goto out;
> 			rc = avc_insert(ssid, tsid, tclass, &entry, aeref);
> 
> 
> Are we stating that we should check for EINVAL and return 0 if permissive, or
> is there some more complicated thing we should look up.
> 
> I forget the original bugzilla that caused us to do this check but it was
> something to do with dbus running witht he wrong context, I believe.

I think the only error case of interest is when
security_compute_av_flags_raw() returns -1 with errno EINVAL.  That can
mean that the source or target security context are no longer valid,
e.g. due to a policy reload since the time the SIDs were allocated, or
that the target security class is invalid, e.g. a userspace security
class unknown to the loaded policy.  (Or it could just represent random
memory corruption in the application, of course).

Returning 0 from avc_has_perm_noaudit() could be a source of subtle bugs
without ensuring that the avd has been initialized sanely.
avc_has_perm() initializes it before calling avc_has_perm_noaudit(), but
maybe that should be moved inside of avc_has_perm_noaudit() if avd is set?

Then the subsequent avc_audit() call by avc_has_perm() should set denied
to 0 (as avd->allowed will be initialized to 0), but audited will be set
to 0 because avd->auditdeny will be initialized to 0 too.  So we'll
audit nothing and get no indication of the error at that point.

We could instead initialize avd in a similar way as the kernel does:
static void avd_init(struct av_decision *avd)
{
        avd->allowed = 0;
        avd->auditallow = 0;
        avd->auditdeny = 0xffffffff;
        avd->seqno = avc_cache.latest_notif;
        avd->flags = 0;
}

And call that on entry to avc_has_perm_noaudit() if avd is non-NULL.
Then we'll get an audit message as well, although the security contexts
may be invalid (but will be shown as their string form) or the class may
be invalid (in which case we'll get a null string).










--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
