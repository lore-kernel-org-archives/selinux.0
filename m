MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Attaching multiple user accounts to same home directory...
Date: Thu, 17 Jul 2008 15:20:46 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D04BAFAC2@de01exm68.ds.mot.com>
In-Reply-To: <487F9610.6010104@redhat.com>
References: <4c63b15c0807151517t5c126030q1d80a5c4c4685a4b@mail.gmail.com> <1216209375.17602.77.camel@moss-spartans.epoch.ncsc.mil> <dd18b0c30807160803q7b34551cl567cf9d787db75e8@mail.gmail.com> <1216221492.17602.131.camel@moss-spartans.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D04BAFA1E@de01exm68.ds.mot.com> <487F9610.6010104@redhat.com>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Dan,

I am using Standard Linux 2.6.14.

In case you need this info, the SELinux related packages I am using are:

checkpolicy     1.34.1
libselinux      1.34.7
libsemanage     1.10.3
libsepol        1.16.1
policycoreutils 1.34.6

- Rezaul.


-----Original Message-----
From: Daniel J Walsh [mailto:dwalsh@redhat.com] 
Sent: Thursday, July 17, 2008 1:57 PM
To: Hasan Rezaul-CHR010
Cc: Stephen Smalley; selinux@tycho.nsa.gov
Subject: Re: Attaching multiple user accounts to same home directory...

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hasan Rezaul-CHR010 wrote:
> Hi All,
> 
> Suppose I wanted to have several Linux User Accounts tied to the same 
> Home Directory, by executing the following:
> 
> useradd -g wadm -d /home/admin admin1
> useradd -g wadm -d /home/admin admin2
> 
> And I wanted all these Linux Users to be tied to the same SELinux user
> (staff_u) as follows:
> 
> semanage login -a -s staff_u admin1
> semanage login -a -s staff_u admin2
> 
> Does SELinux allow this per design ???
> 
> Currently I am getting the following errors on my console, which 
> somewhat makes sense, considering this is NOT standard practise!
> 
> 
> /etc/selinux/strict/contexts/files/file_contexts: Multiple same 
> specifications for /home/admin/.+.
> /etc/selinux/strict/contexts/files/file_contexts: Multiple same 
> specifications for /home/admin/.*/plugins/nprhapengine\.so.*.
> /etc/selinux/strict/contexts/files/file_contexts: Multiple same 
> specifications for /home/admin/.*/plugins/libflashplayer\.so.*.
> /etc/selinux/strict/contexts/files/file_contexts: Multiple same 
> specifications for /home/admin/\.ssh(/.*)?.
> /etc/selinux/strict/contexts/files/file_contexts: Multiple same 
> specifications for /home/admin/\.xauth.*.
> /etc/selinux/strict/contexts/files/file_contexts: Multiple same 
> specifications for /home/admin/\.gnupg(/.+)?.
> /etc/selinux/strict/contexts/files/file_contexts: Multiple same 
> specifications for /home/admin/\.fonts(/.*)?.
> /etc/selinux/strict/contexts/files/file_contexts: Multiple same 
> specifications for /home/admin/\.gconf(d)?(/.*)?.
> /etc/selinux/strict/contexts/files/file_contexts: Multiple same 
> specifications for 
> /home/admin/\.mozilla(/.*)?/plugins/libflashplayer\.so.*.
> /etc/selinux/strict/contexts/files/file_contexts: Multiple same 
> specifications for /home/admin/\.Xauthority.*.
> /etc/selinux/strict/contexts/files/file_contexts: Multiple same 
> specifications for /home/admin/\.fonts/auto(/.*)?.
> /etc/selinux/strict/contexts/files/file_contexts: Multiple same 
> specifications for /home/admin/\.config/gtk-.*.
> /etc/selinux/strict/contexts/files/file_contexts: Multiple same 
> specifications for /home/admin/\.fonts\.cache-.*.
> /etc/selinux/strict/contexts/files/file_contexts: Multiple same 
> specifications for /home/admin/\.ICEauthority.*.
> Inserting powerspanii.ko:
> /etc/selinux/strict/contexts/files/file_contexts: Multiple same 
> specifications for /home/admin.
> /etc/selinux/strict/contexts/files/file_contexts: Multiple same 
> specifications for /home/admin/\.fonts\.conf.
> 
> 
> I was wondering if there is any way I can tweak SELinux config or 
> policy to allow  multiple Linux users to share the same home 
> directory...without generating all these complaints ?  Thanks in 
> advance for your help  :-)
> 
> - Rezaul.
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing
list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without
quotes as the message.
I think you have confused the tool.  What OS are you doing this on?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkh/lhAACgkQrlYvE4MpobNVggCeMLFXrNd5m+I9HEYn8qGJifgD
+GEAn3jcHDwH2RSQx3NDNgiFYqz8+xev
=4Jln
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
