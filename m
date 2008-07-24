Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6OKk5gL026300
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 16:46:06 -0400
Received: from mail.wrs.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6OKk4le001451
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 20:46:04 GMT
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m6OKk3QM022060
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 13:46:03 -0700 (PDT)
Message-ID: <4888E754.9030504@windriver.com>
Date: Thu, 24 Jul 2008 16:34:28 -0400
From: Vikram Ambrose <Vikram.Ambrose@windriver.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: libsepol.context_from_record: MLS is disabled, but MLS context "s0"
 found
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I keep getting this error with audit2why.

root@localhost:/root> cat msg
type=1400 audit(1216736766.147:35): avc:  denied  { read write } for  
pid=1829 comm="modprobe" name="console" dev=sda ino=344069 
scontext=system_u:system_r:insmod_t 
tcontext=unconfined_u:object_r:default_t tclass=chr_file

root@localhost:/root> audit2allow < msg
#============= insmod_t ==============
allow insmod_t default_t:chr_file { read write };

root@localhost:/root> audit2why < msg
libsepol.context_from_record: MLS is disabled, but MLS context "s0" found
libsepol.context_from_record: could not create context structure
libsepol.context_from_string: could not create context structure
libsepol.sepol_context_to_sid: could not convert 
system_u:system_r:insmod_t:s0 to sid
Invalid Source Context system_u:system_r:insmod_t:s0

root@localhost:/root>

Using selinux-svn2928 and refpolicy-2744 (standard)


Vikram

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
