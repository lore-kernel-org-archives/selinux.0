Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6SL5KgA025193
	for <selinux@tycho.nsa.gov>; Thu, 28 Jul 2005 17:05:20 -0400 (EDT)
Received: from mail22-haw-R.bigfish.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6SKwccq014348
	for <selinux@tycho.nsa.gov>; Thu, 28 Jul 2005 20:58:38 GMT
Message-ID: <42E946ED.2050705@unify.com>
Date: Thu, 28 Jul 2005 13:58:21 -0700
From: Ron Kuris <rk@unify.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: file context ordering
References: <1122578160.20983.14.camel@sgc.columbia.tresys.com>
In-Reply-To: <1122578160.20983.14.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

My suggestion:

Use M4 diversions to raise the priority of the more important rules.
M4 will output diverted text at the end of the script, and you can
prioritize each section this way.

This worked perfectly for me when I had a similar problem:

divert(3)
[ insert selinux rules here ]
divert(0)

The rules between the diverts will be output at the end, in order by
the diversion number (in this case, 3).

Ron

Christopher J. PeBenito wrote:

| One of the problems we've come against with reference policy (also
| in loadable modules) is the fact that the file context
| specifications are not ordered correctly, since the system
| file_contexts are taken from the modules and concatenated in an
| arbitrary order.  The matchpathcon code finds a match by going
| through all of the specs, and the last one that is matched is used.
|
|
| There is a little sorting in matchpathcon, to push the specs with
| regular expressions to the top and explicit matches (those without
| regular expressions) to the bottom.  This has worked for the
| current policy since the specs in file_contexts/program/*.fc are
| generally specific matches and types.fc has always been at the top.
| Types.fc has most of the very unspecific regular expressions, and
| is hand ordered. With reference policy, all of these specs are
| split up into their respective modules, so there is no ordering of
| file contexts, except within a module.
|
| To try to fix this we looked for regular expression sorting
| algorithms, but pretty much came up empty.  So we wrote
| support/fc_sort.c to do a stable sort (merge sort) with this
| comparison function:
|
| 1. does one have a meta chars and the other not 2. length of the
| spec up to the first meta char 3. length of the entire spec 4. does
| one have a specific file type (--, -d, etc.) and the other not
|
| This still does not end up being perfect, since we have specs that
| are of about the same specificity, and end up being in a different
| order then the current fc.  For example, these two specs end up
| being in the opposite order that they are in the NSA example
| policy:
|
| /usr(/.*)?/bin(/.*)?        system_u:object_r:bin_t
| /usr(/.*)?/lib(64)?(/.*)?   system_u:object_r:lib_t
|
| So this results in a handful of mislabeled files (think
| /usr/lib/foo/bin/*).
|
| What are your thoughts on how to fix this?
|

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC6UbtVkC/44kdyuYRAjQQAKD9Cyizhuv12Cz91GbckGn0WnoLLgCgqptl
wSTxRNrI9uO/g5Z/FTtM5oY=
=TUVs
-----END PGP SIGNATURE-----



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
