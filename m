Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qAQGY4An029370
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2012 11:34:04 -0500
Message-ID: <50B399E3.2000207@schaufler-ca.com>
Date: Mon, 26 Nov 2012 08:33:39 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, john.johansen@canonical.com, eparis@redhat.com,
        keescook@chromium.org, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v8 1/2] LSM: Multiple concurrent LSMs
References: <50ABE35B.7060103@schaufler-ca.com> <201211212258.IEI34810.FOMOOSLJQFFHVt@I-love.SAKURA.ne.jp> <50AD39E4.5060307@schaufler-ca.com> <201211222220.JID30761.OVJtFLOOFHFQSM@I-love.SAKURA.ne.jp> <201211252210.CFJ12903.FtQHSOOFOVMJFL@I-love.SAKURA.ne.jp> <201211262204.GGI04679.FtLJQFHVOOMSFO@I-love.SAKURA.ne.jp>
In-Reply-To: <201211262204.GGI04679.FtLJQFHVOOMSFO@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/26/2012 5:04 AM, Tetsuo Handa wrote:
> Something like this?

I've incorporated several of differences. They'll be in the next (v8) patch.

>
> int security_getprocattr(struct task_struct *p, char *name, char **value)
> {
> 	struct security_operations *sop;
> 	struct security_operations *note[COMPOSER_MAX];
> 	char *values[COMPOSER_MAX];
> 	int rcs[COMPOSER_MAX];
> 	int i = 0;
> 	struct security_operations *preferred = lsm_present;
>
> 	if (preferred)
> 		return preferred->getprocattr(p, name, value);
>
> 	/*
> 	 * Find all the LSMs that produce procattrs and call them,
> 	 * saving the results.
> 	 */
> 	for_each_hook(sop, getprocattr) {
> 		note[i] = sop;
> 		values[i] = NULL;
> 		rcs[i] = sop->getprocattr(p, name, &values[i]);
> 		i++;
> 	}
> 	/*
> 	 * Special cases for 0 and 1 LSMs getting called.
> 	 * Otherwise, return a composed string.
> 	 */
> 	if (!i)
> 		return -EINVAL;
> 	if (i == 1) {
> 		*value = values[0];
> 		return rcs[0];
> 	} else {
> 		char *result;
> 		int notes = i;
> 		int total = 0;
> 		for (i = 0; i < notes; i++) {
> 			if (rcs[i] < 0)
> 				total += 6; /* "(null)" */
> 			else
> 				total += rcs[i];
> 			total += strlen(note[i]->name) + 2;
> 		}
> 		result = kzalloc(total + 3, GFP_KERNEL);
> 		*value = result;
> 		if (!result) {
> 			for (i = 0; i < notes; i++)
> 				kfree(values[i]);
> 			return -ENOMEM;
> 		}
> 		for (i = 0; i < notes; i++) {
> 			char *cp;
> 			strcat(result, "/");
> 			strcat(result, note[i]->name);
> 			strcat(result, "=");
> 			if (!values[i]) {
> 				strcat(result, "(null)");
> 				continue;
> 			}
> 			cp = memchr(values[i], '\n', rcs[i]);
> 			if (cp)
> 				*cp = '\0';
> 			strncat(result, values[i], rcs[i]);
> 			kfree(values[i]);
> 		}
> 		strcat(result, "/\n");
> 		return strlen(result) + 1;
> 	}
> }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
