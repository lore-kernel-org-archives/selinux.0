From: Paul Moore <pmoore@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH v1] selinux: add transitions for kernel keys
Date: Thu, 13 Mar 2014 19:00:09 -0400
Message-ID: <33212632.ZbM6lVVu1e@sifl>
In-Reply-To: <5321DE1C.2050301@tycho.nsa.gov>
References: <20140312215305.9695.86521.stgit@localhost>
 <3794276.87hdXQ4UL5@sifl> <5321DE1C.2050301@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: mgrepl@redhat.com, selinux@tycho.nsa.gov, eparis@redhat.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, March 13, 2014 12:34:36 PM Stephen Smalley wrote:
> I guess I don't understand the original problem or fix then.  I assumed
> that cred->security was referring to one set of credentials while
> current_security() was referring to another and you wanted to use the
> latter instead of the former.  If not, then none of this makes any
> sense.  Transitions are for computing new labels from a pair of labels,
> either by allowing selection of either subject or object or by deriving
> a new label from the two.  If there is only one label in view and the
> other is always fixed (kernel), then under what conditions are you going
> to label some keys with the kernel domain and why does that make any
> sense at all?  It was still allocated by some userspace process and
> ought to carry along the credentials of that process.

If we ignore setkeycreatecon() for a moment, keys are always created with the 
label of the process that creates them, this is normal and expected.  The 
issue arises when several different processes, each with a different label, 
need to update/modify the same key; there is a race-like condition where the 
security label for a key could change depending on which process "won" and 
created the key.  This unpredictability is causing the policy writers a 
headache as they try to craft policy that isn't overly permissive when it 
comes to the keyring.

One example taken from a problem report:

 "Right now keys created in the kernel are done so with the label
  of the creating process.  That means that if sssd adds a key to
  be used by the user all user types must be able to read sssd_t
  keys.  If they want to use kinit to update the key, now all user
  types must be able to write to sssd_t keys."

> The SELinux key/keyring model was designed quite a while ago and vetted
> by the keys/keyrings maintainer, so I'd be careful about any changes
> without careful consideration and review by the keys maintainer (David
> Howells).  It is also documented in Documentation/security/keys.txt.

You are right, I should have CC'd David on the posting, I'll do that for v2.

As for the documentation, I'll update it in the v2 patch to mention the 
proposed transition mechanism.  As it stands right now I don't see a major 
issue with this proposal so long as we ensure that the default behavior 
matches what is seen on systems today.

-- 
paul moore
security and virtualization @ redhat
