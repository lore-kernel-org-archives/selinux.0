Message-ID: <49874331.2050102@redhat.com>
Date: Mon, 02 Feb 2009 14:02:09 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>,
        selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
Subject: Re: filesystem mount AVC denial
References: <7b4dai$ejec6@dmzms99901.na.baesystems.com> <1233583453.3826.4.camel@localhost.localdomain>
In-Reply-To: <1233583453.3826.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Fri, 2009-01-30 at 15:45 -0800, Clarkson, Mike R (US SSA) wrote:
>> I got the following AVC denial in the audit logs and I'm wondering what
>> would cause this:
>>
>> type=AVC msg=audit(1232734163.528:997720):avc: denied { mount } for
>> pid=28016 comm="find" name="/" dev=0:1c ino=0
>> scontext=root:staff_r:libstart_t:s0-s4:c0.c255
>> tcontext=system_u:object_r:nfs_t:s0 tclass=filesystem
>>
>> The program running in the libstart_t domain is using the "find" cmd,
>> and find is requiring the "mount" permission. Could this be caused by
>> "find" traversing into an automounted (NFS) directory? But in that case
>> I would expect the automount daemon, which is running in the automount_t
>> domain, to do the mounting.
> 
> Could be a nfs submount, triggered upon traversing the boundary?
> 
We had this happen on another bug report, and I think it is just wrong.

Since automounter could mount any file system or any file for that
matter, this means in order to make this work, any confined domain that
could traverse a directory that is automounted could fail with an AVC
like the above.

guest_t cd to /mynfs Would fail????

automount is doing the mount so the kernel should say automount not
libstart_t.

I think this is a bug in the kernel.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkmHQzEACgkQrlYvE4MpobMO3ACfW9FgbwW8kyxyFTmuxP3tQDGn
UBkAn2UvIjC0A+vEo21ZpA/WhjVR8Y7R
=6luP
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
