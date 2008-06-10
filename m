Subject: Re: avc_* functions not in libselinux-python
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <cadfc0e40804091330t6ff1aadbned7d5fbc1479fdf5@mail.gmail.com>
References: <cadfc0e40804081502j335cbc4au8d32d4d5fd956c8c@mail.gmail.com>
	 <1207762256.21223.489.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40804091330t6ff1aadbned7d5fbc1479fdf5@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 10 Jun 2008 09:49:47 -0400
Message-Id: <1213105787.30576.103.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-04-09 at 15:30 -0500, Xavier Toth wrote:
> For now I don't think that's a problem as I was looking at using
> avc_has_perm and the context to sid conversion function.

What's the status on this?  I see patches in the Fedora libselinux
package to add the AVC interfaces to the swig bindings, but they aren't
upstream.  Do they work as expected?  Should they be upstreamed?

> 
> On Wed, Apr 9, 2008 at 12:30 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >
> >  On Tue, 2008-04-08 at 17:02 -0500, Xavier Toth wrote:
> >  > Can these functions get swig'd and their wrappers built into _selinux.so?
> >
> >  Patches accepted.
> >
> >  One possible issue here is function pointer callbacks, which is a more
> >  general problem than just the avc interfaces in libselinux.  But if you
> >  are ok with the default callbacks, I suppose there is no problem there.
> >
> >  --
> >  Stephen Smalley
> >  National Security Agency
> >
> >
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
