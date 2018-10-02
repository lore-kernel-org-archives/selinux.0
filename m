Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
From: Taras Kondratiuk <takondra@cisco.com>
In-Reply-To: <153790265614.6091.7582646556934797699@takondra-t460s>
Cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
 xe-linux-external@cisco.com
References: <20180919165248.53090-1-takondra@cisco.com>
 <9a944aea-f35e-5a49-841d-6bfca8f17b9d@tycho.nsa.gov>
 <153748436388.5590.1406237328277739821@takondra-t460s>
 <66ec16b0-a335-d9ef-deb3-ef391cdd66e0@tycho.nsa.gov>
 <CAHC9VhRorkfqRTsssx_eGMy+fJQtoJew7f5i24UBkZ6tGJ5CUw@mail.gmail.com>
 <153785433233.5039.17960184426345262866@takondra-t460s>
 <a23ad753-8fd4-e9c3-cdbf-391ee154794b@tycho.nsa.gov>
 <CAHC9VhRRArA7_ON5P2JfrKxExwzm5Wznj150pfgijBoR+JxYBA@mail.gmail.com>
 <a185b384-5ef1-5e53-2cc1-066391424dcb@tycho.nsa.gov>
 <153790265614.6091.7582646556934797699@takondra-t460s>
Message-ID: <153850609939.4490.12129272851093190248@takondra-t460s>
Date: Tue, 02 Oct 2018 11:48:19 -0700
Subject: Re: [RFC PATCH] selinux: add a fallback to defcontext for
 native labeling
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Quoting Stephen Smalley (2018-09-21 07:40:58)
> If we set the inode sid to the superblock def_sid on an invalid
> context, then we lose the association to the original context value.
> The support for deferred mapping of contexts requires allocating a new
> SID for the invalid context and storing that SID in the inode, so that
> if the context later becomes valid upon a policy update/reload, the
> inode SID will refer to the now valid context.
> To combine the two, we would need security_context_to_sid_core() to
> save the def_sid in the context structure for invalid contexts, and
> change sidtab_search_core() to use that value instead of
> SECINITSID_UNLABELED for invalid SIDs.  Then the inode would be
> treated as having the defcontext for access control and getxattr() w/o
> CAP_MAC_ADMIN purposes, but a subsequent policy update/reload that
> makes the context valid would automatically cause subsequent accesses
> to the inode to start using the original context value for access
> control and getxattr() purposes.  I think that's the behavior you
> want.
> 

While implementing the change I've realized that storing default context
for sidtab_search_core() in the context structure is not enough to
achieve the desired behavior. The same invalid context may exist in two
mounts with different 'defcontext', so default context can't be a
property of a context structure.

One way to address it is to propagate default context to sidtab_search() all
the way from inode hooks. But that will be a bit intrusive. Something like
avc_has_perm_default() will need to be added.

Other way is to check for context validity in inode hooks and provide a default
context to avc_has_perm() if the inode's sid is invalid. But this may have
performance implication since validity check will be done each time in fast
path.

Do you see any other options?
