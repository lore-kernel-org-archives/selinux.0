Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA16554
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2001 16:25:02 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA25180
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2001 21:25:01 GMT
Received: from khaipur.xiat.org ([66.125.68.98])
	by jazzswing.ncsc.mil  with ESMTP id VAA25176
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2001 21:25:00 GMT
Date: Fri, 30 Nov 2001 13:06:00 -0800
From: Paul Krumviede <pwk@acm.org>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: RE: use of ps in ipsec shutdown
Message-ID: <145184994.1007125560@localhost>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A101524252@csoc-mail-box.csoconline.com>
References: <72222DC86846D411ABD300A0C9EB08A101524252@csoc-mail-box.csoconli
 ne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--On Friday, 30 November, 2001 14:39 -0600 "Westerman, Mark" 
<Mark.Westerman@csoconline.com> wrote:

> What can try to do is to add
>
> # denials when ps tries to search /proc. Do not audit these denials.
> auditdeny ipsec_t domain:dir ~r_dir_perms;
> auditdent ipsec_t domain:notdevfile_class_set ~r_file_perms;
>
> The rule where modified from the user.te domain.

while this would suppress the warnings, what would happen
if one wanted to restart the ipsec stuff, perhaps because of
a config file change, when in enforcing mode? it would seem
that stopping the service would fail (actually, it would look like
it worked, but because _realsetup wouldn't think that pluto is
running, pluto wouldn't be shut down) and i don't know what
would be the result of the subsequent start.

but i hadn't considered that the reason ps "works" when
run by a user is that the denials may not be audited.

> Mark Westerman.
>
> PS.
> I will have to check my orginal implemtation to see if I experence the
> same behavior

until i made the changes to get the various _plotu* processes running
in a domain other than initrc_t, the only avc denials i saw in the log
were the attempts by whack to connect to the socket created by pluto.

> -----Original Message-----
> From: Paul Krumviede [mailto:pwk@acm.org]
> Sent: Friday, November 30, 2001 12:45 PM
> To: selinux
> Subject: use of ps in ipsec shutdown
>
>
> i've been experimenting with the freeswan-1.91 ipsec implementation
> in some of the more recent selinux releases, including the latest 2.4.14
> one, and, after making some changes to the supplied ipsec policy,
> have come across something i don't yet know how to handle.
>
> i noticed that the supplied policy left some processes in the
> initrc_t domain, such as _plutorun and _plutoload. i also noticed
> that the ipsec startup script invokes logger, and that whack,
> running in the initrc_t domain, was being denied permission
> to connect to the socket set up by pluto. so i labeled the
> /usr/local/sbin/ipsec script, whack, _plutoload, _plutoread
> and whack as ipsec_exec_t types, and allowed ipsec_t
> to execute shells, bin_t and sbin_t things (the latter in part
> because the default label of things in /usr/local/lib/ipsec
> is sbin_t). this seems to have fixed all the things decribed
> above (although i'm open to suggestions as to alternative
> approaches).
>
> i also noticed that _startklips wanted (limited) access
> to /proc/sys/net/ipsec/icmp, so i gave some sysctl
> access.
>
> i later noticed a number of avc denials at shutdown
> when ps, apparently run out of _realsetup, is attempting
> to read some of the process information. for example, i see
>
> avc:  denied  { getattr } for  pid=2358 exe=/bin/ps path=/1 dev=00:03
> ino=65538
>    scontext=system_u:system_r:ipsec_t
>    tcontext=system_u:system_r:init_t
>    tclass=dir
> avc:  denied  { search } for  pid=2358 exe=/bin/ps path=/1 dev=00:03
> ino=65538
>    scontext=system_u:system_r:ipsec_t
>    tcontext=system_u:system_r:init_t
>    tclass=dir
> avc:  denied  { read } for  pid=2358 exe=/bin/ps path=/1/stat dev=00:03
> ino=65547
>    scontext=system_u:system_r:ipsec_t
>    tcontext=system_u:system_r:init_t
>    tclass=file
>
> and this repeats for a few other processes with different
> tcontexts (e.g., kernel_t and pump_t). running ps (/bin/ps
> and /usr/local/selinux/bin/ps) as a user from a shell doesn't
> have this problem, and i don't understand the the difference.
> before the changes mentioned above, this shutdown behavior
> wasn't happening.
>
> i'd appreciate suggestions as to how to address this behavior
> at shutdown.
>
> i'd be happy to share the changed/new policy files when i
> have them working (or earlier if anybody so desires).
>
> -paul
>
>
> --
> You have received this message because you are subscribed to the selinux
> list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
>



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
