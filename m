Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5ADsVgA018581
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 09:54:32 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5ADkU1O016438
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 13:46:30 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id j5ADlfb5029077
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 09:47:41 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1/Submit) id j5ADlfCn029076
	for selinux@tycho.nsa.gov; Fri, 10 Jun 2005 09:47:41 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j59N1TgA014729
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2005 19:01:30 -0400 (EDT)
Received: from smtp001.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j59MrYFL004100
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2005 22:53:34 GMT
From: Blaisorblade <blaisorblade@yahoo.it>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [uml-devel] 2.6.12-rc6-mm1 patches testing
Date: Fri, 10 Jun 2005 00:57:36 +0200
Cc: antoine <antoine@nagafix.co.uk>, SELinux <selinux@tycho.nsa.gov>
References: <1118280325.10107.124.camel@localhost> <1118340278.10190.112.camel@localhost> <1118346349.30110.192.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1118346349.30110.192.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200506100057.36525.blaisorblade@yahoo.it>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 09 June 2005 21:45, Stephen Smalley wrote:
> On Thu, 2005-06-09 at 19:04 +0100, antoine wrote:
> > > UML needs simply to mmap (PROT_EXEC) datas from the /tmp/vm_XXXXXX file
> > > to work, and so it tries doing this very early, to give the user a hint
> > > on what happens. On a fs mounted noexec this is forbidden, so possibly
> > > it's forbidden also by SELinux; however, it would be nicer if SELinux
> > > could simply allow mmap()ing with PROT_EXEC without allowing file
> > > execution...; allowing mmap() does not put a big hole inside
> > > protections while allowing file execution does...means that if the user
> > > can supply a program to execute, that program can be written to mmap()
> > > and execute code from /tmp, but at that point the intruder could simply
> > > execute his code.
> >
> > Can anyone answer this for us please?
> > I am trying to workaround this:
> > audit(1117846877.640:0): avc:  denied  { execute } for  pid=29031
> > comm=um-kernel path=/tmp/vm_file-NnIm5X (deleted) dev=md7 ino=3965039
> > scontext=root:sysadm_r:um_kernel_t tcontext=root:object_r:um_tmp_t
> > tclass=file Without giving uml execute access to its tmp directory.

> Possibly the UML folks could elaborate on what UML is trying to do here?
> In the long term, I'd advise changing its behavior if possible,

> as 
> allowing execution of arbitrary code is obviously undesirable and use
> of /tmp will break noexec /tmp mounts as noted above regardless of what
> SELinux does.
Yes, I know, we must have a test *against* noexec /tmp, sadly.

However, since UML is a virtual kernel, between its task there is executing 
programs, in the memory of the virtual guest; this memory is represented by a 
host file, because it must be shareable by different threads (each of them 
matches one process/thread executed inside UML; actually there are 
complications but this is the base idea).

A note: this file is later deleted to avoid it being touched by the host; what 
I was thinking was if this could be extended to deleting the directory it's 
in (it could, and this would work); then, maybe the execute permission could 
be given only to the directory, and the creation of such directories could be 
restricted to UML (well, given that you make UML put his files not in /tmp 
but in a reserved place). I.e.:

only the UML "role" (I don't know SELinux so please correct me) can create a 
folder under /chroot/mem; those folders become of a different role
with auto_trans, inside those folders you get execute permission with "allow 
um_kernel_t um_tmp_t:file execute;", and those folders get deleted as soon as 
the file has been created, opened and deleted, so only UML can create an 
mmap'able file; race condition to check here if the attacker creates a file 
while the directory exists but not difficult to solve; I guess this is 
possible with SELinux.

Obviously this requires a bit of hacking to the UML kernel, but is possible; 
the right question is if this is requested.
> In the short term, you naturally have the option of adding:
>       allow um_kernel_t um_tmp_t:file execute;
> to your policy as a workaround.
Yes, Antoine did something such but he was searching a better solution.
> This shouldn't actually allow direct 
> execve() of such files, as that would also trigger another check
> (execute_no_trans if staying in the same domain or entrypoint
> otherwise),
Good...
> but would allow indirect execution via ld.so (if staying in 
> the same domain).
I don't understand the domain concept... however, by "indirect execution" you 
mean simply running /lib/ld.so <fileName>, don't you? In this case, since the 
kernel must just mmap() ld.so and not execve() it, couldn't we deny 
execve("/lib/ld-linux.so") via the checks you mentioned above?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
