Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA24557
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 10:45:15 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA19099
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 15:45:10 GMT
Received: from khaipur.xiat.org ([66.125.68.98])
	by jazzswing.ncsc.mil  with ESMTP id PAA19095
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 15:45:09 GMT
Date: Mon, 03 Dec 2001 07:40:53 -0800
From: Paul Krumviede <pwk@acm.org>
To: Stephen Smalley <sds@tislabs.com>
cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: use of ps in ipsec shutdown
Message-ID: <202680429.1007365253@localhost>
In-Reply-To: <Pine.GSO.4.33.0112030911410.4293-100000@raven>
References: <Pine.GSO.4.33.0112030911410.4293-100000@raven>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--On Monday, 03 December, 2001 09:23 -0500 Stephen Smalley 
<sds@tislabs.com> wrote:

>
> On Fri, 30 Nov 2001, Paul Krumviede wrote:
>
>> i noticed that the supplied policy left some processes in the
>> initrc_t domain, such as _plutorun and _plutoload. i also noticed
>> that the ipsec startup script invokes logger, and that whack,
>> running in the initrc_t domain, was being denied permission
>> to connect to the socket set up by pluto. so i labeled the
>> /usr/local/sbin/ipsec script, whack, _plutoload, _plutoread
>> and whack as ipsec_exec_t types, and allowed ipsec_t
>> to execute shells, bin_t and sbin_t things (the latter in part
>> because the default label of things in /usr/local/lib/ipsec
>> is sbin_t). this seems to have fixed all the things decribed
>> above (although i'm open to suggestions as to alternative
>> approaches).
>
> The problem with this approach is that it increases the risk that
> malicious code will be able to execute in the ipsec_t domain and
> thus gain access to a PF_KEY socket.  The ipsec_t domain should only
> be granted execute access to the ipsec_exec_t type, and this type
> should only be assigned to code that legitimately needs to access
> PF_KEY sockets.  Any other code should be run in a different domain.

what i want to do is partition all of the ipsec-related code, and then
break those things into more specific domains, such as a domain
that can access/manage keying material and a domain that can
access things in the first domain (perhaps an ipsec_client_t as
you suggest in a subsequent messages). i've been thinking of
an ipsec_admin role as well (one of mark's comments in sysadm.te
alludes to this) and then restricing access to some of the ipsec
functions to this role (and to initrc_t).

the first pass at such a partition started when i noticed that i
had processes running in the initrc_t domain.

>> i also noticed that _startklips wanted (limited) access
>> to /proc/sys/net/ipsec/icmp, so i gave some sysctl
>> access.
>
> We can modify the module to bind a distinct type to /proc/sys/net/ipsec if
> desired.

that seems worthwhile.

>> i later noticed a number of avc denials at shutdown
>> when ps, apparently run out of _realsetup, is attempting
>> to read some of the process information. for example, i see
>>
>> avc:  denied  { getattr } for  pid=2358 exe=/bin/ps path=/1 dev=00:03
>> ino=65538
>>    scontext=system_u:system_r:ipsec_t
>>    tcontext=system_u:system_r:init_t
>>    tclass=dir
>
> This is probably happening because the script is now running in ipsec_t,
> which isn't a good idea anyway.  But this is a common problem when ps
> scans /proc, because only a subset of /proc will be accessible to most
> domains.  It is ok to deny these accesses, because this process only
> truly needs to access the /proc/PID entries for processes within the
> ipsec_t domain in order to shut down those processes.  You can suppress
> the audit messages via auditdeny rule, as mentioned by Mark.

yes, for some reason i was thinking that ps would fail. i'll add the
auditdeny rules.

>> i'd be happy to share the changed/new policy files when i
>> have them working (or earlier if anybody so desires).
>
> Yes, please do.  But I don't want to grant the ipsec_t domain execute
> access to any other types in the example policy.

i'll work on refining what i have to reflect a division between things
that actually need to access the PF_KEY socket and those things
that don't need direct access to the socket.

-paul


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
