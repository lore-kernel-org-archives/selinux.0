Subject: Re: [ SEPOL/SEMANAGE ] Boolean record
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   jbrindle@tresys.com
In-Reply-To: <43307A1D.3070806@cornell.edu>
References: <200509202048.j8KKm4Ys001478@gotham.columbia.tresys.com>
	 <43307A1D.3070806@cornell.edu>
Content-Type: text/plain
Date: Wed, 21 Sep 2005 10:21:24 -0400
Message-Id: <1127312484.2550.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-20 at 17:07 -0400, Ivan Gyurdiev wrote:
> No - the semanage functionality is to extract data from a backend or 
> write data to a backend, and to relay the corresponding objects to sepol 
> to load (loading it itself breaks the encapsulation that I've been 
> trying to create for sepol). The sepol functionality will be to actually 
> load the data. Currently we're discussing the same data, hence the 
> shared data structures, without modification. However, I'm not sure 
> whether this will stay like that in the future - maybe we'll decide to 
> store extra data in semanage that doesn't get passed down to the sepol 
> layer. That's why I'm hesitant to use sepol data structures in semanage 
> function headers.

Then I think you need to hide this type aliasing and interface aliasing
within libsemanage, and not make it visible in its public headers.  And
I'm still not clear whether libsemanage should be exporting these
particular interfaces directly to its users, versus higher level
interfaces that are internally implemented in terms of the libsepol
primitives.  Do you expect libsemanage clients to be directly doing
things like semanage_port_compare?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
