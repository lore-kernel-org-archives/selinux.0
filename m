Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m99BnREv021376
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 07:49:27 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m99BnN1h002810
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 11:49:27 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m99BnF1t024153
	for <selinux@tycho.nsa.gov>; Thu, 9 Oct 2008 07:49:15 -0400
Message-ID: <48EDEFB9.9090702@redhat.com>
Date: Thu, 09 Oct 2008 07:49:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Murray McAllister <mmcallis@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide drafts: Archiving Files with tar/star
References: <48EDAE09.8070903@redhat.com>
In-Reply-To: <48EDAE09.8070903@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Murray McAllister wrote:
> Hi,
> 
> The following are the first few drafts of the "Archiving Files with
> tar/star" sections. Any comments and corrections are appreciated.
> 
> Thanks.
> 
> Archiving Files with tar
> 
> tar does not retain extended attributes by default. Since SELinux
> contexts are stored in extended attributes, contexts can be lost when
> archiving files. Use tar --selinux to create archives that retain contexts.
> 
> The following example demonstrates creating a Tar archive that retains
> SELinux contexts:
> 
> 1. As the Linux root user, run the touch /var/www/html/file{1,2,3}
> command to create three files (file1, file2, and file3). These files
> inherit the httpd_sys_content_t type from the /var/www/html/ directory:
> 
> [example output from ls -Z /var/www/html/]
> 
> 2. Run the cd /var/www/html/ command to change into the /var/www/html/
> directory. Once in this directory, as the Linux root user, run the tar
> --selinux -cf test.tar file{1,2,3} command to create a Tar archive named
> test.tar.
> 
> 3. As the Linux root user, run the mkdir /test command to create a new
> directory, and then, run the chmod 777 /test/ command to allow all users
> full-access to the /test/ directory.
> 
> # I don't know if this is a bad idea. I thought it would prevent running
> all steps as root (I used /var/www/html/ to 'simulate' real world,
> instead of using home directory).
> 
> 4. Run the cp /var/www/html/test.tar /test/ command to copy the test.tar
> file in to the /test/ directory.
> 
> 5. Run the cd /test/ command to change into the /test/ directory. Once
> in this directory, run the tar -xf test.tar command to extract the Tar
> archive.
> 
> 6. Run the ls -lZ /test/ command to view the SELinux contexts. The
> httpd_sys_content_t type has been retained, rather than being changed to
> default_t, which would have happened had the --selinux not been used:
> 
> [example output from ls -Z /test/]
> 
> 7. If the /test/ directory is no longer required, as the Linux root
> user, run the  rm -ri /test/ command to remove it, as well as all files
> in it.
> 
> Refer to the tar(1) manual page for further information about tar, such
> as the --xattrs option that retains all extended attributes.
> 
> The following section is the same example, but uses "star -xattr
> -H=exustar" instead of tar --selinux.
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
The only point I often bring up is if you have a tar file without
extended attributes, or want the extended attributes to match the policy
of the destination machine, you should run it through restorecon.


tar xvf file.tgz | restorecon -f -

Would reset the file context on disk after the extraction.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjt77kACgkQrlYvE4MpobP9FQCffl1FbiIlxnnkPhQ9i5tqdHVQ
2xcAmQHjfItzd0pmno9j74wqmVRDHXMy
=p+Qj
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
