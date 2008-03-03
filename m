Message-ID: <47CC6FF7.7010409@redhat.com>
Date: Mon, 03 Mar 2008 16:39:03 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Ok I am trying to build interfaces using X Controls.
References: <47CC6061.6090707@redhat.com>
In-Reply-To: <47CC6061.6090707@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Daniel J Walsh wrote:
> What are these doing?  Why do I need these?
> 
> type_transition $2_t default_xproperty_t:x_property
> 	$2_default_xproperty_t;
> 
> 	type_transition $2_t property_xevent_t:x_event $2_property_xevent_t;
> 	type_transition $2_t focus_xevent_t:x_event $2_focus_xevent_t;
> 	type_transition $2_t manage_xevent_t:x_event $2_manage_xevent_t;
> 	type_transition $2_t default_xevent_t:x_event $2_default_xevent_t;
>
Looking at this further, I think these should be classes.

allow staff_t self:property_xevent_t send;

Have all xevent with the same class is similar to having  blk_file,
chr_file, sock_file all class file and defining transitions.

> 
> I want to refer to all of the XClass via the main type.
> 
> Lets take an example.
> 
> I write policy for all X Apps that staff_t runs without a transition to
> stay staff_t.
> 
> Now I write a transition rule for staff_mozilla_t.
> 
> So I want to say something like
> 
> xserver_paste_pattern(staff_mozilla_t, staff_t)
> 
> I would like to then write something like
> 
> allow staff_mozilla_t staff_t:x_property read;
> 
> But you make me write.
> 
> allow staff_mozilla_t staff_default_x_property_t:x_property read;
> 
> Which screws up the interface and I end up having to pass around staff
> and staff_mozilla.
> 
> Is this necessary?
> 
> Is this legal?
> 	type_transition $2_t input_xevent_t:x_event $2_t;
> 
> Or is it even necessary?
> 
> I really want to build an interface that says
> 
> xserver_application(staff, staff_t)
> 
> xserver_application(staff, staff_mozilla_t)
> 
> Then define any interactions between staff_t and staff_mozilla_t via
> simple interfaces.
> 
> Does any of this make sense?
> 
> Dan
> 

- --
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfMb/YACgkQrlYvE4MpobN5twCfTyFOeCXWd7leygMfHwSVuuy5
AGIAnRihufoJhKeFviQ94ETgEy9a3PtR
=JRVb
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
