Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IE2NRb001585
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 10:02:23 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4IE2LAR021287
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 14:02:21 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i4IE2KHn021184 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 14:02:20 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: list of permissions created by allow2audit: what do i do now?
Date: Wed, 19 May 2004 00:01:07 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040518104026.GC24333@lkcl.net>
In-Reply-To: <20040518104026.GC24333@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405190001.07122.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 18 May 2004 20:40, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> for example, with wdm installed, surely these two shouldn't be
> missed, along with the other wdm_config ones?
>
> 	allow initrc_t xdm_rw_etc_t:dir { add_name remove_name write };
> 	allow initrc_t xdm_rw_etc_t:file { create ioctl rename unlink write };
>
> i mean, i see in domains/programs/xdm.te that there _are_
> allow initrc_t xdm_rw_etc_t permissions for create (create_file_perms)
> and also a comment that init scripts want to check for update
> windowmanagerlist so they get getattr and read allowed.

xdm_t is allowed to create files but initrc_t is only allowed to read them.

It seems that wdm has an perl script used as part of it's startup to create a 
new config file.  I guess that we have to grant initrc_t write access to the 
file for that.  :(

As for the other stuff, some of it should be fixed in later policy versions.  
I'm doing a merge of the latest stuff now and should have a new tree 
available soon.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
