Message-ID: <5343E893.8050705@tycho.nsa.gov>
Date: Tue, 08 Apr 2014 08:16:19 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: The purpose of SID.
References: <5343B5EA.3010909@gmail.com>
In-Reply-To: <5343B5EA.3010909@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/08/2014 04:40 AM, dE wrote:
> As I read in the SELinux docs, each subject and object is assigned a
> unique SID; when using the selinux libraries, or using the SELinux
> kernel API the programs are expected to request the security server
> decisions for a particular subject and object by passing the subject and
> object's SID to the security server.
> 
> Question is -- is SID created when an SELinux enabled kernel boots or
> just when a SELinux enabled program requests an SID for a subject/object
> from the kernel?
> 
> Also can I see a process's and file's SID via some program?

Except for a small set of predefined initial SIDs (used for
bootstrapping before policy is loaded), SIDs are dynamically allocated
on demand for security contexts when they are first used.

The kernel does not expose its SIDs to userspace; all of the userspace
APIs provided by the kernel pass security contexts instead; see:
http://www.nsa.gov/research/_files/selinux/papers/module/x362.shtml

However, libselinux does provide a userspace SID abstraction for users
of the userspace AVC implementation (man avc_context_to_sid).  Those
SIDs are likewise dynamically allocated on demand for security contexts
when they are first used, but are merely local references to the
security context; that mapping is per-process and has no global meaning.
