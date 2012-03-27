Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RIaGQk009735
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 14:36:16 -0400
Message-ID: <4F720898.2090505@redhat.com>
Date: Tue, 27 Mar 2012 14:36:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH 34/73] libselinux: Update Makefiles to handle /usrmove
References: <4F71DAAB.8030100@redhat.com> <20120327180710.GB1468@siphos.be>
In-Reply-To: <20120327180710.GB1468@siphos.be>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/27/2012 02:07 PM, Sven Vermeulen wrote:
> On Tue, Mar 27, 2012 at 11:20:11AM -0400, Daniel J Walsh wrote:
>> Move everything into /usr/* and just put links from /*.  The whole /usr thing hasn't really worked in all situations for a long long time.  Just accept that fact and move along.
> 
> Actually, I still have a separate /usr (on mdadm raid with lvm)  with no initramfs (yet, going to move towards one soon given the recent udev releases) and the services that got loaded before my /usr was mounted all run just fine.
> 
> Is this a needed patch, or just something to end possible future discussions?
> 
> Wkr, Sven Vermeulen
> 
> -- This message was distributed to subscribers of the selinux mailing list. If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes as the message.
I think you should still be able to override the location of the binaries, by passing options to make.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9yCJgACgkQrlYvE4MpobMnCgCg4pXwpjJx/+GHtkB3vTYQtr/O
+ocAnRXJ4Ly8aGGT9DNTKPU/uNTREvKV
=TpHf
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
