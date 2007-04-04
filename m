Subject: Re: Identification of Attribute values within the Security Server
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <648688.56539.qm@web86911.mail.ukl.yahoo.com>
References: <648688.56539.qm@web86911.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 10:51:57 -0400
Message-Id: <1175698317.30692.29.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-04 at 14:04 +0000, JanuGerman wrote:
> Hi,
> 
> 
> 
> >Correct; attributes are expanded to their type sets when the policy is
> >generated (at expand time for modular policy).  Originally this was
> >always done and attributes were completely discarded from the policy at
> >that time; later support was added for preserving allow rules based on
> >attributes as a more compact representation, which is why there is now a
> >type_attr_map in the policydb, but this is only used for avtab lookups
> >by compute_av, not by the constraint evaluator.
> 
> Thanks,
> 
> Regarding the "security_compute_av", this function is only called if
> there is a cache miss i.e. (within the avc_perm_noaudit)

Correct.

>            if (!node) {
>                rcu_read_unlock();
>                      rc = security_compute_av(ssid,tsid,tclass,requested,&entry.avd);
>                      if (rc)
>                              goto out;
>                      rcu_read_lock();
>                      node = avc_insert(ssid,tsid,tclass,&entry);
>          }
> 
> am i right?, but i had one question regarding the "struct av_decision
> *avd" that why avd->allowed is > 1 and avd -> seqno = 1 or 2 or 3
> or .., Does avd->allowed mean that the access is allowed, but then
> what does avd->seqno mean? Is it a sequence number of type of thing.
> 
> the type of avd->allowed is u32, and it continues to grow, does this
> mean that how many access allowed decisions, the security server have
> already taken?. And further, does the negative values for all other
> variables mean simply, not active.

avd->allowed is an "access vector", as described by our papers and
reports (please read the available documentation before asking
questions).  It is a bitmap of permissions that are allowed for the
(ssid, tsid, tclass) triple.  The security server can at its discretion
compute more than just the "requested" permissions and provide further
decisions, as indicated by the avd->decided vector (which is also a
bitmap).  Not sure what you mean by negative values - they are unsigned
integers representing bitmaps.

avd->seqno is a sequence number incremented by policy changes, also
described by our papers and reports.  It is used by the AVC to detect an
interleaving of an access vector computation and a policy change
notification, so that it can discard a stale result.

> Usually, the avd is a pointer variable, in almost all the function
> calls, whose value is populated in appropriate methods. But final
> deciding point was not clear to me, that where SELinux hands, its
> decision to Linux DAC about its security policy. Does
> fs/namei.c/permission(), where SELinux is handing over its decision,
> or there are other points as well.

The core kernel invokes the LSM security hooks at appropriate points
where access to an object needs to be mediated, and, if SELinux is
enabled, then the corresponding SELinux hook function is invoked.  This
happens in many different locations throughout the core kernel; look for
security_ calls, and read include/linux/security.h to see the
definitions of the security hooks.

The SELinux hook functions are then responsible for calling the AVC to
get a simple allowed (0) or denied (-EACCES) result, and propagate that
result to the caller of the LSM hook.  The AVC calls the security server
upon a cache miss, getting an entire access vector result from the
security server and caching it, and comparing that access vector with
the requested permissions to decide whether the AVC should return 0 or
-EACCES.

Possibly you should seek out and read the papers on LSM, e.g.
http://www.usenix.org/event/sec02/wright.html
http://www.kroah.com/linux/talks/ols_2002_lsm_paper/lsm.pdf

although the implementation has changed in some ways since those papers
were published.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
