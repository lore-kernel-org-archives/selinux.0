Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB6Eg2Q7007920
	for <selinux@tycho.nsa.gov>; Thu, 6 Dec 2007 09:42:02 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB6Eg14h026869
	for <selinux@tycho.nsa.gov>; Thu, 6 Dec 2007 14:42:01 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lB6Eg1Tv001609
	for <selinux@tycho.nsa.gov>; Thu, 6 Dec 2007 09:42:01 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lB6Eg05S005412
	for <selinux@tycho.nsa.gov>; Thu, 6 Dec 2007 09:42:00 -0500
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.12.32.53])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id lB6Efx6g010091
	for <selinux@tycho.nsa.gov>; Thu, 6 Dec 2007 09:42:00 -0500
Message-ID: <47580A37.4020409@redhat.com>
Date: Thu, 06 Dec 2007 09:41:59 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Boolean/RPM data in policy
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We have been asked to map booleans to RPM's by some customers.  The idea
is to show which booleans effect which packages.

Some booleans would effect multiple packages.

For example

You might want a command to show all booleans that effect the httpd rpm.

In Fedora 8 system-config-selinux/booleans page includes information on
the modules, description and boolean name.  It gives you the ability to
filer and sort on these.   The semanage booleans -l command line also
gives this information.  So you can pipe it to grep to search for
particular booleans.

# semanage boolean -l | grep samba.*export
samba_export_all_rw            -> off   Allow Samba to share any
file/directory read/write
samba_export_all_ro            -> off   Allow Samba to share any
file/directory read only
samba_share_nfs                -> off   Allow samba to export NFS volumes.

But, module names and rpm do not match, and several boolean effect
multiple RPMS.

So it would be nice to have a semanage command that said something like
show me the booleans that effect the httpd package.

One suggestion would be to update the policy xml to include distribution
specific data.



## <desc>
## <p>
## Allow httpd to use built in scripting (usually php)
## </p>
## <Packages>
## <RedHat>
## <package>httpd</package>
## </RedHat>
## </Package>
## </desc>
gen_tunable(httpd_builtin_scripting,false

Then semanage and system-config-selinux could use this data.  Another
solution would be to allow vendors to ship a look aside database with
this info in it.

The problem with either solution is that the data will get out of date
quickly.  For example lots of RPMS are effected by use_nfs_home_dirs,
every confined domain that needs to access the homedir would use this
boolean.  Or allow_ypbind would effect every domain that calls
auth_use_nsswitch.

So the final solution would be to do nothing, except improve the
documentation on the booleans so a user would be likely to figure out
one to solve his problem

spamassassin is failing with nfs homedirs?
# semanage boolean -l | grep nfs
# semanage boolean -l | grep nfs | grep spam
<No Output>
#semanage boolean -l | grep nfs
xen_use_nfs                    -> off   Allow xen to manage nfs files
use_nfs_home_dirs              -> on    Support NFS home directories
allow_ftpd_use_nfs             -> off   Allow ftp servers to use nfs
used for public file transfer services.
cdrecord_read_content          -> off   Allow cdrecord to read various
content. nfs, samba, removable devices, user temp and untrusted content
files
httpd_use_nfs                  -> off   Allow httpd to access nfs file
systems
samba_share_nfs                -> off   Allow samba to export NFS volumes.
allow_nfsd_anon_write          -> off   Allow nfs servers to modify
public files used for public file transfer services. Files/Directories
must be labeled public_content_rw_t
nfs_export_all_rw              -> off   Allow any files/directories to
be exported read/write via NFS.
nfs_export_all_ro              -> on    Allow any files/directories to
be exported read/only via NFS.


Ahh, I wonder if use_nfs_home_dirs would make it work...


So what do others think?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHWAo3rlYvE4MpobMRAs/ZAJ9DjIKI9siNxi3y87TLNvGnJjb+2ACfXwVF
hmUNcDyCWgUOXozalbKQFYI=
=HCRY
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
