Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1MJp7d0031314
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 14:51:07 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1MJp6YC022662
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 19:51:06 GMT
Message-ID: <47BF279E.2070501@redhat.com>
Date: Fri, 22 Feb 2008 14:50:54 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: selinux@a61.nl
CC: selinux@tycho.nsa.gov
Subject: Re: Gen_require scoping?
References: <1203628966.3669.820.camel@bluejay.goodinassociates.com>    <1203690930.2804.33.camel@moss-spartans.epoch.ncsc.mil>    <1203692165.3669.910.camel@bluejay.goodinassociates.com>    <1203692479.2804.54.camel@moss-spartans.epoch.ncsc.mil>    <54715.80.95.164.250.1203694428.squirrel@www.a61.nl>    <47BF0230.8010001@redhat.com> <53615.78.27.17.98.1203707623.squirrel@www.a61.nl>
In-Reply-To: <53615.78.27.17.98.1203707623.squirrel@www.a61.nl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

selinux@a61.nl wrote:
> selinux@a61.nl wrote:
>>>> Hi all,
>>>>
>>>> we're trying to setup an JBoss-module. As you probably know JBoss needs
>>>> Java and vice versa.
>>>>
>>>> For this we created an .te and if. Part of the .if is an interface to
>>>> allow writing logfiles. Relevant part:
>>>> What I am doing wrong here??
>>>>
>>>> Cheers,
>>>>
>>>> Bart
>>>>
>>>>
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
>>
- --
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.
>>

> Hi Daniel,

> We (Bart and I) just pasted the relevant part of our module. To be more
> complete I pasted the whole module (so the jboss.te, jboss.if and the
> jboss.fc) at the following urls:


> http://pastebin.ca/914239
> http://pastebin.ca/914240
> http://pastebin.ca/914243

> The only difference I can see in you statement and ours is this:

> Our jboss.te:
> type jboss_log_t;
> logging_log_file(jboss_log_t)

> Your jboss.te example:

> type jboss_log_t;
> logging_file_type(jboss_log_t)

> Our jboss.fc:
> /var/log/jboss(/.*)?	gen_context(system_u:object_r:jboss_log_t,s0)

> Your jboss.fc example:
> /var/log/jboss.*  gen_context(system_u:object_r:jboss_log_t,s0)

> Is that difference the reason why jboss_log_t isn't available to other
> modules?

> Cheers,


> Ronald

logging_log_file
is correct

You should have a files_type

Updated
http://pastebin.ca/914287

Everything else looks ok.  Is jboss running as jboss_t?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAke/J50ACgkQrlYvE4MpobOpBgCaAvbP+/afkqtpt01dD19c42d9
rPMAn3c3rbumQjcbmtriKFzYDXT2utWZ
=KYnl
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
