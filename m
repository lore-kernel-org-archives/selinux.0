Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA02844
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 10:58:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA29722
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 14:56:58 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA29718 for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 14:56:57 GMT
Date: Tue, 28 May 2002 10:57:58 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: strange capability problem
In-Reply-To: <20020523174643.BA62D1D5B@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0205281054260.1315-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 23 May 2002, Russell Coker wrote:

> I have attached the strace output from the radvd program.
>
> When it is run the following error is logged:
> avc:  denied  { sys_module } for  pid=879 exe=/usr/sbin/radvd capability=16
> scontext=system_u:system_r:radvd_t tcontext=system_u:system_r:radvd_t
> tclass=capability
>
> However I can't work out what it does to cause that!  The strace.out file
> contains no query_module() or create_module() call.

CAP_SYS_MODULE is only required for the create_module(), init_module(),
delete_module() calls and for modifying the cap-bound sysctl variable.
Does lsmod show any difference before and after radvd is started?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
