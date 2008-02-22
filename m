Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1MJFNtt027126
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 14:15:23 -0500
Received: from ns1.a61.nl (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1MJFK29010634
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 19:15:20 GMT
Message-ID: <53615.78.27.17.98.1203707623.squirrel@www.a61.nl>
In-Reply-To: <47BF0230.8010001@redhat.com>
References: <1203628966.3669.820.camel@bluejay.goodinassociates.com>
    <1203690930.2804.33.camel@moss-spartans.epoch.ncsc.mil>
    <1203692165.3669.910.camel@bluejay.goodinassociates.com>
    <1203692479.2804.54.camel@moss-spartans.epoch.ncsc.mil>
    <54715.80.95.164.250.1203694428.squirrel@www.a61.nl>
    <47BF0230.8010001@redhat.com>
Date: Fri, 22 Feb 2008 20:13:43 +0100 (CET)
Subject: Re: Gen_require scoping?
From: selinux@a61.nl
To: "Daniel J Walsh" <dwalsh@redhat.com>
Cc: selinux@a61.nl, selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> selinux@a61.nl wrote:
>> Hi all,
>>
>> we're trying to setup an JBoss-module. As you probably know JBoss needs
>> Java and vice versa.
>>
>> For this we created an .te and if. Part of the .if is an interface to
>> allow writing logfiles. Relevant part:
>> What I am doing wrong here??
>>
>> Cheers,
>>
>> Bart
>>
>>
> No your module needs a te file that defined jboss_log_t, not just the
> interface, and probably need a file context file.
>
> cat jboss.te
>
> type jboss_log_t;
> logging_file_type(jboss_log_t)
>
> cat jboss.fc
> /var/log/jboss.*  gen_context(system_u:object_r:jboss_log_t,s0)
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.8 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>
> iEYEARECAAYFAke/AjAACgkQrlYvE4MpobP52QCgopXRW8J10kAKL3T4XULq077o
> u5QAoNcSqVRUryRI52Vo88qeZY+1V1ip
> =z13R
> -----END PGP SIGNATURE-----
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
>

Hi Daniel,

We (Bart and I) just pasted the relevant part of our module. To be more
complete I pasted the whole module (so the jboss.te, jboss.if and the
jboss.fc) at the following urls:


http://pastebin.ca/914239
http://pastebin.ca/914240
http://pastebin.ca/914243

The only difference I can see in you statement and ours is this:

Our jboss.te:
type jboss_log_t;
logging_log_file(jboss_log_t)

Your jboss.te example:

type jboss_log_t;
logging_file_type(jboss_log_t)

Our jboss.fc:
/var/log/jboss(/.*)?	gen_context(system_u:object_r:jboss_log_t,s0)

Your jboss.fc example:
/var/log/jboss.*  gen_context(system_u:object_r:jboss_log_t,s0)

Is that difference the reason why jboss_log_t isn't available to other
modules?

Cheers,


Ronald


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
