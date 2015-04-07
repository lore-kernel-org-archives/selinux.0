Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t370i3hF016597
 for <selinux@tycho.nsa.gov>; Mon, 6 Apr 2015 20:44:04 -0400
Received: by qkx62 with SMTP id 62so36256692qkx.0
 for <selinux@tycho.nsa.gov>; Mon, 06 Apr 2015 17:43:35 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [GIT PULL] SELinux patches for 4.1
Date: Mon, 06 Apr 2015 20:43:31 -0400
Message-ID: <47618041.M4z7H003Sc@sifl>
In-Reply-To: <alpine.LRH.2.11.1504070004170.7027@namei.org>
References: <1978116.cNUKEOv2T8@sifl>
 <14c8ec61728.2806.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <alpine.LRH.2.11.1504070004170.7027@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, April 07, 2015 12:04:59 AM James Morris wrote:
> On Mon, 6 Apr 2015, Paul Moore wrote:
> > You know James, we could probably shorten this process tremendously if you
> > could respond with a sentence or two instead of a single word :-)
> > 
> > So you didn't pull the SELinux tree, is that because you simply haven't
> > had time yet? Or is it because you don't like something in the tree? If
> > the latter, can you expand upon what you don't like so I can remedy it?
> 
> I haven't pulled from it because you still have a patch in there which is
> in Linus' tree.

See, that wasn't so hard to type out :)

Removed the patch, it should now just contain the five patches described at 
the start, and shown again below.  It's based again the current security#next 
branch so there should be no problems, at least there haven't been in my test 
pulls.

On Tuesday, April 07, 2015 12:09:56 AM James Morris wrote:
> You should be working downstream from my next branch.  When I pull from
> you, it should merge cleanly.

I am working downstream from your next branch (the selinux#upstream branch is 
based on security#next), I have been for some time now.  I've posted online 
how I manage the SELinux tree (and audit tree if that matters) and if there 
are any changes I post updates; here it is in case you're curious:

  1. Create a new branch, stable-X.XX, set to the upstream branch that
     was sent during the merge window.

  2. Reset the next branch to the upstream branch that was sent during
     the merge window.

  3. Accept new features into the next branch and fixes into the
     stable-X.XX branch.

  4. As necessary, merge stable-X.XX into upstream and send pull
     requests upstream.

  5. When vX.XX is released, merge next into upstream and send a pull
     request for the upstream branch.  Leave stable-3.XX untouched for
     future stable fixes.

  6. Goto step #1.

It might be helpful if you posted how you manage the security tree.

---
The following changes since commit 4f9a60f5c7e74f3e413a1ede1e8b959d01df4e57:

  Merge branch 'smack-for-4.1' of git://github.com/cschaufler/smack-next into 
    next (2015-04-02 11:03:58 +1100)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux upstream

for you to fetch changes up to cf7b6c0205f11cdb015384244c0b423b00e35c69:

  selinux: increase avtab max buckets (2015-04-06 20:16:23 -0400)

----------------------------------------------------------------
Jeff Vander Stoep (1):
      selinux: remove unnecessary pointer reassignment

John Brooks (1):
      selinux: Use a better hash function for avtab

Paul Moore (1):
      selinux: reconcile security_netlbl_secattr_to_sid() and
               mls_import_netlbl_cat()

Stephen Smalley (2):
      selinux: convert avtab hash table to flex_array
      selinux: increase avtab max buckets

 security/selinux/avc.c         |  6 ++--
 security/selinux/ss/avtab.c    | 72 ++++++++++++++++++++++++++++++---------
 security/selinux/ss/avtab.h    |  8 +++--
 security/selinux/ss/mls.c      | 10 ++----
 security/selinux/ss/services.c |  6 +---
 5 files changed, 67 insertions(+), 35 deletions(-)

-- 
paul moore
www.paul-moore.com
