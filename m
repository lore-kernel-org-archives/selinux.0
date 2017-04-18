Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3IDQrgk029755
 for <selinux@tycho.nsa.gov>; Tue, 18 Apr 2017 09:26:53 -0400
Received: by mail-oi0-f46.google.com with SMTP id x184so88788969oia.1
 for <selinux@tycho.nsa.gov>; Tue, 18 Apr 2017 06:26:51 -0700 (PDT)
Received: from ian.penurio.us (cpe-70-119-136-2.tx.res.rr.com. [70.119.136.2])
 by smtp.gmail.com with ESMTPSA id
 j64sm6131212oih.39.2017.04.18.06.26.50 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Apr 2017 06:26:50 -0700 (PDT)
Subject: Re: Cannot write policy to allow { relabelto }
To: selinux@tycho.nsa.gov
References: <31ef73c8-592e-8d94-be8d-9630c4c33023@gmail.com>
 <20170418061509.GA26339@markus>
 <3255746b-643f-4b2f-3629-1afab5fe974d@gmail.com>
 <20170418121016.GE26339@markus>
From: Ian Pilcher <arequipeno@gmail.com>
Message-ID: <0f391c3b-bf00-1ba2-8983-3df0fca6c7bf@gmail.com>
Date: Tue, 18 Apr 2017 08:26:50 -0500
MIME-Version: 1.0
In-Reply-To: <20170418121016.GE26339@markus>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/18/2017 07:10 AM, Dominick Grift wrote:
> where are you copying that object to? There should be no content with
> type "cert_t" in a user home directory

I'm copying the mod_nss NSS database directory (/etc/httpd/alias).  The
program is intended to update Let's Encrypt certificates in mod_nss.

I've moved the actual mod_nss database into a directory named something
like /etc/httpd/alias-20170218081357 and /etc/httpd/alias is now a
symbolic link to that directory.

My program does this following:

  * Create a new directory with a current timestamp:
    /etc/httpd/alias-20170408143539 for example.

  * Copy the NSS database files (cert8.db, key3.db, and secmod.db) from
    the "old" directory to the new directory.  I can get away with this,
    because mod_nss always opens the database read-only.

  * Open the NSS database in the new directory, delete any existing
    certificates with the matching nickname (hostname), and import the
    new certificate.

  * Recursively copy any other content (files, symlinks, subdirectories)
    from the old directory to the new directory.  This step also copies
    the ownership, permissions, and SELinux context of *all* objects,
    including the NSS database files.  (This is where I hit the relabelto
    denial.)

  * Create a new symbolic link, /etc/httpd/alias.new, that points to the
    new directory.

  * Rename the /etc/httpd/alias.new symbolic link to /etc/httpd/alias.

  * Recursively delete the old directory.

  * Reload (SIGUSR1) httpd, so it will start using the new certificate.
    (Actually, systemd does this in an ExecStartPost.)

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
-------- "I grew up before Mark Zuckerberg invented friendship" --------
========================================================================
