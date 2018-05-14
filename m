To: Casey Schaufler <casey@schaufler-ca.com>,
 LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 SE Linux <selinux@tycho.nsa.gov>,
 "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 James Morris <jmorris@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
 <cb3455a2-b957-8a9a-f056-35f97fe51e71@schaufler-ca.com>
 <a9e6b33b-3d17-2535-5798-bc092e8559c3@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <992325e2-0f53-0b3d-ddd2-f4f8ba7ccf89@tycho.nsa.gov>
Date: Mon, 14 May 2018 12:53:23 -0400
MIME-Version: 1.0
In-Reply-To: <a9e6b33b-3d17-2535-5798-bc092e8559c3@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 20/23] LSM: Move common usercopy into
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/14/2018 11:12 AM, Stephen Smalley wrote:
> On 05/10/2018 08:55 PM, Casey Schaufler wrote:
>> From: Casey Schaufler <casey@schaufler-ca.com>
>> Date: Thu, 10 May 2018 15:54:25 -0700
>> Subject: [PATCH 20/23] LSM: Move common usercopy into
>>  security_getpeersec_stream
>>
>> The modules implementing hook for getpeersec_stream
>> don't need to be duplicating the copy-to-user checks.
>> Moving the user copy part into the infrastructure makes
>> the security module code simpler and reduces the places
>> where user copy code may go awry.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/lsm_hooks.h  | 10 ++++------
>>  include/linux/security.h   |  6 ++++--
>>  security/apparmor/lsm.c    | 28 ++++++++++------------------
>>  security/security.c        | 17 +++++++++++++++--
>>  security/selinux/hooks.c   | 22 +++++++---------------
>>  security/smack/smack_lsm.c | 19 ++++++++-----------
>>  6 files changed, 48 insertions(+), 54 deletions(-)
>>
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 81504623afb4..84bc9ec01931 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -841,9 +841,8 @@
>>   *	SO_GETPEERSEC.  For tcp sockets this can be meaningful if the
>>   *	socket is associated with an ipsec SA.
>>   *	@sock is the local socket.
>> - *	@optval userspace memory where the security state is to be copied.
>> - *	@optlen userspace int where the module should copy the actual length
>> - *	of the security state.
>> + *	@optval the security state.
>> + *	@optlen the actual length of the security state.
>>   *	@len as input is the maximum length to copy to userspace provided
>>   *	by the caller.
>>   *	Return 0 if all is well, otherwise, typical getsockopt return
>> @@ -1674,9 +1673,8 @@ union security_list_options {
>>  	int (*socket_setsockopt)(struct socket *sock, int level, int optname);
>>  	int (*socket_shutdown)(struct socket *sock, int how);
>>  	int (*socket_sock_rcv_skb)(struct sock *sk, struct sk_buff *skb);
>> -	int (*socket_getpeersec_stream)(struct socket *sock,
>> -					char __user *optval,
>> -					int __user *optlen, unsigned int len);
>> +	int (*socket_getpeersec_stream)(struct socket *sock, char **optval,
>> +					int *optlen, unsigned int len);
>>  	int (*socket_getpeersec_dgram)(struct socket *sock,
>>  					struct sk_buff *skb,
>>  					struct secids *secid);
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index ab70064c283f..712d138e0148 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -1369,8 +1369,10 @@ static inline int security_sock_rcv_skb(struct sock *sk,
>>  	return 0;
>>  }
>>  
>> -static inline int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>> -						    int __user *optlen, unsigned len)
>> +static inline int security_socket_getpeersec_stream(struct socket *sock,
>> +						    char __user *optval,
>> +						    int __user *optlen,
>> +						    unsigned int len)
>>  {
>>  	return -ENOPROTOOPT;
>>  }
>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>> index 90453dbb4fac..7444cfa689b3 100644
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -1017,10 +1017,8 @@ static struct aa_label *sk_peer_label(struct sock *sk)
>>   *
>>   * Note: for tcp only valid if using ipsec or cipso on lan
>>   */
>> -static int apparmor_socket_getpeersec_stream(struct socket *sock,
>> -					     char __user *optval,
>> -					     int __user *optlen,
>> -					     unsigned int len)
>> +static int apparmor_socket_getpeersec_stream(struct socket *sock, char **optval,
>> +					     int *optlen, unsigned int len)
>>  {
>>  	char *name;
>>  	int slen, error = 0;
>> @@ -1037,22 +1035,16 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
>>  				 FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
>>  				 FLAG_HIDDEN_UNCONFINED, GFP_KERNEL);
>>  	/* don't include terminating \0 in slen, it breaks some apps */
>> -	if (slen < 0) {
>> +	if (slen < 0)
>>  		error = -ENOMEM;
>> -	} else {
>> -		if (slen > len) {
>> -			error = -ERANGE;
>> -		} else if (copy_to_user(optval, name, slen)) {
>> -			error = -EFAULT;
>> -			goto out;
>> -		}
>> -		if (put_user(slen, optlen))
>> -			error = -EFAULT;
>> -out:
>> -		kfree(name);
>> -
>> +	else if (slen > len)
>> +		error = -ERANGE;
>> +	else {
>> +		*optlen = slen;
>> +		*optval = name;
>>  	}
>> -
>> +	if (error)
>> +		kfree(name);
>>  done:
>>  	end_current_label_crit_section(label);
>>  
>> diff --git a/security/security.c b/security/security.c
>> index cbe1a497ec5a..6144ff52d862 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -1924,8 +1924,21 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
>>  int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>>  				      int __user *optlen, unsigned len)
>>  {
>> -	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
>> -				optval, optlen, len);
>> +	char *tval = NULL;
>> +	u32 tlen;
>> +	int rc;
>> +
>> +	rc = call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
>> +			   &tval, &tlen, len);
>> +	if (rc == 0) {
>> +		tlen = strlen(tval) + 1;
> 
> Why are you recomputing tlen here from what the module provided, and further presuming it must be nul-terminated?

Also, at least for SELinux, we copy out the length even when returning ERANGE, and libselinux uses that to realloc the buffer and try again.

> 
>> +		if (put_user(tlen, optlen))
>> +			rc = -EFAULT;
>> +		else if (copy_to_user(optval, tval, tlen))
>> +			rc = -EFAULT;
>> +		kfree(tval);
>> +	}
>> +	return rc;
>>  }
>>  
>>  int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 81f104d9e85e..9520341daa78 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -4955,10 +4955,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>>  	return err;
>>  }
>>  
>> -static int selinux_socket_getpeersec_stream(struct socket *sock,
>> -					    __user char *optval,
>> -					    __user int *optlen,
>> -					    unsigned int len)
>> +static int selinux_socket_getpeersec_stream(struct socket *sock, char **optval,
>> +					    int *optlen, unsigned int len)
>>  {
>>  	int err = 0;
>>  	char *scontext;
>> @@ -4979,18 +4977,12 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
>>  		return err;
>>  
>>  	if (scontext_len > len) {
>> -		err = -ERANGE;
>> -		goto out_len;
>> +		kfree(scontext);
>> +		return -ERANGE;
>>  	}
>> -
>> -	if (copy_to_user(optval, scontext, scontext_len))
>> -		err = -EFAULT;
>> -
>> -out_len:
>> -	if (put_user(scontext_len, optlen))
>> -		err = -EFAULT;
>> -	kfree(scontext);
>> -	return err;
>> +	*optval = scontext;
>> +	*optlen = scontext_len;
>> +	return 0;
>>  }
>>  
>>  static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, struct secids *secid)
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index 660a55ee8a57..12b00aac0c94 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -3878,14 +3878,12 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>>   *
>>   * returns zero on success, an error code otherwise
>>   */
>> -static int smack_socket_getpeersec_stream(struct socket *sock,
>> -					  char __user *optval,
>> -					  int __user *optlen, unsigned len)
>> +static int smack_socket_getpeersec_stream(struct socket *sock, char **optval,
>> +					  int *optlen, unsigned int len)
>>  {
>>  	struct socket_smack *ssp;
>>  	char *rcp = "";
>>  	int slen = 1;
>> -	int rc = 0;
>>  
>>  	ssp = smack_sock(sock->sk);
>>  	if (ssp->smk_packet != NULL) {
>> @@ -3894,14 +3892,13 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
>>  	}
>>  
>>  	if (slen > len)
>> -		rc = -ERANGE;
>> -	else if (copy_to_user(optval, rcp, slen) != 0)
>> -		rc = -EFAULT;
>> -
>> -	if (put_user(slen, optlen) != 0)
>> -		rc = -EFAULT;
>> +		return -ERANGE;
>>  
>> -	return rc;
>> +	*optval = kstrdup(rcp, GFP_ATOMIC);
>> +	if (*optval == NULL)
>> +		return -ENOMEM;
>> +	*optlen = slen;
>> +	return 0;
>>  }
>>  
>>  
>>
> 
> 
