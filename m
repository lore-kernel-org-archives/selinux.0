Message-ID: <4821E136.7050309@redhat.com>
Date: Wed, 07 May 2008 13:04:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH v4] selinux: support deferred mapping of contexts
References: <1210002195.25678.678.camel@moss-spartans.epoch.ncsc.mil>	 <Xine.LNX.4.64.0805060930520.17367@us.intercode.com.au>	 <1210088427.25678.771.camel@moss-spartans.epoch.ncsc.mil>	 <1210105048.25678.799.camel@moss-spartans.epoch.ncsc.mil>	 <Xine.LNX.4.64.0805070830480.20128@us.intercode.com.au>	 <1210164325.6434.22.camel@moss-spartans.epoch.ncsc.mil>	 <7e0fb38c0805070817h72ac3ce7k24dc38b7eaf0ec24@mail.gmail.com> <1210173806.6434.84.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1210173806.6434.84.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Wed, 2008-05-07 at 11:17 -0400, Eric Paris wrote:
>>>  I assume we do NOT want to use this variant interface when getting
>>>  contexts to display in audit messages, as we want the audit messages to
>>>  correspond to the actual denial and to yield proper policy if turned
>>>  into an allow rule.
>> Is there any way we could get them both displayed if there is a
>> denial?  Might be interesting to know both that the denial was
>> actually unlabeled_t object but also what the 'incorrect' label
>> was.....
> 
> Easy to do kernel-side, but requires a new avc audit field that won't
> cause any complaints by audit userland or tools like audit2allow.
> 
Audit2allow would just ignore it.  It is searching for name value pairs
and drops ones it does not understand.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkgh4TYACgkQrlYvE4MpobPmeQCgqqWyHaFBDiQCjjTj5nTxP3V1
RKoAn0QUac3ZVxhe2vhw0nIWvOscnAGB
=+jxw
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
