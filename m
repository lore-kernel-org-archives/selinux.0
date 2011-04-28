From: Roberto Sassu <roberto.sassu@polito.it>
To: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC][PATCH 4/7] smack: fix label check in smack_kernel_act_as()
Date: Thu, 28 Apr 2011 11:22:31 +0200
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com, jmorris@namei.org,
        zohar@linux.vnet.ibm.com, safford@watson.ibm.com,
        tyhicks@linux.vnet.ibm.com, kirkland@canonical.com,
        ecryptfs-devel@lists.launchpad.net, eparis@redhat.com,
        sds@tycho.nsa.gov, selinux@tycho.nsa.gov, viro@zeniv.linux.org.uk
References: <1303907657-18366-1-git-send-email-roberto.sassu@polito.it> <1303907657-18366-5-git-send-email-roberto.sassu@polito.it> <4DB8A53A.4010709@schaufler-ca.com>
In-Reply-To: <4DB8A53A.4010709@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201104281122.31702.roberto.sassu@polito.it>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, April 28, 2011 01:22:34 AM Casey Schaufler wrote:
> On 4/27/2011 5:34 AM, Roberto Sassu wrote:
> > The function smack_kernel_act_as() must return -EINVAL if the label
> > returned by smack_from_secid() is equal to 'smack_known_invalid.smk_known',
> > which means that no entries in the 'smack_known_list' list matching the
> > security identifier given are found.
> 
> I'll admit that the code here is wrong, but I disagree with the fix.
> 
> smack_from_secid() will never return NULL, so the check for NULL is
> pointless. Checking for known_invalid is not right either, as the
> Smack philosophy is to return a label in all cases, as is evident
> by the behavior of smack_from_secid(). Thus, the correct change
> would be to remove the error check completely and set the new task
> value to the value obtained from smack_from_secid in all cases.
> 
> Besides, where did the caller of this function get a secid that isn't
> going to map to a Smack label?
> 

I discovered the issue when calling the function set_security_override_from_ctx(),
located in kernel/cred.c, which will be used in eCryptfs to override the set
of initial credentials (i'm about to post the patches).
This function accepts an arbitrary string and uses it as a security label to replace
the one in the credentials provided. If the string passed is not yet imported
to SMACK, the 'smack_known_invalid.smk_known' label is applied without this fact
is notified to the caller.
I tried to solve the problem by importing the string during the execution of the
security_secctx_to_secid() hook, so that set_security_override() will never fail.
So, probably the string must be already been imported if no new memory can be
allocated during smack_secctx_to_secid().


> > Signed-off-by: Roberto Sassu <roberto.sassu@polito.it>
> > ---
> >  security/smack/smack_lsm.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > index e3c9e54..0e7ed31 100644
> > --- a/security/smack/smack_lsm.c
> > +++ b/security/smack/smack_lsm.c
> > @@ -1415,7 +1415,7 @@ static int smack_kernel_act_as(struct cred *new, u32 secid)
> >  	struct task_smack *new_tsp = new->security;
> >  	char *smack = smack_from_secid(secid);
> >  
> > -	if (smack == NULL)
> > +	if (smack == smack_known_invalid.smk_known)
> >  		return -EINVAL;
> >  
> >  	new_tsp->smk_task = smack;
> 
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
