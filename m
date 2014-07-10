Message-ID: <53BED153.2020206@tycho.nsa.gov>
Date: Thu, 10 Jul 2014 13:45:55 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <pmoore@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: fix the default socket labeling in sock_graft()
References: <20140710153728.21266.78354.stgit@localhost>
 <53BEC5B5.5020508@tycho.nsa.gov>
In-Reply-To: <53BEC5B5.5020508@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Milan Broz <gmazyland@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/10/2014 12:56 PM, Stephen Smalley wrote:
> On 07/10/2014 11:37 AM, Paul Moore wrote:
>> The sock_graft() hook has special handling for AF_INET, AF_INET, and
>> AF_UNIX sockets as those address families have special hooks which
>> label the sock before it is attached its associated socket.
>> Unfortunately, the sock_graft() hook was missing a default approach
>> to labeling sockets which meant that any other address family which
>> made use of connections or the accept() syscall would find the
>> returned socket to be in an "unlabeled" state.  This was recently
>> demonstrated by the kcrypto/AF_ALG subsystem and the newly released
>> cryptsetup package (cryptsetup v1.6.5 and later).
>>
>> This patch preserves the special handling in selinux_sock_graft(),
>> but adds a default behavior - setting the sock's label equal to the
>> associated socket - which resolves the problem with AF_ALG and
>> presumably any other address family which makes use of accept().
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Paul Moore <pmoore@redhat.com>
>> Tested-by: Milan Broz <gmazyland@gmail.com>
>> ---
>>  security/selinux/hooks.c |   12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 336f0a0..39f16d0 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -4499,9 +4499,17 @@ static void selinux_sock_graft(struct sock *sk, struct socket *parent)
>>  	struct inode_security_struct *isec = SOCK_INODE(parent)->i_security;
>>  	struct sk_security_struct *sksec = sk->sk_security;
>>  
>> -	if (sk->sk_family == PF_INET || sk->sk_family == PF_INET6 ||
>> -	    sk->sk_family == PF_UNIX)
>> +	switch (sk->sk_family) {
>> +	case PF_INET:
>> +	case PF_INET6:
>> +	case PF_UNIX:
>>  		isec->sid = sksec->sid;
>> +		break;
>> +	default:
>> +		/* by default there is no special labeling mechanism for the
>> +		 * sock label so inherit the label from the parent socket */
>> +		sksec->sid = isec->sid;
>> +	}
> 
> Wait...why would we assign isec->sid from sksec->sid in the former case
> but the reverse here?  Shouldn't we be setting isec->sid in all cases?
> The hook documentation in include/linux/security.h unfortunately does
> not describe the actual abstract behavior but rather describes the
> implementation in the inet case.

Ok, I think I understand this now:  for inet and unix, sksec->sid is set
in other hooks upon connection establishment based on the peer label -
primarily for multi-level servers - and we are propagating it upward to
the parent socket inode.  For others, sksec->sid is not set anywhere
except initialized to unlabeled upon sock creation and so you are just
pushing the parent socket inode label down to the sock in your patch.

It seems a bit fragile though and certainly doesn't align with the
sock_graft hook documentation anymore.  Wondering if we should assert
that sksec->sid is not SECINITSID_UNLABELED in the inet/inet6/unix case
(i.e. that sksec->sid has been set prior to copying it to isec->sid) and
that sksec->sid is SECINITSID_UNLABELED (i.e. that it has not already
been set by the protocol implementation) in the default case.
We need to update the hook documentation too.
