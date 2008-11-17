Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAHEjZBJ014190
	for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2008 09:45:35 -0500
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAHEjY1q028036
	for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2008 14:45:35 GMT
Message-ID: <49218381.4050509@redhat.com>
Date: Mon, 17 Nov 2008 09:45:21 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Sean E. Millichamp" <sean@bruenor.org>
CC: Fedora Selinux Mailing List <fedora-selinux-list@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Handling labeling on filesystems that don't support SELinux
References: <1225998785.3313.5.camel@sewt>
In-Reply-To: <1225998785.3313.5.camel@sewt>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sean E. Millichamp wrote:
> I have been working on SELinux support for Puppet.  One issue that has
> cropped up is the behavior on filesystems which don't support SELinux.
> 
> They all appear to get a default label, some seem to allow changing the
> label (VFAT) in a non-persistent manner, some seem to throw "not
> supported" errors (NFS).
> 
> How can I detect if a file is on a filesystem which supports SELinux
> without trying to update the label?
> 
> The best idea so far as been to parse /proc/mounts and use that to
> determine what type of filesystem a file lives on, then check it against
> a whitelist (which would include ext3, xfs, ?) but it seems like there
> has to be a cleaner/simpler way.
> 
> What I would like would be a "getfilecon" call that returns the real
> label, ignoring any mount-time defaults.
> 
> Any ideas?
> 
> Thanks,
> Sean
> 
> 
> --
> fedora-selinux-list mailing list
> fedora-selinux-list@redhat.com
> https://www.redhat.com/mailman/listinfo/fedora-selinux-list
I have been waiting for some one else to respond to this.  I think this
would be better sent to the nsa selinux list for better discussion.

The problem with your parsing of the /proc/mounts is that it would not
give you an accurate idea of what supports and what does not support
SELinux labeling.  Also this can change over time.

If I mount an ext3 file system with a context mount, then it will no
longer allow you to set the file context.  I think the best idea is just
attempt to assign the context and if it fails, ignore the error.  I
guess you can report it, if in verbose mode as a warning.

Others may have different ideas.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkkhg4EACgkQrlYvE4MpobMPMgCgm+G/Pyrll2CKHUynWftA7Shq
phMAnAwTXQQ+mQH33EjP20o9iM7gaVvE
=eDjj
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
