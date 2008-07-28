Subject: Re: libsepol.context_from_record: MLS is disabled, but
	MLS	context"s0" found
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vikram Ambrose <Vikram.Ambrose@windriver.com>
Cc: Stephen Smalley <stephen.smalley@gmail.com>,
        Chris PeBenito <pebenito@gentoo.org>,
        Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <488DECEB.1090607@windriver.com>
References: <4888E754.9030504@windriver.com>
	 <1216944435.4931.20.camel@defiant.pebenito.net>
	 <6FE441CD9F0C0C479F2D88F959B015880246B40D@exchange.columbia.tresys.com>
	 <1216997739.5392.14.camel@defiant.pebenito.net>
	 <1216998548.4906.2.camel@defiant.pebenito.net>
	 <1217032502.14295.1.camel@sulphur>  <488DECEB.1090607@windriver.com>
Content-Type: text/plain
Date: Mon, 28 Jul 2008 12:49:57 -0400
Message-Id: <1217263797.20373.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-07-28 at 11:59 -0400, Vikram Ambrose wrote:
> Stephen Smalley wrote:
> > On Fri, 2008-07-25 at 11:09 -0400, Chris PeBenito wrote:
> >   
> >> On Fri, 2008-07-25 at 10:55 -0400, Chris PeBenito wrote:
> >>     
> >>> On Fri, 2008-07-25 at 10:30 -0400, Karl MacMillan wrote:
> >>>       
> >>>>> -----Original Message-----
> >>>>> From: Chris PeBenito [mailto:pebenito@gentoo.org]
> >>>>> Sent: Thursday, July 24, 2008 8:07 PM
> >>>>> To: Vikram Ambrose
> >>>>> Cc: selinux@tycho.nsa.gov; Karl MacMillan
> >>>>> Subject: Re: libsepol.context_from_record: MLS is disabled, but MLS
> >>>>> context"s0" found
> >>>>>
> >>>>> On Thu, 2008-07-24 at 16:34 -0400, Vikram Ambrose wrote:
> >>>>>           
> >>>>>> I keep getting this error with audit2why.
> >>>>>>
> >>>>>> root@localhost:/root> cat msg
> >>>>>> type=1400 audit(1216736766.147:35): avc:  denied  { read write }
> >>>>>>             
> >>>>> for
> >>>>>           
> >>>>>> pid=1829 comm="modprobe" name="console" dev=sda ino=344069
> >>>>>> scontext=system_u:system_r:insmod_t
> >>>>>> tcontext=unconfined_u:object_r:default_t tclass=chr_file
> >>>>>>
> >>>>>> root@localhost:/root> audit2allow < msg #============= insmod_t
> >>>>>> ============== allow insmod_t default_t:chr_file { read write };
> >>>>>>
> >>>>>> root@localhost:/root> audit2why < msg
> >>>>>> libsepol.context_from_record: MLS is disabled, but MLS context "s0"
> >>>>>> found
> >>>>>> libsepol.context_from_record: could not create context structure
> >>>>>> libsepol.context_from_string: could not create context structure
> >>>>>> libsepol.sepol_context_to_sid: could not convert
> >>>>>> system_u:system_r:insmod_t:s0 to sid Invalid Source Context
> >>>>>> system_u:system_r:insmod_t:s0
> >>>>>>             
> >>>>> I ran into this last week.  Sepolgen incorrectly adds the MLS portion
> >>>>> of the context regardless if MLS is enabled or not.  Then when the
> >>>>> tool uses the context, libsepol throws the above errors when MLS is
> >>>>> disabled.
> >>>>> I haven't had a chance to really look at what would be the right way
> >>>>> to fix it, since I'm no python expert.  Karl?
> >>>>>
> >>>>>           
> >>>> Maybe I'm missing something, but from above this looks like an audit2why
> >>>> bug not an sepolgen bug.
> >>>>         
> >>> Perhaps.  I didn't have a change to analyze the problem fully, so I
> >>> don't know if sepolgen is supposed to be informed if this is an MLS
> >>> policy or not, or if sepolgen itself is supposed to figure it out.  In
> >>> the end the offending function is in the SecurityContext class in
> >>> sepolgen:
> >>>
> >>> def to_string(self, default_level="s0"):
> >>>         fields = [self.user, self.role, self.type]
> >>>         if self.level == "":
> >>>             if default_level != "":
> >>>                 fields.append(default_level)
> >>>         else:
> >>>             fields.append(self.level)
> >>>         return ":".join(fields)
> >>>       
> >> To be clear, I couldn't find any example of default_level being set to
> >> anything when to_string() is called, so in the end it gets a level no
> >> matter what.
> >>     
> >
> > Right - it shouldn't do that if is_selinux_mls_enabled() <= 0.
> > I think this is a result of the audit2allow / audit2why integration;
> > previously, audit2why was directly consuming audit messages but now it
> > is leveraging sepolgen.
> >
> >   
> Is there a temporary work around for this? audit2* is basically the only 
> debug tools available for selinux n00bs.

I would think that you could just change default_level="" in the
to_string definition in class SecurityContext in refpolicy.py.  Or make
it dynamically determine it based on is_selinux_mls_enabled().

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
