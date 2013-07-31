Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r6VLM0VC022449
	for <selinux@tycho.nsa.gov>; Wed, 31 Jul 2013 17:22:00 -0400
Message-ID: <51F97FF2.4040205@schaufler-ca.com>
Date: Wed, 31 Jul 2013 14:21:54 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
CC: LKLM <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v14 3/6] LSM: Explicit individual LSM associations
References: <51F16CFB.6040603@schaufler-ca.com> <5154459.vWAL79RUx2@sifl> <51F939BF.3010404@schaufler-ca.com> <2122972.gxaeSjOpon@sifl>
In-Reply-To: <2122972.gxaeSjOpon@sifl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 7/31/2013 12:39 PM, Paul Moore wrote:
> On Wednesday, July 31, 2013 09:22:23 AM Casey Schaufler wrote:
>> On 7/30/2013 3:08 PM, Paul Moore wrote:
>>> On Thursday, July 25, 2013 11:32:11 AM Casey Schaufler wrote:
>>>> Subject: [PATCH v14 3/6] LSM: Explicit individual LSM associations
>>>>
>>>> Expand the /proc/.../attr interface set to help include
>>>> LSM specific entries as well as the traditional shared
>>>> "current", "prev" and "exec" entries. Each LSM that uses
>>>> one of the traditional interfaces gets it's own interface
>>>> prefixed with the LSM name for the ones it cares about.
>>>> Thus, we have "smack.current", "selinux.current" and
>>>> "apparmor.current" in addition to "current".
>>>>
>>>> Add two new interfaces under /sys/kernel/security.
>>>> The lsm interface displays the comma seperated list of
>>>> active LSMs. The present interface displays the name
>>>> of the LSM providing the traditional /proc/.../attr
>>>> interfaces. User space code should no longer have to
>>>> grub around in odd places to determine what LSM is
>>>> being used and thus what data is available to it.
>>>>
>>>> Introduce feature specific security operation vectors
>>>> for NetLabel, XFRM, secmark and presentation in the
>>>> traditional /proc/.../attr interfaces. This allows
>>>> proper handling of secids.
>>> Maybe I missed something, can you elaborate on this, perhaps even provide
>>> an example for us simple minded folk?
>> There are a set of facilities that (currently, at least)
>> can't be shared by multiple LSMs ...
> I should have been more specific.
>
> Thanks for the explanation, but that I understand the problems of stacking 
> LSM/secids, we've had that conversation a few times now.  The explanation I 
> was hoping for had to do with this sentence:
>
>  "Introduce feature specific security operation vectors for
>   NetLabel, XFRM, secmark and presentation in the traditional
>   /proc/.../attr interfaces."
>
> Can you explain this a bit more?  When I looked at the patch - and maybe I'm 
> missing something - I didn't see anything in /proc that dealt with NetLabel, 
> XFRM, and/or Secmark.

Just so. I have failed to communicate clearly.

  "Each feature that requires support by a single, selected LSM
   is identified by a global pointer to that LSM's security_operations
   structure."

NetLabel, XFRM and secmark are networking interfaces that can
send the security information from a single LSM along with the
packets of data.

/proc/.../attr/current and SO_PEERSEC are interfaces that could
send information from multiple LSMs, but in most cases you have
to choose one LSM to placate your user space tools.

In all of these cases it is necessary to identify the LSM to use.
Even though the end use is quite different the mechanism to support
the identification is the same.

>
>>>> Add NetLabel interfaces that allow an LSM to request
>>>> ownership of the NetLabel subsystem and to determine
>>>> whether or not it has that ownership. These interfaces
>>>> are intended to allow a future in which NetLabel can
>>>> support multiple LSMs at the same time, although they
>>>> do not do so now.
>>>>
>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> ...
>>>
>>>> --- a/include/net/netlabel.h
>>>> +++ b/include/net/netlabel.h
>>>> @@ -407,7 +407,9 @@ int netlbl_secattr_catmap_setrng(struct
>>>> netlbl_lsm_secattr_catmap *catmap, /*
>>>>
>>>>   * LSM protocol operations (NetLabel LSM/kernel API)
>>>>   */
>>>>
>>>> -int netlbl_enabled(void);
>>>> +int netlbl_enabled(struct security_operations *lsm);
>>>> +int netlbl_lsm_owner(struct security_operations *lsm);
>>>> +int netlbl_lsm_register(struct security_operations *lsm);
>>>>
>>>>  int netlbl_sock_setattr(struct sock *sk,
>>>>  
>>>>  			u16 family,
>>>>  			const struct netlbl_lsm_secattr *secattr);
>>>>
>>>> @@ -521,7 +523,11 @@ static inline int netlbl_secattr_catmap_setrng(
>>>>
>>>>  {
>>>>  
>>>>  	return 0;
>>>>  
>>>>  }
>>>>
>>>> -static inline int netlbl_enabled(void)
>>>> +static inline int netlbl_lsm_register(struct security_operations *lsm)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>> +static inline int netlbl_enabled(struct security_operations *lsm)
>>>>
>>>>  {
>>>>  
>>>>  	return 0;
>>>>  
>>>>  }
>>> Is it worth including a static inline for netlabel_lsm_owner() for the
>>> sake of completeness?  I haven't looked closely enough yet to know if it
>>> is strictly necessary or not.
>> I don't think it ever comes up, which would imply we don't need
>> netlbl_enabled(), either.
> Probably not, but I like the safety of having it defined.  I guess that is why 
> I would prefer having netlabel_lsm_owner() defined here as well.

Not a problem. I'll add it.

>>>> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
>>>> index 00a2b2b..5ca352b 100644
>>>> --- a/net/ipv4/cipso_ipv4.c
>>>> +++ b/net/ipv4/cipso_ipv4.c
>>>> @@ -1594,7 +1594,7 @@ static int cipso_v4_parsetag_loc(const struct
>>>> cipso_v4_doi *doi_def, u32 secid;
>>>>
>>>>  	secid = *(u32 *)&tag[2];
>>>>
>>>> -	lsm_init_secid(&secattr->attr.secid, secid, 0);
>>>> +	lsm_init_secid(&secattr->attr.secid, secid, lsm_netlbl_order());
>>>>
>>>>  	secattr->flags |= NETLBL_SECATTR_SECID;
>>> I still need to wrap my head around all the changes, but I *think* this
>>> change may not be necessary since NetLabel isn't multi-LSM aware at the
>>> moment.  If this change is necessary, then there are likely other changes
>>> that need to be made as well, the NetLabel LSM cache would be my main
>>> concern.
>> Using the NetLabel secid slot is necessary because when we get into
>> the auditing code the secid needs to be in the right place to associate
>> it with the right LSM.
> Fair enough.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
