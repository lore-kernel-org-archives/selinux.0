Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA05495
	for <selinux@tycho.nsa.gov>; Fri, 28 Jun 2002 11:16:41 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA23263
	for <selinux@tycho.nsa.gov>; Fri, 28 Jun 2002 15:15:13 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id PAA23259 for <selinux@tycho.nsa.gov>; Fri, 28 Jun 2002 15:15:12 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Ryan Bergauer" <privateryan@mindspring.com>, <selinux@tycho.nsa.gov>
Subject: Re: Configuration issues on a new installation
Date: Fri, 28 Jun 2002 11:12:49 -0400
References: <001c01c21e61$7c297d30$6501a8c0@donkey>
In-Reply-To: <001c01c21e61$7c297d30$6501a8c0@donkey>
MIME-Version: 1.0
Message-Id: <20020628151544.CAB317DA7@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 28 Jun 2002 01:05, Ryan Bergauer wrote:
> On 6/27/02, Russell Coker wrote:
> > nmbd needs UDP, smbd needs TCP.  smbd needs read/write access to all
>
> user
>
> > files, nmbd doesn't.
> >
> > If nmbd has a bug (it's had one before) then you're better off with
> > different domains.
>
> Done. The updated files are attached.

These three are covered by daemon_domain() in my latest global_macros.te 
file, Steve, are you putting them in your tree?
allow smbd_t console_device_t:chr_file { read write };
allow smbd_t null_device_t:chr_file { read write ioctl };
allow smbd_t init_t:fd { use };


As a general rule we don't want to allow daemons to over-write their own 
config.  The problem is that if one smbd instance can be compromised then the 
config file can be changed to do nasty things (such as authenticate users 
from a different server).
# Permissions for Samba files in /etc/samba
allow smbd_t samba_etc_t:file { write setattr getattr read lock };
allow smbd_t samba_etc_t:dir { search getattr };

I suggest having a separate type for the file(s) that smbd really needs to 
write (may need a file_type_auto_trans rile).


Also you appear to be lacking port definitions.  You want to define port 
types for ports 137..139 and allow only Samba to connect to them.  Check out 
some of the daemons I've written policy for (slapd or dictd) to see an 
example of how to do it.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
