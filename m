Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q9NAvgvp010193
	for <selinux@tycho.nsa.gov>; Tue, 23 Oct 2012 06:57:42 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q9NAvUbZ007917
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 23 Oct 2012 06:57:31 -0400
Received: from [10.11.10.24] (vpn-10-24.rdu.redhat.com [10.11.10.24])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q9NAvS0a022353
	for <selinux@tycho.nsa.gov>; Tue, 23 Oct 2012 06:57:29 -0400
Message-ID: <50867815.3090801@redhat.com>
Date: Tue, 23 Oct 2012 06:57:25 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Fwd: Re: [libvirt] [PATCH] selinux: Don't fail RestoreAll if file
 doesn't have a default label
References: <5085A8E2.3050306@redhat.com>
In-Reply-To: <5085A8E2.3050306@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

libvirt is trying to restore the context of a path back to the default when a
virtual machine completes.   One problem with this is what happens when a
virtual machine is stored in a directory like /mnt.  There is no default to
set the label back to.

I have suggested either they record the old label and restore it back when the
job finishes or the walk the directory tree to set the label to the first
parent directory that has a specified label.


- -------- Original Message --------
Subject: Re: [libvirt] [PATCH] selinux: Don't fail RestoreAll if file doesn't
have a default label
Date: Mon, 22 Oct 2012 16:13:22 -0400
From: Cole Robinson <crobinso@redhat.com>
To: Eric Blake <eblake@redhat.com>
CC: libvirt-list@redhat.com, Daniel J Walsh <dwalsh@redhat.com>

On 10/22/2012 11:51 AM, Eric Blake wrote:
> On 10/21/2012 02:44 PM, Cole Robinson wrote:
>> When restoring selinux labels after a VM is stopped, any non-standard 
>> path that doesn't have a default selinux label causes the process to stop
>> and exit early. This isn't really an error condition IMO.
>> 
>> Of course the selinux API could be erroring for some other reason but
>> hopefully that's rare enough to not need explicit handling.
>> 
>> Common example here is storing disk images in a non-standard location 
>> like under /mnt. --- src/security/security_selinux.c | 4 ++++ 1 file
>> changed, 4 insertions(+)
>> 
>> diff --git a/src/security/security_selinux.c
>> b/src/security/security_selinux.c index eee8d71..7681f1b 100644 ---
>> a/src/security/security_selinux.c +++ b/src/security/security_selinux.c 
>> @@ -936,7 +936,11 @@ virSecuritySELinuxRestoreSecurityFileLabel(const
>> char *path) }
>> 
>> if (getContext(newpath, buf.st_mode, &fcon) < 0) { +        /* Any user
>> created path likely does not have a default label, +         * which
>> makes this an expected non error +         */ VIR_WARN("cannot lookup
>> default selinux label for %s", newpath); +        rc = 0;
> 
> In the case where there is no default label to restore, shouldn't we still
> be removing our sVirt label rather than just ignoring the failure but
> leaving our label intact?
> 

I don't know if we can just 'remove' a label, we have to replace it with a
different label, right? If I create a file under /mnt/foo the catch all label
is unconfined_u:object_r:file_t:s0 but not sure if we can hardcode that.

dwalsh, is there a way to programmatically determine the fallback default label?

- - Cole


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCGeBUACgkQrlYvE4MpobOx1QCfST88YK7i0tjDaAFtzu3gDaQ7
m0UAnRibVhIxIPDMPny+O0TODfuTuh/Z
=ma3d
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
