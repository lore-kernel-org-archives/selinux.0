Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7GIxvrT008981
	for <selinux@tycho.nsa.gov>; Mon, 16 Aug 2004 14:59:57 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7GIwsqN018460
	for <selinux@tycho.nsa.gov>; Mon, 16 Aug 2004 18:59:17 GMT
Message-ID: <41210415.9070405@tresys.com>
Date: Mon, 16 Aug 2004 14:59:33 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>
CC: Stephen Smalley <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov,
   Nalin The Nalinator Dahyabhai <nalin@redhat.com>,
   Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [patch] setting default role from ssh
References: <1092513257.4515.28.camel@nexus.verbum.private>	 <1092665369.16631.53.camel@moss-spartans.epoch.ncsc.mil> <1092670862.9971.20.camel@nexus.verbum.private>
In-Reply-To: <1092670862.9971.20.camel@nexus.verbum.private>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If this is implemented would it be possible to define a mechanism for 
controlling roles reachable in this manner?

Joshua Brindle


Colin Walters wrote:

> On Mon, 2004-08-16 at 10:09 -0400, Stephen Smalley wrote:
> 
> 
>>This is certainly a useful enhancement.  Using the "style" in this
>>manner should likely be discussed with the openssh developers in order
>>to determine whether we might be able to do this in a way that is
>>acceptable upstream and avoids any conflict with other uses of the
>>"style", e.g. possibly using some prefix of the style to indicate that
>>it is being used for SELinux, a domain of interpretation (DOI)
>>indicator.
> 
> 
> Hm, or perhaps a different separator character entirely?  Looking at
> this message:
> http://sources.redhat.com/ml/libc-alpha/2001-02/msg00113.html
> It looks like the only nonalpha/nondigit characters allowed in usernames
> are: . _ -
> 
> Perhaps:
> 
> ssh username/sysadm_r@hostname ?
> 
> That way in theory on SE-BSD you could still do:
> 
> ssh username/sysadm_r:style@hostname
> 
> 
>>  Otherwise, you'll likely have to carry it as a separate
>>patch forever, SE-BSD won't be able to use it, 
> 
> 
> I wonder if the BSD people are really actively using it.  I guess though
> even if they weren't, the OpenSSH developers would be averse to breaking
> backwards compatibility for those who were.
> 
> 
>>and there is the
>>potential for future conflict in Linux if someone else wants to use the
>>style for another purpose.
> 
> 
> True, although that doesn't seem very likely to me.
> 
> 
>>>Now, looking at the duplicative code in those two sections, I'm thinking
>>>that it would make sense to have a libselinux function for this.
>>>Probably something like:
>>>
>>>int
>>>get_default_context_with_role (const char *user, security_context_t fromcon, 
>>>                               const char *role, security_context_t *newcon);
>>
>>One question I have is whether the code should do a reachability check
>>for the specified role and fail immediately if it is not reachable;
>>get_default_context normally only returns contexts that are reachable
>>from the 'fromcon' (i.e. process transition permission is granted
>>between the 'fromcon' and the returned contexts).
> 
> 
> I think that it should fail, yes.  If someone goes to the trouble of
> explicitly specifying a role, it's likely they want to have immediate
> login failure rather than having errors later because they mistyped the
> role and thus get_default_context_with_role returned the default role
> which didn't have the expected privileges.
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
