Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qB50JHDV019311
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2012 19:19:17 -0500
Message-ID: <50BE92ED.9000400@schaufler-ca.com>
Date: Tue, 04 Dec 2012 16:18:53 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, john.johansen@canonical.com, eparis@redhat.com,
        keescook@chromium.org, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v9 1/2] LSM: Multiple concurrent LSMs
References: <50B930FC.4070106@schaufler-ca.com> <201212021337.HGG69754.LFQtOOVMFFOHSJ@I-love.SAKURA.ne.jp> <201212032040.HBD43784.tOVQFLHJSMFOOF@I-love.SAKURA.ne.jp> <201212042243.BJG73463.LFHFQFSJOOVOMt@I-love.SAKURA.ne.jp>
In-Reply-To: <201212042243.BJG73463.LFHFQFSJOOVOMt@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/4/2012 5:43 AM, Tetsuo Handa wrote:
> Below is an approach for allowing the callers to determine how many of
> /name=value/ pairs passed to setprocattr() have succeeded.
> Returns -ve if none processed and returns offset if at least one processed.
> (Well, should we use '\0' as separater rather than '/' ?)

I don't want to use '\0' because then you can't use:

	echo "/smack=foo/apparmor=/usr/bin/cupsd (enforce)/" > /proc/self/attr/current

I have however identified where my scheme is flawed. If you did the above when
AppArmor is not configured you get a smack label of "foo/apparmor=/usr/bin/cupsd".
So it has to change. What do y'all think of:

	<smack>foo</smack><apparmor>/usr/bin/cupsd (enforce)</apparmor>

Yeah, it's verbose but it wouldn't be any worse to parse than what I have now
and it addresses the problem.

Or, offer a solution you like better, but it needs to be plain text, no embedded
null characters.


>
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2061,66 +2061,51 @@ int security_setprocattr(struct task_struct *p, char *name, void *value,
>  				size_t size)
>  {
>  	struct security_operations *sop;
> -	char searches[COMPOSER_MAX][SECURITY_NAME_MAX + 4];
>  	char *data = value;
> -	char *values[COMPOSER_MAX];
> -	int eos = 0;
> -	int formatted = 0;
> -	int only = 0;
> -	int thisrc;
> -	int rc = size;
> -
> -	if (lsm_present)
> -		return present_setprocattr(p, name, value, size);
> +	char * const start = data;
> +	int processed = 0;
> +	int rc = -EINVAL;
>  
> -	if (size > PAGE_SIZE - 1)
> +	if (size && data[0] != '/') {
> +		if (lsm_present)
> +			return present_setprocattr(p, name, value, size);
>  		return -EINVAL;
> -	if (size > 0)
> -		eos = size - 1;
> -	while (eos > 0 && (data[eos] == '\0' || data[eos] == '\n'))
> -		eos--;
> -
> -	if (data[0] == '/' && data[eos] == '/') {
> -		/*
> -		 * "/smack=Howdy/apparmor=confined/bandl=12/1,2,6/"
> -		 */
> -		formatted = 1;
> -		data[eos] = '\0';
> -		for_each_hook(sop, setprocattr) {
> -			sprintf(searches[sop->order], "/%s=", sop->name);
> -			values[sop->order] = strnstr(data,
> -						searches[sop->order], size);
> -		}
> -		for_each_hook(sop, setprocattr) {
> -			if (values[sop->order] != NULL) {
> -				*values[sop->order] = '\0';
> -				values[sop->order] = values[sop->order] +
> -					strlen(searches[sop->order]);
> -			}
> -		}
>  	}
> +	/*
> +	 * "/smack=Howdy/apparmor=confined/bandl=12/1,2,6/"
> +	 *
> +	 * Parse and dispatch sequentially, and use fail and bail so that
> +	 * the caller can determine that setprocattr() has partially
> +	 * succeeded via "return value" less than "size" argument.
> +	 */
> +next:
>  	for_each_hook(sop, setprocattr) {
> -		if (formatted && values[sop->order] == NULL)
> +		const char *cp = sop->name;
> +		size_t len = strlen(cp);
> +		if (size < len + 2 || memcmp(data + 1, cp, len) ||
> +		    data[len + 1] != '=')
>  			continue;
> -		if (only == 0)
> -			only = sop->order;
> -		else
> -			only = -1;
> -
> -		if (formatted)
> -			thisrc = sop->setprocattr(p, name, values[sop->order],
> -					strlen(values[sop->order]) + 1);
> -		else
> -			thisrc = sop->setprocattr(p, name, value, size);
> -
> -		if (thisrc < 0)
> -			rc = thisrc;
> +		len += 2;
> +		data += len;
> +		size -= len;
> +		cp = memchr(data, '/', size);
> +		if (!cp || cp == data)
> +			break;
> +		len = cp - data;
> +		rc = sop->setprocattr(p, name, data, len);
> +		if (rc < 0)
> +			break;
> +		rc = -EINVAL;
> +		data = (char *) cp;
> +		size -= len;
> +		processed = data - start + 1;
> +		if (size > 1 && data[0] == '/')
> +			goto next;
> +		break;
>  	}
> -
> -	if (only == 0)
> -		return -EINVAL;
> +	if (processed)
> +		return processed;
>  	return rc;
> -
>  }
>  
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb)
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
