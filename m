Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA06535
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 07:39:36 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA22699
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 11:37:52 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA22695 for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 11:37:51 GMT
Date: Mon, 19 Aug 2002 07:38:48 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: shadow_t
In-Reply-To: <20020816230931.DFD12A19@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208190737120.14458-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 17 Aug 2002, Russell Coker wrote:

> I've got shadow_t working correctly with my policy.
>
> I have changed the spasswd.c program to relabel the /etc/passwd and
> /etc/shadow files after running /usr/bin/passwd, and I made a
> file_type_auto_trans() rule to have them default to shadow_t (which
> unfortunately gives a momentary situation where /etc/passwd will be
> unreadable).  It would also be unfortunate if there was a power outage at
> that moment...
>
> So I'm thinking of having a program run from a boot script to fix the type of
> /etc/passwd.
>
> Also I've got vipw and adduser also working with shadow_t...
>
> This isn't ideal, but the code for the chsh/chfn/vipw/etc programs is really
> ugly and I'm afraid of causing more problems than I fix if I change them.

Can you clarify what you mean by the latter statements, i.e. have you
created wrapper programs for vipw and adduser to relabel /etc/passwd from
shadow_t to etc_t after completion, or have you patched these programs?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com







--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
