Subject: Re: [uml-devel] 2.6.12-rc6-mm1 patches testing
From: Stephen Smalley <sds@tycho.nsa.gov>
To: antoine <antoine@nagafix.co.uk>
Cc: SELinux <selinux@tycho.nsa.gov>, Blaisorblade <blaisorblade@yahoo.it>
In-Reply-To: <1118340278.10190.112.camel@localhost>
References: <1118280325.10107.124.camel@localhost>
	 <200506091724.50908.blaisorblade@yahoo.it>
	 <1118332604.10190.58.camel@localhost>
	 <200506091920.34246.blaisorblade@yahoo.it>
	 <1118340278.10190.112.camel@localhost>
Content-Type: text/plain
Date: Thu, 09 Jun 2005 15:45:49 -0400
Message-Id: <1118346349.30110.192.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-09 at 19:04 +0100, antoine wrote:
> > UML needs simply to mmap (PROT_EXEC) datas from the /tmp/vm_XXXXXX file to 
> > work, and so it tries doing this very early, to give the user a hint on what 
> > happens. On a fs mounted noexec this is forbidden, so possibly it's forbidden 
> > also by SELinux; however, it would be nicer if SELinux could simply allow 
> > mmap()ing with PROT_EXEC without allowing file execution...; allowing mmap() 
> > does not put a big hole inside protections while allowing file execution 
> > does...means that if the user can supply a program to execute, that program 
> > can be written to mmap() and execute code from /tmp, but at that point the 
> > intruder could simply execute his code.
> 
> Can anyone answer this for us please?
> I am trying to workaround this:
> audit(1117846877.640:0): avc:  denied  { execute } for  pid=29031 comm=um-kernel path=/tmp/vm_file-NnIm5X (deleted) dev=md7 ino=3965039 scontext=root:sysadm_r:um_kernel_t tcontext=root:object_r:um_tmp_t tclass=file
> Without giving uml execute access to its tmp directory.

Possibly the UML folks could elaborate on what UML is trying to do here?
In the long term, I'd advise changing its behavior if possible, as
allowing execution of arbitrary code is obviously undesirable and use
of /tmp will break noexec /tmp mounts as noted above regardless of what
SELinux does.

In the short term, you naturally have the option of adding:
	allow um_kernel_t um_tmp_t:file execute;
to your policy as a workaround.  This shouldn't actually allow direct
execve() of such files, as that would also trigger another check
(execute_no_trans if staying in the same domain or entrypoint
otherwise), but would allow indirect execution via ld.so (if staying in
the same domain).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
