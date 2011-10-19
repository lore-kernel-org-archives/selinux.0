Message-ID: <4E9F0BBE.8070105@redhat.com>
Date: Wed, 19 Oct 2011 13:41:18 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        David Windsor <dwindsor@gmail.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: I would like to change the behavior of MCS label creations in
 directory.
References: <4E7B9233.6080609@redhat.com>  <1316723465.2354.6.camel@moss-pluto> <4E7B9B43.9000400@redhat.com>  <1316723821.2354.9.camel@moss-pluto> <1316724121.2354.12.camel@moss-pluto>  <4E7C9F3D.9030704@redhat.com> <1316790421.10259.70.camel@moss-pluto>  <CAEXv5_hX_dG8+YeJPOdxZafxV2Nf2dM=CKpstUf+vzdYaw2TLw@mail.gmail.com> <1317139611.22218.9.camel@moss-pluto> <4E82123C.4070406@redhat.com> <4E985BFB.1000806@redhat.com> <4E9D7267.9060004@tresys.com> <4E9EED35.8070408@manicmethod.com>
In-Reply-To: <4E9EED35.8070408@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/19/2011 11:31 AM, Joshua Brindle wrote:
> Christopher J. PeBenito wrote:
>> On 10/14/11 11:57, Daniel J Walsh wrote:
>>> Eric and I have come up with the following syntax for this
>>> behaviour.
>>> 
>>> default_trans level dir_file_class_set parent;
>> 
>> I think we want this to be "range" instead of "level", since the
>> field is actually a range.
>> 
>>> default_trans user dir_file_class_set process; default_trans
>>> role file parent;
>> 
>> Isn't there a better set of tokens than this?  Why not make it 
>> default_user, default_role, default_type, and default_range?
>> Creating an object doesn't really imply a transition, so "trans"
>> seems misleading.
>> 
> 
> I agree with Chris. This will actually let you make things not 
> transition by default so _trans is misleading. Further, "process" 
> shouldn't be a token since it is an object class (you couldn't
> actually parse policy with Eric's patches could you?). I don't like
> "parent" as a token either, and SELinux doesn't know anything about
> processes and parents anyway. SDS's suggestions a while back are
> more appropriate IMO, since SELinux does know what source and
> target are.
> 
> -- This message was distributed to subscribers of the selinux
> mailing list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
> without quotes as the message.
> 
> 

We can parse and you are allowed to use process in both places.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6fC74ACgkQrlYvE4MpobPZdgCgnc/98H1ZvyOlDvqgQZdJjLkn
KlsAn2RIHOa/tN9qH9mPfbdHoQacetC+
=YPYh
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
