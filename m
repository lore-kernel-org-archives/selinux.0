Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA00825
	for <selinux@tycho.nsa.gov>; Wed, 17 Apr 2002 14:13:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA25458
	for <selinux@tycho.nsa.gov>; Wed, 17 Apr 2002 18:12:01 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id SAA25454 for <selinux@tycho.nsa.gov>; Wed, 17 Apr 2002 18:12:01 GMT
Date: Wed, 17 Apr 2002 14:12:49 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: what's wrong this this rule?
In-Reply-To: <20020417172203.1500922C7@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204171358520.902-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 17 Apr 2002, Russell Coker wrote:

> allow setfiles_t file_type:dir_file_class_set { getattr relabelfrom relabelto
> };
>
> Above is the rule, below is a sample of the error I get when running setfiles
> with it.
>
> avc:  denied  { relabelto } for  pid=6893 exe=/usr/sbin/setfiles
> path=/etc/security/selinux/policy.9 dev=03:02 ino=1281
> scontext=rjc:sysadm_r:setfiles_t tcontext=system_u:object_r:policy_config_t
> tclass=file

Since the user identity attribute differs (rjc vs. system_u), the
permission is being denied by a constraint.  If you add the 'privowner'
attribute to setfiles_t, then this will be allowed.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
