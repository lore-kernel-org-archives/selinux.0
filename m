Subject: Re: avc_* functions not in libselinux-python
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ted X Toth <txtoth@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <484E8D3D.9010809@gmail.com>
References: <cadfc0e40804081502j335cbc4au8d32d4d5fd956c8c@mail.gmail.com>
	 <1207762256.21223.489.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40804091330t6ff1aadbned7d5fbc1479fdf5@mail.gmail.com>
	 <1213105787.30576.103.camel@moss-spartans.epoch.ncsc.mil>
	 <484E8D3D.9010809@gmail.com>
Content-Type: text/plain
Date: Tue, 10 Jun 2008 10:28:47 -0400
Message-Id: <1213108127.30576.122.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-06-10 at 09:18 -0500, Ted X Toth wrote:
> Stephen Smalley wrote:
> > On Wed, 2008-04-09 at 15:30 -0500, Xavier Toth wrote:
> >   
> >> For now I don't think that's a problem as I was looking at using
> >> avc_has_perm and the context to sid conversion function.
> >>     
> >
> > What's the status on this?  I see patches in the Fedora libselinux
> > package to add the AVC interfaces to the swig bindings, but they aren't
> > upstream.  Do they work as expected? 
> The interfaces I'm using (avc_open, avc_reset, avc_context_to_sid, 
> avc_has_perm_noaudit) are working as expected.
> 
> >  Should they be upstreamed?
> >
> >   
> I think so.

Ok, can you or Dan split that out and submit it please.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
