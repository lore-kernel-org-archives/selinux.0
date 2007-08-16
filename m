MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: confining the unconfined_t domain
Date: Thu, 16 Aug 2007 13:37:08 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD0219DF30@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD0219DEFA@blums0008.bluelnk.net> <1187287622.909.72.camel@moss-spartans.epoch.ncsc.mil>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Thursday, August 16, 2007 11:07 AM
> To: Clarkson, Mike R (US SSA)
> Cc: selinux@tycho.nsa.gov
> Subject: Re: confining the unconfined_t domain
> 
> On Thu, 2007-08-16 at 10:15 -0700, Clarkson, Mike R (US SSA) wrote:
> > I'd like to prevent the unconfined_t domain from executing certain
files
> > associated with domains that I've added. What is the best way to do
> > this?
> >
> > I was trying to track down how the unconfined_t domain is given the
> > executable permissions to all executable files. I assume it is
through
> > the  exec_type attribute somehow. I found the
> > corecmd_exec_all_executables and corecmd_mmap_all_executables
interfaces
> > in corecommands.if, which both give execute privilege to exec_type,
but
> > I don't see these being called from the unconfined module. Can
someone
> > point out how this privilege is provided to the unconfined_t domain?
> 
> Um, unconfined_t is "unconfined".  By definition.
> 
> And removing the ability to execute another program doesn't change
what
> unconfined_t can do (i.e. its actual permissions); it can always
create
> its own copy of the same code and execute it in unconfined_t.
> 
> Use a different domain if you want it to be confined.

I recognize that it would be better to use the strict policy so that we
didn't have an unconfined_t domain, and we plan to switch in the future
before going to operations, but for now we're using the targeted policy
while in a prototype phase with an upcoming demo.

I'd like to be able to demonstrate some of the power of SELinux by
showing that only domains that have been granted permissions have access
to certain files. It kind of defeats the purpose when absolutely anybody
who logs in to the system can execute these files because they log into
the unconfined_t domain. 

I also recognize that removing execute doesn't prevent copying the file
and executing the copy. But if I can eliminate execute permissions of
unconfined_t, I can presumably eliminate all access if I so choose.
Also, in this particular case, the file in question is owned by root
with the setuid bit set, so limiting execute permissions is more
important. When a non-root user copies a file with the setuid bit set,
the copy of the file does not retain the setuid bit.

Unconfined uses the file_type attribute rather than the exec_type
attribute to get execute privilege to all executables (why?). I know
this because I added a neverallow rule (neverallow unconfined_t
my_exec_t:file execute), and then eliminated the call to
domain_entry_file, and I still got a compile error resulting from the
neverallow rule. However, if I remove the call to files_type, then it
compiles fine. This eliminates all access to the file from the
unconfined_t domain. Will there be any bad side effects to eliminating
the file_type attribute to my_exec_t? Is there really no better way to
accomplish this?

Thanks
 
> 
> --
> Stephen Smalley
> National Security Agency




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
