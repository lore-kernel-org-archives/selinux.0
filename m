Message-ID: <465DD820.70005@tycho.nsa.gov>
Date: Wed, 30 May 2007 16:01:36 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
CC: Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux Mail List <selinux@tycho.nsa.gov>,
        KaiGai Kohei <kaigai@kaigai.gr.jp>
Subject: Re: object class discovery userland
References: <1177077717.15762.32.camel@sgc> <4628F05B.7040309@tycho.nsa.gov>	 <4628F20E.2000208@tycho.nsa.gov>  <1177089541.24870.17.camel@sgc>	 <1177338792.24282.16.camel@moss-spartans.epoch.ncsc.mil>	 <6FE441CD9F0C0C479F2D88F959B01588A71927@exchange.columbia.tresys.com>	 <1177340283.24282.24.camel@moss-spartans.epoch.ncsc.mil> <1179929852.10995.51.camel@sgc.columbia.tresys.com> <46548D4E.50000@tycho.nsa.gov> <465623DD.6090304@tycho.nsa.gov> <6FE441CD9F0C0C479F2D88F959B01588BEFF31@exchange.columbia.tresys.com> <465750DF.1050509@tycho.nsa.gov> <465CDF54.9050300@ak.jp.nec.com>
In-Reply-To: <465CDF54.9050300@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
> 
> Eamon,
> 
> At first, I want to confirm whether the new selinux_init() intend to
> place userspace AVC on shared memory segment, or not.
> (SE-PostgreSQL has its userspace avc on shared memory segment.)
> 
> When we put userspace AVC on shared memory segment, following points
> should be paid attention.
> 
> - Locking primitive
>   Several processes can refer the userspace AVC on shmem, so inter-processes
>   locking primitive are necessary.
> 
> - Memory allocation
>   Allocating small memory block on shared memory segment is not simple as
>   malloc(). In SE-PostgreSQL case, a fixed length region is assigned by
>   shared memory management subsystem during process initialization.
> 
>   From same reason, we cannot have a mapping table between security context
>   and SID value on the region managed by libselinux, because the total length
>   of security context is not clear when we call selinux_init().
> 
> IMO, Locking callbacks and an option which enables to place userspace AVC
> on given memory region (including fixed length shmem) are desirable.
> 

I think that because of the heavy customization in the Postgres AVC 
implementation it is best kept outside-of-tree at the current time.

There are other applications that use process pools such as Apache and 
if these become hosts to object managers then it may be useful to 
provide a shared memory option in the libselinux version.  The solution 
would involve a flag to the init function, some method of providing the 
shared memory segment to attach to, and special functionality for the 
"manager" process that will listen on netlink.

However, the Postgres implementation is not fully "shared memory" based. 
  The SID-to-context mapping is kept in a "pg_selinux" database table 
which is not stored in shared memory but rather is mapped from disk 
(correct me if I'm wrong).  In the previous thread, the possibility of 
providing callbacks for doing the SID-to-context mapping was discussed. 
  However IMO if this part of the library has to be outsourced to the 
application then the application might as well do the entire AVC.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
