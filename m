Message-ID: <532308EF.4070206@redhat.com>
Date: Fri, 14 Mar 2014 09:49:35 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <pmoore@redhat.com>
Subject: Re: [RFC PATCH v1] selinux: add transitions for kernel keys
References: <20140312215305.9695.86521.stgit@localhost>
 <3794276.87hdXQ4UL5@sifl> <5321DE1C.2050301@tycho.nsa.gov>
 <33212632.ZbM6lVVu1e@sifl> <5322EF5D.6030509@tycho.nsa.gov>
In-Reply-To: <5322EF5D.6030509@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mgrepl@redhat.com, eparis@redhat.com, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/14/2014 08:00 AM, Stephen Smalley wrote:
> On 03/13/2014 07:00 PM, Paul Moore wrote:
>> On Thursday, March 13, 2014 12:34:36 PM Stephen Smalley wrote:
>>> I guess I don't understand the original problem or fix then.  I
>>> assumed that cred->security was referring to one set of credentials
>>> while current_security() was referring to another and you wanted to use
>>> the latter instead of the former.  If not, then none of this makes any 
>>> sense.  Transitions are for computing new labels from a pair of
>>> labels, either by allowing selection of either subject or object or by
>>> deriving a new label from the two.  If there is only one label in view
>>> and the other is always fixed (kernel), then under what conditions are
>>> you going to label some keys with the kernel domain and why does that
>>> make any sense at all?  It was still allocated by some userspace
>>> process and ought to carry along the credentials of that process.
>> 
>> If we ignore setkeycreatecon() for a moment, keys are always created with
>> the label of the process that creates them, this is normal and expected.
>> The issue arises when several different processes, each with a different
>> label, need to update/modify the same key; there is a race-like condition
>> where the security label for a key could change depending on which
>> process "won" and created the key.  This unpredictability is causing the
>> policy writers a headache as they try to craft policy that isn't overly
>> permissive when it comes to the keyring.
>> 
>> One example taken from a problem report:
>> 
>> "Right now keys created in the kernel are done so with the label of the
>> creating process.  That means that if sssd adds a key to be used by the
>> user all user types must be able to read sssd_t keys.  If they want to
>> use kinit to update the key, now all user types must be able to write to
>> sssd_t keys."
>> 
>>> The SELinux key/keyring model was designed quite a while ago and
>>> vetted by the keys/keyrings maintainer, so I'd be careful about any
>>> changes without careful consideration and review by the keys maintainer
>>> (David Howells).  It is also documented in
>>> Documentation/security/keys.txt.
>> 
>> You are right, I should have CC'd David on the posting, I'll do that for
>> v2.
>> 
>> As for the documentation, I'll update it in the v2 patch to mention the 
>> proposed transition mechanism.  As it stands right now I don't see a
>> major issue with this proposal so long as we ensure that the default
>> behavior matches what is seen on systems today.
> 
> No, we need to understand the model you are proposing first before we 
> discuss the code.
> 
> Currently, we label keys based on creator unless using setkeycreatecon(),
> same as sockets.  With sockets though there is a special case for
> kernel-internal sockets where those are labeled with the kernel domain and
> exempted, but those are never exposed directly to userspace.
> 
> How do you envision labeling keys?  Will some keys still be labeled with 
> the creator's domain, and others with the kernel domain?  Which ones get 
> labeled which way?  And if you have to allow everyone to write to the 
> kernel domain labeled keys, then how are you helping prevent the very 
> problem you described, i.e. you are still introducing a globally-writable
> type in the policy (unconstrained sharing, potential for misuse of a key
> intended for another).
> 
> 
> 
> 
> 
> _______________________________________________ Selinux mailing list 
> Selinux@tycho.nsa.gov To unsubscribe, send email to
> Selinux-leave@tycho.nsa.gov. To get help, send an email containing "help"
> to Selinux-request@tycho.nsa.gov.
> 
> 
I believe the problem is there is no way for sssd to know which label to
assign to the keyring at the time of creation.  I have suggested that they
wait to create the keyring until after pam_selinux has been called so they
could then create the keyring with the setkeycreatecon(getexeccon()).  Not
sure what a transition rule would buy you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMjCO8ACgkQrlYvE4MpobMF0QCgpcT53BKaAUt3S3y83AZGJTxw
UXoAoNAU2ZgPOLbq+3hrdpKx5SDcCRbp
=bh+0
-----END PGP SIGNATURE-----
