Message-ID: <4C489DE9.7060905@redhat.com>
Date: Thu, 22 Jul 2010 15:37:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: This is my first patch for systemd
References: <4C4837F2.1070806@redhat.com>	 <1279808480.11197.28.camel@moss-pluto.epoch.ncsc.mil>	 <4C48687B.1050605@redhat.com> <1279817292.11197.44.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1279817292.11197.44.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/22/2010 12:48 PM, Stephen Smalley wrote:
> On Thu, 2010-07-22 at 11:49 -0400, Daniel J Walsh wrote:
>> Updated with your comments.  Strange the FIFO_FILE did not cause
>> security_compute_create to fail when passing a 0 for the tclass?  I
>> though this should fail.
>>
>> I changed the patch to check the output of string_to_security_class.
>> Will write the selabel patch after this is accepted.
>>
>> Not checking the return of setfscreatecon(NULL) or
>> setsockcreatecon(NULL)  Since I am not sure what to do if these fail and
>> not likely to fail since the previous calls worked.
> 
> Yes, that's fine.
> 
>> Is there any way to see what a socket is labeled?  netstat -aZ is just
>> showing the process context, not the context of the label on the socket?
> 
> netstat should be able to call fgetfilecon() on the socket fd after
> opening the /proc/pid/fd/<n> file to get the socket label.  Not sure why
> it is using getpidcon() on the process instead.  Who wrote that patch?
> 
Probably me 8 years ago...  :^(
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxInekACgkQrlYvE4MpobPtBQCgyetTDlI5j2ZYp9uFItzJtZDR
4zAAoOrSPoHDYrdetSARtOWf3k2PjYgf
=n9Yp
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
