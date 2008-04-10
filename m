Message-ID: <47FE45B8.20909@redhat.com>
Date: Thu, 10 Apr 2008 12:52:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
Subject: Re: copy&paste security_compute_av from python
References: <cadfc0e40803311235h3e3440fbn395dd55b8ab0e534@mail.gmail.com>	 <47F18500.3030201@tycho.nsa.gov>	 <1207050208.5610.104.camel@moss-spartans.epoch.ncsc.mil>	 <47F27C7D.4070203@tycho.nsa.gov> <47F28FEB.9000901@tycho.nsa.gov>	 <cadfc0e40804081150k336ff301i1a382b117a4d44e2@mail.gmail.com>	 <cadfc0e40804081222g6fe8fed0xda16c1923a0ee6fe@mail.gmail.com>	 <47FD0731.2030202@tycho.nsa.gov>	 <1207765707.21223.523.camel@moss-spartans.epoch.ncsc.mil> <cadfc0e40804091304p6812fca9i132c36bb4c49e9b1@mail.gmail.com>
In-Reply-To: <cadfc0e40804091304p6812fca9i132c36bb4c49e9b1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Xavier Toth wrote:
> On Wed, Apr 9, 2008 at 1:28 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>  On Wed, 2008-04-09 at 14:13 -0400, Eamon Walsh wrote:
>>  > Xavier Toth wrote:
>>  > > Also what about the mlsconstrain(s):
>>  > >
>>  > > #
>>  > > # MLS policy for the x_application_data class
>>  > > #
>>  > > mlsconstrain x_application_data { paste_after_confirm }
>>  > >     (( l1 eq l2 ) or
>>  > >      (( t1 == mlsxwinwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
>>  > >      ( t1 == mlsxwinwrite ));
>>  > >
>>  > >
>>  > > ??
>>  > >
>>  >
>>  > I dunno.  Configure to suit your environment.  This is for write-downs,
>>  > correct?  If so then you probably don't want any constraints, since
>>  > regular "paste" should succeed in the write-up case (in which case no
>>  > confirmation is required), and the point of this permission is to allow
>>  > write downs.
>>  >
>>  > >
>>  > > On Tue, Apr 8, 2008 at 1:50 PM, Xavier Toth <txtoth@gmail.com> wrote:
>>  > >
>>  > >> I'd prefer copy instead cut.
>>  > >>
>>  >
>>  > This is fine.
>>  >
>>  > My work on the XCB Python binding is coming along OK.  I see that you
>>  > are working on Python bindings for the userspace AVC.  That's fine, but
>>  > you could probably get away with not using the AVC in the selection
>>  > manager.  You could simply look up the permission and class values in
>>  > /selinux, then use security_compute_create for permission checking.
>>  > Since the selection manager is driven by user clicking, performance
>>  > shouldn't be that big of a deal.
>>
>>  security_compute_av().
>>  But then he loses out on the libselinux infrastructure for things like
>>  permissive mode, mapping the class/perm values internally for him, etc.
>>  I think using the AVC interface is best whenever possible.
>>
>>
> 
> This is what I'd prefer also and I was hoping Dan would add the avc
> header so that the avc interface bindings would get built into
> _selinux.so.
> 
>>  --
>>  Stephen Smalley
>>  National Security Agency
>>
>>
Most of the avc.h will not work without a lot of work.  Which interfaces
do you need?  If the interfaces take a struct, we probably would need to
write a lot of binding code.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkf+RbgACgkQrlYvE4MpobOwlgCggooBGCaUN1IHv54VdDhrYSxe
HokAoMGbjUvRsoFdGVOgVcUkBw0r+6NW
=ssmU
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
