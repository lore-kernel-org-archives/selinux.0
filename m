Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6JDtZv4018740
	for <selinux@tycho.nsa.gov>; Mon, 19 Jul 2010 09:55:35 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o6JDscUi006114
	for <selinux@tycho.nsa.gov>; Mon, 19 Jul 2010 13:54:38 GMT
Message-ID: <4C445948.5000106@redhat.com>
Date: Mon, 19 Jul 2010 09:55:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: restorecon and chroot
References: <201007151427.01927.russell@coker.com.au> <4C3F107C.10905@redhat.com> <201007171514.16224.russell@coker.com.au>
In-Reply-To: <201007171514.16224.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/17/2010 01:14 AM, Russell Coker wrote:
> On Thu, 15 Jul 2010, Daniel J Walsh <dwalsh@redhat.com> wrote:
>> Why not just use setfiles, since you will need to specify the
>> file_context path anyways?
> 
> setfiles requires that you specify the full path of the file_contexts file, 
> this means that documentation that refers to it has to be distribution 
> specific to a certain extent and it's annoying to use.
> 
> Now if setfiles could default to using the same file_contexts file that 
> restorecon uses then that objection would go away.  Do you think we should 
> change setfiles in such a manner?
> 
Ok, so you want restorecon to use an alternate root dir.  I
misunderstood.  The reason I originally wrote restorecon was I got sick
of specifying the path.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxEWUgACgkQrlYvE4MpobN69gCgxJpwK5FMgbc58v5pcVOjL91E
0zcAnAroL61TitjY3WvBCHotKdE5Oq6a
=Qi/5
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
