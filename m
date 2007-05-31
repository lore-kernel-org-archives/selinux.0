Subject: Re: pipefs issue
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov,
        "Jensen, Curtis R (US SSA)" <curtis.jensen@baesystems.com>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD01DBEF78@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD01DBEF78@blums0008.bluelnk.net>
Content-Type: text/plain
Date: Thu, 31 May 2007 10:25:45 -0400
Message-Id: <1180621545.3340.247.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 18:23 -0700, Clarkson, Mike R (US SSA) wrote:
> I've got a java process running in the datalabeler_t domain at the s2
> mls level, which kicks off a c++ executable in the import_t domain. 
> 
> There appears to be some inter-process communication being set up using
> pipefs between the parent and child process which is causing mls
> constraint issues. I'm not familiar with pipefs and I'm not explicitly
> creating this communication, either linux or java is implicitly creating
> it for me.

That is just a pipe between the parent and child, likely to feed input
to the child and/or to collect the output of the child.

> Is this configurable so that I can prevent the pipefs from being
> created?
> 
> Alternatively, can I satisfy the below AVC denial messages without
> giving the import_t domain mlsfilereadup privilege? I don't mind giving
> the datalabeler_t domain extra privileges like writedown or readup, but
> I don't want to give the import_t domain those kind of mls privileges.
> 
> type=AVC msg=audit(1180552217.128:260021): avc:  denied  { read } for
> pid=2585 comm="SimulatedImport" name="[4155253]" dev=pipefs ino=4155253
> scontext=m2_u:system_r:import_t:s1
> tcontext=m2_u:system_r:datalabeler_t:s2-s15:c0.c255 tclass=fifo_file
> 
> type=AVC msg=audit(1180552217.128:260021): avc:  denied  { write } for
> pid=2585 comm="SimulatedImport" name="[4155252]" dev=pipefs ino=4155252
> scontext=m2_u:system_r:import_t:s1
> tcontext=m2_u:system_r:datalabeler_t:s2-s15:c0.c255 tclass=fifo_file
> 
> type=AVC msg=audit(1180552217.128:260021): avc:  denied  { write } for
> pid=2585 comm="SimulatedImport" name="[4155254]" dev=pipefs ino=4155254
> scontext=m2_u:system_r:import_t:s1
> tcontext=m2_u:system_r:datalabeler_t:s2-s15:c0.c255 tclass=fifo_file

I assume you are using some interface to spawn the child, and that
interface includes the creation of a pipe for the parent-child
communication.  Are you sure you don't need that communication to
provide input to the child or to collect the output of it?  If so, then
use a different interface, or dontaudit the denial.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
