Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1HDQpRb014917
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2004 08:26:51 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1HDQoc3009914
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2004 13:26:50 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i1HDQoR0009911 for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2004 13:26:50 GMT
Subject: Re: setfiles sorting
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <1076745885.13876.12.camel@nexus.verbum.private>
References: <1076745885.13876.12.camel@nexus.verbum.private>
Content-Type: text/plain
Message-Id: <1077024390.16139.29.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 17 Feb 2004 08:26:31 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2004-02-14 at 03:04, Colin Walters wrote:
> Hi,
> 
> I recently upgraded my UML setup to 2.6, and I created a new root
> filesystem using Debian woody and Brian May's "unstable" SELinux
> packages for woody.
> 
> However, even after running 'make relabel', a lot of the file contexts
> were wrong.  For example, /sbin/getty was still sbin_t, even after
> explicitly running setfiles on it.  I verified that the regexp for getty
> came after the generic sbin_t regexp in
> /etc/selinux/file_contexts/file_contexts.
> 
> Staring at the setfiles source code a bit, I came to the conclusion that
> this line was wrong:
> 
> > 	/* Sort the specifications with most general first */
> > 	qsort(spec_arr, nspec, sizeof(struct spec), spec_compare);
> 
> As the libc manual says, qsort is not guaranteed to be a stable sort,
> and it apparently isn't.  So I think what was happening is the getty_t
> rule was being randomly sorted before the generic sbin_t rule.
> 
> I don't see why the specifications should be sorted in that way; we
> should just go by the order in the file_contexts file.  I guess I don't
> understand what the whole bit with looking for metacharacters was trying
> to accomplish in the first place.
> 
> Anyways, applying the attached patch made it work for me.

Hi Colin,

Thanks for reporting this problem.  The original problem that motivated
the addition of this code to setfiles is described at 
http://marc.theaimsgroup.com/?l=selinux&m=104488991028531&w=2, and
http://marc.theaimsgroup.com/?l=selinux&m=104768503417910&w=2.  While we
would prefer to just rely on the specified order, this does not address
ordering issues among the program .fc files, and a specific case where
this was creating a problem was the generic /usr/sbin/in\..*d entry in
inetd.fc vs. specific entries in other program .fc files (e.g. ftpd,
fingerd, etc).  The intent of the change was to simply move exact
specifications to the end of the list so that they are never overridden
by more general regex specifications.  I had advocated computing a
metric of the generality of the pathname regex and ordering based on it,
but that was viewed as problematic.

In any event, the fact that qsort does not guarantee stable ordering for
entries that compare to equal does make it unsuitable for this purpose,
but we still need to address the underlying problem, e.g. we could
simply move the entries to the end directly without relying on qsort.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
