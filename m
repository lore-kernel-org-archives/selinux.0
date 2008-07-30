Subject: Re: Should /dev/mem be SystemHigh?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, Joe Nall <joe@nall.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1217419995.20373.217.camel@moss-spartans.epoch.ncsc.mil>
References: <82459273-DA3E-4F80-B1D8-E3A168218B06@nall.com>
	 <488FA642.1030507@tycho.nsa.gov>
	 <1217419995.20373.217.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 30 Jul 2008 09:23:29 -0400
Message-Id: <1217424210.4114.10.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-07-30 at 08:13 -0400, Stephen Smalley wrote:
> On Tue, 2008-07-29 at 19:22 -0400, Eamon Walsh wrote:
> > Joe Nall wrote:
> > > ls -Z /dev/mem
> > > crw-r-----  root kmem system_u:object_r:memory_device_t:SystemHigh / 
> > > dev/mem
> > >
> > > In our MLS X policy, we are giving the X server  
> > > mls_file_read_all_levels and mls_file_write_all_levels to be able to  
> > > access the SystemHigh /dev/mem. I would prefer not to give X general  
> > > file MLS override if possible.
> > >   
> > 
> > The X server is trusted to manage MLS objects internally, so a general 
> > file MLS override doesn't seem to be inappropriate in this case.  But 
> > see below.
> > 
> > > Is there a way to assign MLS read up/write up on just one type (i.e.  
> > > allow X to read up only on memory_device_t)?
> > >   
> > 
> > You could add an exception to the MLS constraints for the "file read" 
> > ops.  This exception would be an "or" clause taking the form (t1 == 
> > xserver_type) and (t2 == memory_device_t).  Steve doesn't think these 
> > kinds of specific exemption are very maintainable, and I would tend to 
> > agree.
> > 
> > Another option could be to split up the "file read" constraint, taking 
> > the chr_file (character device file type) out and adding a separate 
> > override interface just for device files.
> > 
> > > Is there a potential refactoring of the X server that eliminates the  
> > > need for /dev/mem access? Dan hinted at this at the developer summit  
> > > to allow X to run as the user.
> > >   
> > 
> > My understanding of this is that the ability to run the X server as an 
> > unprivileged UID is a long-term goal but not something that's ready just 
> > yet.
> > 
> > > Would it be better to mls_file_write_within_range(memory_device_t)  
> > > (i.e. make it a trusted object) and pull the MLS override out of the X  
> > > policy?
> > >   
> > 
> > I think this may work.  You would be relying on type enforcement alone 
> > to protect /dev/mem in this case, if I understand correctly.
> 
> I think Joe must have meant mls_trusted_object(memory_device_t), as that
> is the interface for marking a file type as being unconstrained by MLS
> restrictions, e.g. for /dev/null.  That would allow any domain to
> read/write /dev/mem without MLS restrictions (but still subject to TE
> policy), which may not be what you want.

I definitely think that we don't want mls_trusted_object().  /dev/mem
should certainly be system high and treated thusly, since by using the
device you gain access to all processes memory, regardless of level.
The TE policy will always be there for integrity sake, but I think we
should protect it in both an integrity and a confidentiality sense.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
