Subject: Re: [RFC] [Patch 4/4] integrity: SELinux LIM calls
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, zohar@us.ibm.com, safford@watson.ibm.com,
        sailer@us.ibm.com
In-Reply-To: <1190386080.17518.48.camel@moss-spartans.epoch.ncsc.mil>
References: <1190383522.11091.31.camel@localhost.localdomain>
	 <1190386080.17518.48.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 24 Sep 2007 15:54:12 -0400
Message-Id: <1190663652.7371.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-09-21 at 10:48 -0400, Stephen Smalley wrote:
On Fri, 2007-09-21 at 10:05 -0400, Mimi Zohar wrote:
> > [RFC]integrity: SELinux patch
> > 
> > This patch verifies and measures file integrity, by adding
> > the new Linux Integrity Modules(LIM) API calls to SElinux.
> > 
> > This patch defines a new 'integrity' class with the permission 
> > 'measure'.  Measurement calls are made in selinux_file_mmap(), 
> > selinux_bprm_check_security, and selinux_inode_permission(),
> > based on policy.  (Additional calls might be required.)
> 
> I'd like to see a more detailed description of how this is supposed to
> work in practice, including how one sets up a system that actually uses
> these services, how a real integrity module that does verification and
> measurement would work, an example of how one might apply the
> verification and measurement services usefully, what implications this
> would have for administering the system, software updates, etc.
> 
> Things to consider:
> 1) After further discussion internally, there is some doubt that the
> decision on measurement should be expressed directly in SELinux policy.
> Instead, it has been suggested that there should be a separate integrity
> measurement policy that takes into account the SELinux label as one
> possible input.  In the past, we have suggested separate cryptographic
> usage policies, network usage policies, etc that use MAC information as
> inputs but are separable from the MAC policy.  That would also allow
> greater decomposition between SELinux and the integrity subsystem while
> still allowing the integrity subsystem to leverage properties of the MAC
> policy.

There is a wide spectrum of what to measure, from just executables to
everything read/executed.  Not only the decision of 'what' to measure
has a major impact on system performance, but also 'when' to measure.
In addition, the LIM module needs more information than just the
object's label to make a decision, it needs the LSM module's security
context.

We added the LIM calls to SLIM, IBAC, and Selinux.  All of them measured
executables.  The difference between them was in how they determined
which additional files needed to be measured.  IBAC based this decision
solely on the existence or lack of an extended attribute.  For SLIM,
anything that had the ability to modify the filesystem needed to be
measured, as well as system configuration files.  This was easy to do in
a low-water mark MAC environment. Anything labeled SYSTEM called from a
SYSTEM integrity level was measured. For SELinux, it was based on
SELinux policy.

> 2) The current set of measure calls seems a bit haphazard and doesn't
> give a lot of confidence that the right set of measurements are being
> done, or that they are being done from the right places.  Example:  Why
> measure from both mmap and bprm_check_security?  Did you mean to always
> measure in mmap or only on PROT_EXEC?  

The OS protects executables measured in bprm_check_security() from being
modified.  In addition to executables, libraries and scripts need to be
measured as well, which are not measured in bprm_check_security(), but
are measured in file_mmap().  Code could be added in file_mmap to only
measure those files which haven't already been measured, but the
integrity provider already caches this information, so a call to
integrity_measure() is relatively low overhead.

> Is it useful to measure
> separately from the consumer of the data, as is done in inode_permission
> (open-time check, data may change before use, using policy to make the
> data immutable likely isn't practical in a real system and creates a
> fragile coupling between the access control policy and the measurement
> policy), or should the measurement happen closer to the consumer (which
> in some cases means userspace instrumentation, with its problems of
> trust and scale)?  

Preventing a file from changing once it is open for read, as you said,
is not practical, but we indicate that there is a possible problem in 
the PCR by extending the PCR with a hash of 0xff's, but log it in the 
history as 0x00's.  

The current LSM version of IMA does instrument userspace applications
to add measurements.  Uing the LIM architecture, does not preclude 
doing this as well.  

> What about measuring policy or kernel modules at load
> time?  etc.  Be less concerned about invasiveness than about whether you
> are doing it right. 

As for measuring kernel modules at load time, of course it would be
good.  The current LSM IMA version added code to do just that, but as
the call to integrity_measure() originates with the LSM module, this is
not really a LIM issue. I haven't looked recently, but I'm not aware of
an LSM load_module hook.  If/when there will be an LSM load_module hook,
LSMs could call integrity_measure() from it.

> 3) There is some concern that this kind of static load-time-only
> measurement is too limited, and that any integrity measurement
> architecture that gets integrated upstream should incorporate support
> for a dynamic model as well.

We have in IMA a solid model rooted in hardware, with well understood
properties and protection against real threats. Dynamic measurements
don't (at least yet), have that, and are not something to hold up
LIM/IMA for.

Mimi Zohar


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
