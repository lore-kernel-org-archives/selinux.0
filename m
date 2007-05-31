MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: pipefs issue
Date: Thu, 31 May 2007 13:02:29 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD01DBEFD6@blums0008.bluelnk.net>
References: <C2849B7E.223EB%csellers@tresys.com>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: "Chad Sellers" <csellers@tresys.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks for the info on the 3 pipes that Java creates. I had a feeling
that this is what was going on, but I'm still confused on one point. The
c++ executable is not writing anything to stdout or stderr, it writes
it's output to a file. The AVC messages below indicate that the import_t
domain (the c++ executable) is attempting to write to the pipe. Is there
some implicit writing that occurs between the processes?

Also, it looks like SELinux is not allowing me to write up. Is that
standard? The BLP model typically allows writing up. 

The only mls attribute that I've seen that addresses writing up is
mlsfilewritetoclr, which looks like it allows writing to the high end of
a process range. Is that correct?


> -----Original Message-----
> From: Chad Sellers [mailto:csellers@tresys.com]
> Sent: Thursday, May 31, 2007 12:34 PM
> To: Clarkson, Mike R (US SSA); selinux@tycho.nsa.gov
> Cc: Jensen, Curtis R (US SSA)
> Subject: Re: pipefs issue
> 
> On 5/30/07 9:23 PM, "Clarkson, Mike R (US SSA)"
> <mike.clarkson@baesystems.com> wrote:
> 
> > I've got a java process running in the datalabeler_t domain at the
s2
> > mls level, which kicks off a c++ executable in the import_t domain.
> >
> I'm assuming you're using java.lang.Runtime.exec() to kick off your
c++
> process?
> 
> > There appears to be some inter-process communication being set up
using
> > pipefs between the parent and child process which is causing mls
> > constraint issues. I'm not familiar with pipefs and I'm not
explicitly
> > creating this communication, either linux or java is implicitly
creating
> > it for me.
> >
> It's java. Java creates 3 pipes in order to connect to stdin, stdout,
and
> stderr of the child process it creates. It's not an uncommon way of
tring
> to
> control your child's stdin, stdout, and stderr.
> 
> > Is this configurable so that I can prevent the pipefs from being
> > created?
> >
> I don't know of a way to tell java to not do this, but I'm no java
expert.
> 
> > Alternatively, can I satisfy the below AVC denial messages without
> > giving the import_t domain mlsfilereadup privilege? I don't mind
giving
> > the datalabeler_t domain extra privileges like writedown or readup,
but
> > I don't want to give the import_t domain those kind of mls
privileges.
> >
> Unfortunately these pipes will be labeled with the creating processes
> context, so I'm not sure how you could do this. Type Enforcement is
> flexible
> enough to let you grant this for a specific instance, but MLS is more
of
> an
> all-or-nothing model. Perhaps a java wizard has a way to make this not
> happen. Otherwise you could hack around it by putting a trusted
subject in
> the middle (datalabeler exec's trusted_helper at s1 which is granted
> mlsfilereadup which launches import).
> 
> > type=AVC msg=audit(1180552217.128:260021): avc:  denied  { read }
for
> > pid=2585 comm="SimulatedImport" name="[4155253]" dev=pipefs
ino=4155253
> > scontext=m2_u:system_r:import_t:s1
> > tcontext=m2_u:system_r:datalabeler_t:s2-s15:c0.c255 tclass=fifo_file
> >
> > type=AVC msg=audit(1180552217.128:260021): avc:  denied  { write }
for
> > pid=2585 comm="SimulatedImport" name="[4155252]" dev=pipefs
ino=4155252
> > scontext=m2_u:system_r:import_t:s1
> > tcontext=m2_u:system_r:datalabeler_t:s2-s15:c0.c255 tclass=fifo_file
> >
> > type=AVC msg=audit(1180552217.128:260021): avc:  denied  { write }
for
> > pid=2585 comm="SimulatedImport" name="[4155254]" dev=pipefs
ino=4155254
> > scontext=m2_u:system_r:import_t:s1
> > tcontext=m2_u:system_r:datalabeler_t:s2-s15:c0.c255 tclass=fifo_file
> >
> > Thanks
> >
> Hope that helps,
> Chad
> 
> >
> >
> > --
> > This message was distributed to subscribers of the selinux mailing
list.
> > If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov
> with
> > the words "unsubscribe selinux" without quotes as the message.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
