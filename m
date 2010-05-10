Message-ID: <4BE814C2.5000406@redhat.com>
Date: Mon, 10 May 2010 10:14:26 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: fred.schnittke@vpcl.on.ca
CC: SELinux@tycho.nsa.gov
Subject: Re: Selinux and Apache in chroot question....
References: <OF4B777D47.6A3F031D-ON8525771C.00694668-8525771C.0070353C@vpcl.on.ca>
In-Reply-To: <OF4B777D47.6A3F031D-ON8525771C.00694668-8525771C.0070353C@vpcl.on.ca>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/07/2010 04:25 PM, fred.schnittke@vpcl.on.ca wrote:
> Hi:
> 
> Not sure if this is the right place to post a question like this, but I'll 
> give it a shot.
> 
> I've been following the "Guide to the Secure Configuration of Red Hat 
> Enterprise Linux 5" (which has been a great resource) in setting up our 
> new server. However I ran into problems chrooting, apache, php and mysql. 
> So it was suggested to remove the applications and compile from source. 
> After that was done, I moved the three applications to my chroot, and with 
> a bit of effort, it all works. The only thing is, I don't think SELINUX is 
> monitoring any of the files in the chroot. For instance, it still thinks 
> the web directory is in /var/www/ instead of /chroot/httpd/usr/local/www.
> 
> When I run the following command: 
> 
> ps -eZ | egrep "initrc" | egrep -vw "tr|ps|egrep|bash|awk" | tr ':' ' ' | 
> awk '{ print $NF }'
> 
> I get this output:
> 
> mysqld
> httpd
> httpd
> httpd
> httpd
> httpd
> httpd
> httpd
> httpd
>  
> So my question is:
> 
> Is there a (an easy) way to confine these daemons?
> 
>  
> Regards, 
>  
>  
> Fred Schnittke  MCSE, MCP,
> Network Engineer
> VETERINARY PURCHASING company limited

Yes, you need to make sure the labeling is correct.

semanage fcontext -a -t httpd_exec_t PATHINCHROOT/httpd
semanage fcontext -a -t mysqld_exec_t PATHINCHROOT/mysqld

You also need to do this for the data in the chroot.

semanage fcontext -a -t httpd_sys_content_t PATHINCHROOTAPACHECONTENT


Once you have all the labeling of the chroot setup you can run
restorecon on it to put the labels on disk.

restorecon -R -v PATHTOCHROOT
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvoFMIACgkQrlYvE4MpobMnCgCgpUA1rZwHguSD3zC4WXJBMbbK
dKAAnRbj+rjJ/bLp8nQOE6vkgxWBXQXR
=GYfA
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
