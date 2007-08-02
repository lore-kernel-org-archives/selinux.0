Date: Wed, 1 Aug 2007 21:19:06 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Labeled NFS <labeled-nfs@linux-nfs.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC] SENFS: MAC labeling support for NFSv4
In-Reply-To: <11859985322836-git-send-email-dpquigl@tycho.nsa.gov>
Message-ID: <Pine.LNX.4.64.0708012040350.29184@us.intercode.com.au>
References: <11859985322836-git-send-email-dpquigl@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Aug 2007, David P. Quigley wrote:

> This is the first set of patches attempting to provide a generic framework for
> MAC labeling in NFSv4.

I agree with Casey that this is too SELinux-specific to be regarded as 
a generic framework.

Given that it's a prototype, which only addresses label transport, I think 
it's probably ok to proceed with this prototype work as SELinux-specific, 
and then look at how it might be refactored as a generic framework with 
SELinux as one flavor.

I suggest making the explanation of the patch set much clearer, so that 
reviewers and developers can more readily understand the scope, purpose, 
test/demonstration status, outstanding issues, next steps etc.

In this case, IIUC, these patches are an SELinux-specific prototype, which 
demonstrate recommended attributes as a potential label transport 
mechanism.  Can you explain, for example, how and why this is a desirable 
approach, and what the patches demonstrate?

Also, in this discussion, we need to also make a distinction between LSM, 
an existing Linux-specific generic framework, and Labeled NFS, which is 
expected to be an OS-independent framework.

LSM already provides a u32 secid / string conversion interface, which was 
required for the Linux Labeled IPsec and Audit work, based on SELinux 
requirements.  The existence of this interface does not mean that it has 
to be used, or that it is the only possible interface.  If another LSM is 
merged which wants to make use of these facilities, a case could be made 
as part of that merge to further generalize the interfaces, and until 
then, using blobs instead of u32 is adding unnecessary infrastructure and 
overhead, while also further weakening the semantics of the API.

IOW:

-  Work which extends LSM should continue to extend the secid/secctx 
   interfaces in a consistent manner.  These interfaces may be subject to 
   change if another LSM is merged.

-  Initial prototyping should probably just remain SELinux-specific, with 
   the Linux implementation code using LSM for security calls, and 
   with any related extensions to NFS/RPC itself be clearly marked as 
   SELinux-specific.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
