Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6TAWbgA029011
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 06:32:37 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6TAQfC2014713
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 10:26:41 GMT
Message-ID: <42EA046A.1010405@redhat.com>
Date: Fri, 29 Jul 2005 06:26:50 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: file context ordering
References: <1122578160.20983.14.camel@sgc.columbia.tresys.com>
In-Reply-To: <1122578160.20983.14.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:

>One of the problems we've come against with reference policy (also in
>loadable modules) is the fact that the file context specifications are
>not ordered correctly, since the system file_contexts are taken from the
>modules and concatenated in an arbitrary order.  The matchpathcon code
>finds a match by going through all of the specs, and the last one that
>is matched is used.
>
>There is a little sorting in matchpathcon, to push the specs with
>regular expressions to the top and explicit matches (those without
>regular expressions) to the bottom.  This has worked for the current
>policy since the specs in file_contexts/program/*.fc are generally
>specific matches and types.fc has always been at the top.  Types.fc has
>most of the very unspecific regular expressions, and is hand ordered.
>With reference policy, all of these specs are split up into their
>respective modules, so there is no ordering of file contexts, except
>within a module.
>
>To try to fix this we looked for regular expression sorting algorithms,
>but pretty much came up empty.  So we wrote support/fc_sort.c to do a
>stable sort (merge sort) with this comparison function:
>
>1. does one have a meta chars and the other not
>2. length of the spec up to the first meta char
>3. length of the entire spec
>4. does one have a specific file type (--, -d, etc.) and the other not
>
>This still does not end up being perfect, since we have specs that are
>of about the same specificity, and end up being in a different order
>then the current fc.  For example, these two specs end up being in the
>opposite order that they are in the NSA example policy:
>
>/usr(/.*)?/bin(/.*)?        system_u:object_r:bin_t
>/usr(/.*)?/lib(64)?(/.*)?   system_u:object_r:lib_t
>
>  
>
We could add on a case by case basis

/usr(/.*)?/lib(64)?(/.*)?/bin(/.*)?   system_u:object_r:bin_t
Or hard code some hierarchy where bin_t is always after lib_t in this situation.

I would doubt we would have /usr/bin/lib/...



>So this results in a handful of mislabeled files
>(think /usr/lib/foo/bin/*).
>
>What are your thoughts on how to fix this?
>
>  
>


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
