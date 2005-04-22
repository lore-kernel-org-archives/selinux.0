Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3M8EP7C014338
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 04:14:25 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3M86Trf021763
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2005 08:06:30 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: David Hampton <hampton-rh@rainbolthampton.net>
Subject: Re: Updates to amavisd [patch]
Date: Fri, 22 Apr 2005 18:09:27 +1000
Cc: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <1113514551.6056.38.camel@hampton-pc.rainbolthampton.net>
In-Reply-To: <1113514551.6056.38.camel@hampton-pc.rainbolthampton.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200504221809.30984.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 15 April 2005 07:35, David Hampton <hampton-rh@rainbolthampton.net> 
wrote:
> The attached patch updates the (unused) amavisd policy to work with the
> changes in the FC strict/1.23.10-2 policy.  It also fixes the access
> needed by tmpreaper to delete files from the caught spam/virus
> directory.

+allow initrc_t amavisd_etc_t:file read;
Generally it's a bad idea to grant read access without getattr.

@@ -120,6 +122,6 @@

 # Tmp reaper
 ifdef(`tmpreaper.te', `
-allow tmpreaper_t amavisd_quarantine_t:dir { read search getattr setattr 
unlink
 };
-allow tmpreaper_t amavisd_quarantine_t:file getattr;
+allow tmpreaper_t amavisd_quarantine_t:dir create_dir_perms;
+allow tmpreaper_t amavisd_quarantine_t:file link_file_perms;
 ')

tmpreaper_t shouldn't be creating directories.  For the file access { getattr 
unlink } should be sufficient.

The following should do:
allow tmpreaper_t amavisd_quarantine_t:dir { rw_dir_perms unlink };
allow tmpreaper_t amavisd_quarantine_t:file { getattr unlink };

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
