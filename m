Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6SJLegA024325
	for <selinux@tycho.nsa.gov>; Thu, 28 Jul 2005 15:21:42 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6SJExcq027218
	for <selinux@tycho.nsa.gov>; Thu, 28 Jul 2005 19:14:59 GMT
Subject: file context ordering
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 28 Jul 2005 15:16:00 -0400
Message-Id: <1122578160.20983.14.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

One of the problems we've come against with reference policy (also in
loadable modules) is the fact that the file context specifications are
not ordered correctly, since the system file_contexts are taken from the
modules and concatenated in an arbitrary order.  The matchpathcon code
finds a match by going through all of the specs, and the last one that
is matched is used.

There is a little sorting in matchpathcon, to push the specs with
regular expressions to the top and explicit matches (those without
regular expressions) to the bottom.  This has worked for the current
policy since the specs in file_contexts/program/*.fc are generally
specific matches and types.fc has always been at the top.  Types.fc has
most of the very unspecific regular expressions, and is hand ordered.
With reference policy, all of these specs are split up into their
respective modules, so there is no ordering of file contexts, except
within a module.

To try to fix this we looked for regular expression sorting algorithms,
but pretty much came up empty.  So we wrote support/fc_sort.c to do a
stable sort (merge sort) with this comparison function:

1. does one have a meta chars and the other not
2. length of the spec up to the first meta char
3. length of the entire spec
4. does one have a specific file type (--, -d, etc.) and the other not

This still does not end up being perfect, since we have specs that are
of about the same specificity, and end up being in a different order
then the current fc.  For example, these two specs end up being in the
opposite order that they are in the NSA example policy:

/usr(/.*)?/bin(/.*)?        system_u:object_r:bin_t
/usr(/.*)?/lib(64)?(/.*)?   system_u:object_r:lib_t

So this results in a handful of mislabeled files
(think /usr/lib/foo/bin/*).

What are your thoughts on how to fix this?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
