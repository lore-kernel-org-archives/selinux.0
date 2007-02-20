Subject: Re: restorecond matchpathcon patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov, James Athey <jathey@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <20070220165727.62975.qmail@web51509.mail.yahoo.com>
References: <20070220165727.62975.qmail@web51509.mail.yahoo.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 11:59:22 -0500
Message-Id: <1171990762.14363.141.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 08:57 -0800, Steve G wrote:
> >> IOW, this patch cleans up one problem, but I wonder if the underlying
> >> algorithm should be changed to be less of a memory hog.
> >
> >Possibly the FCGlob work will help address that problem.
> 
> Is that restorecond work or libselinux work? The change in algorithm I was
> thinking about was in restorecond. IOW, it could cache the correct context for
> the handful of files it cares about and use matchpathcon only for the paths that
> contain metacharacters. It could monitor for policy reloads and correct its cache
> in that event. For what its doing, it consumes a lot of memory as is.

libselinux work - replacing the use of pathname regexes in the file
contexts configuration with a simpler globbing syntax.  It doesn't
matter how many times restorecond calls matchpathcon (and restorecond is
just passing full pathnames to it, which matchpathcon then matches
against the table of pathname regexes to find the right context); the
issue is the memory consumed by the precompiled regexes loaded from the
file contexts configuration on the very first matchpathcon call.

> >Calling matchpathcon_fini each time will require re-creation of the
> >entire in-memory table from the file contexts configuration on each
> >matchpathcon call, so you are trading off runtime performance for memory
> >here.
> 
> If you want to leave it alone, we should have something like this added to
> restorecond.c:
> 
> @@ -483,6 +483,7 @@ int main(int argc, char **argv)
> 
>         watch_list_free(master_fd);
>         close(master_fd);
> +       matchpathcon_fini();
>         if (pidfile)
>                 unlink(pidfile);
> 
> so that valgrind can spot real memory leaks. Besides matchpathcon, valgrind is
> reporting other memory issues.

Yes, that would be fine.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
