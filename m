Message-Id: <200509202048.j8KKm4Ys001478@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Ivan Gyurdiev'" <ivg2@cornell.edu>,
   "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, <jbrindle@tresys.com>
Subject: RE: [ SEPOL/SEMANAGE ] Boolean record
Date: Tue, 20 Sep 2005 16:48:04 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <43306E1D.2070508@cornell.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Ivan Gyurdiev
> Sent: Tuesday, September 20, 2005 4:16 PM
> To: Stephen Smalley
> Cc: selinux@tycho.nsa.gov; jbrindle@tresys.com
> Subject: Re: [ SEPOL/SEMANAGE ] Boolean record
> 
> 
> >- keep the shared libsepol, and have applications use its interfaces
> >directly.
> >
> To clarify, are you saying that we should have?
> 
> semanage_user_add(semanage_handle_t handle, sepol_user_key_t key,
> sepol_user_t data)
> semanage_user_del(semanage_handle_t handle, sepol_user_key_t key)
> semanage_user_modify(semanage_handle_t handle, sepol_user_t key,
> sepol_user_t data)
> 
> The sepol and semanage functionality is different - it's just the data
> structure that's shared.
> 

I agree that the duplication is strange, but I think that we should move all
of these into libsemanage - I'm looking through them now and I don't see
much reason for them to be in libsepol. This will only manage the files that
store the users, right? Is the only goal a shared parser for the files? Same
thing for ports.

> >That's what makes it seem so pointless.  If the wrap functions weren't
> >inlined and actually added some semantics around the libsepol
> >implementation, then they might make sense
> >
> >
> I don't know - it's just a design thing to allow future change - Joshua?
> I'm not sure if the wrap functions add value, but at least they don't
> cause any harm.
> 
> 

The inlined functions definitely don't make sense - the goals as I see them
are:

1) API/ABI stability
2) The ability to move between straight modules and the policy server.

The inlined functions don't meet this goal and moving things to libsepol
will make 2 impossible.

Karl

------
Karl MacMillan
Tresys Technology
http://www.tresys.com

> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
