Message-ID: <1492703796.669.3.camel@tycho.nsa.gov>
Subject: Re: [PATCH] libsemanage: remove lock files
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.net>, selinux@tycho.nsa.gov
Date: Thu, 20 Apr 2017 11:56:36 -0400
In-Reply-To: <1967496203.202650.1492703110228@pim.register.it>
References: <58517705.198270.1492699110308@pim.register.it>
 <1492703075.669.1.camel@tycho.nsa.gov>
 <1967496203.202650.1492703110228@pim.register.it>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-04-20 at 17:45 +0200, Guido Trentalancia wrote:
> Hello Stephen.
> 
> Usually, when a lock file is released, the corresponding file is
> removed from the filesystem for keeping it clean and tidy.
> 
> I might be wrong... But why not ?
> 
> If nothing is handling the semanage store, then there shouldn't be a
> reason for keeping it locked. The presence of a lock file, usually
> means that the lock is active.

libsemanage doesn't use the lock files that way; it just uses them as
the object for flock() operations.  So the presence of the lock file
means nothing.  Removing it just means it will have to be re-created on
the next operation.  Not fundamentally opposed, but someone would need
to validate that it doesn't cause any issues.  It's been that way
forever.  Maybe the original Tresys authors of this code have an
opinion on it.
