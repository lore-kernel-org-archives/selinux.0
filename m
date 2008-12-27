Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBRBkM2o023910
	for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2008 06:46:22 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mBRBkLZd029995
	for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2008 11:46:21 GMT
Message-ID: <49561584.7020907@redhat.com>
Date: Sat, 27 Dec 2008 06:46:12 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Justin P. Mattock" <justinmattock@gmail.com>
CC: xing li <lixing.1006@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: when and how the selinux label all file system according to "file_contexts"?
References: <707f057d0812270055r153efe73nd5649d3bc0c4fe0c@mail.gmail.com> <4955F335.6030404@gmail.com>
In-Reply-To: <4955F335.6030404@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Justin P. Mattock wrote:
> xing li wrote:
>> I have confused by the question:
>> when and how the selinux label all file system according to
>> "file_contexts"?
>> and i found the clue that when we "touch /.autorelabel",the system
>> would invoke
>> "fixfiles relabel" to relabel the file system. but i could't find the
>> relevant source code.
>> Maybt somebody has investigated that and could share infomation? 
> From what I remember,
> .autorelabel is called by a daemon,
> (selinux-basic package); but am unclear with
> what the name might be with the different distros.
> I normally make policy; make install; make relabel;
> that is if anybody uses the commands "make"
> anymore.
> 
> regards;
> 
> Justin P. Mattock
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
/etc/rc.sysinit includes a line that looks for /.autorelabel and then
executes /sbin/fixfiles restore.

# grep autorelabel /etc/rc.sysinit
 	rm -f  /.autorelabel
 	rm -f  /.autorelabel
    if [ -f /.autorelabel ] || strstr "$cmdline" autorelabel ; then
    if [ -f /.autorelabel ] || strstr "$cmdline" autorelabel ; then
        [ -f /.autorelabel ] || touch /.autorelabel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAklWFYQACgkQrlYvE4MpobM97QCg2mpa8DBMHXbFlJilQUbt/O0F
6oUAn1aU0QcICcEiZ+B7ImIvF6VFP9nI
=h8ji
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
