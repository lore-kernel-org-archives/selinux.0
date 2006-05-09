Message-ID: <44608F34.3060907@gentoo.org>
Date: Tue, 09 May 2006 08:46:44 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: restorecond and security related files
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I noticed that /etc/samba/secrets.tdb was added to restorecond.conf. I 
thought that restorecond was only going to be used for files of low 
security relevancy? Are type transitions not sufficient in this case? if 
not smbpasswd should use setfscreatecon() when writing it like passwd 
does. Also, this doesn't seem to keep /etc/samba/smbpasswd correctly 
typed or the /etc/samba/smbpasswd.<pid> temp file created when smbpasswd 
is run.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
