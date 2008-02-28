Subject: Re: Why does checkpolicy need libsepol-static
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1204211581.3206.71.camel@localhost.localdomain>
References: <1204211581.3206.71.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 28 Feb 2008 10:20:39 -0500
Message-Id: <1204212039.31790.119.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-02-28 at 10:13 -0500, Eric Paris wrote:
> I noticed while working on open permissions that checkmodule actually is
> being linked statically to libsepol.a.  Why?  This means that when
> adding a new capability in libsepol we have to recompile checkpolicy.
> Just wondering why we do it this way.
> 
> -Eric 'does not know the toolchain' Paris

libsepol was originally created by taking the guts of checkpolicy and
moving them into a library, to allow reuse by some other programs.
We've created shared library interfaces for it over time to support such
programs, but for programs that are tightly coupled to the core data
structures and logic like checkpolicy and setools, we've kept using the
static library.  We would need to provide an abstraction layer for
everything in libsepol if we wanted to completely use the shared library
for checkpolicy and setools.  policyrep might help there, at least for
modules.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
