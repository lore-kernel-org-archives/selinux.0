Date: Mon, 17 Dec 2001 15:42:11 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: forrest whitcher <fw@fwsystems.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: persistent labelling on afs, jfs, xfs? - also read-only media???
In-Reply-To: <20011217125209.508d4128.fw@fwsystems.com>
Message-ID: <Pine.GSO.4.33.0112171520560.10304-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 17 Dec 2001, forrest whitcher wrote:

> Yes, I understood this, however I can think of a few methods or conventions
> which could be used to handle this:
>
> 1. ensure that all 'secured' clients use the same policy / psid definitions
> to begin.

PSIDs are dynamically allocated on a per-filesystem basis.  The
initial run of 'setfiles' allocates an initial set of PSIDs as needed by
the contexts in the file_contexts configuration, but subsequent file
creations while running SELinux will require the dynamic allocation of new
PSIDs for other security contexts.  If you do a list_sids on a running
SELinux kernel, you'll see far more file security contexts than are
present in the file_contexts configuration.

> 2. in a 'client-read-only' environment (a common use of AFS) write static
> PSID's into the AFS filesystem, to allow type enforcement in that space.

If you are only providing the clients with read-only access, then this is
fine.

> In a general read-write distributed environment If (1) above is established,
> then I think the outstanding problem is what happens if a client *changes*
> the PSID, invalidating the SID's of other clients.

This doesn't deal with the need to synchronize the allocation of new PSIDs
for new files (when no existing SID exists for the desired security
context).  This involves synchronizing updates both to the on-disk mapping
files and the in-memory data structures.

> I haven't tried to create this, however it looks like an iso9660
> CDROM should be able to transport PSID-labelled data between
> SELinux systems. Is this correct?

Possibly.  We haven't tried it.

> Would it make sense to add logic to SELinux (or LSM) to look use a
> digital signature on security label data (...security/*) when
> accessing readonly optical data?

Yes, this would be useful, but it isn't a priority for us right now.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
