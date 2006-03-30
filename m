Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2UGbQU4029328
	for <selinux@tycho.nsa.gov>; Thu, 30 Mar 2006 11:37:26 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2UGZfwL017144
	for <selinux@tycho.nsa.gov>; Thu, 30 Mar 2006 16:35:42 GMT
Message-ID: <442C0940.5050800@redhat.com>
Date: Thu, 30 Mar 2006 11:37:20 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest policy
References: <442AEEF3.70406@redhat.com> <1143734415.13732.51.camel@sgc>
In-Reply-To: <1143734415.13732.51.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Wed, 2006-03-29 at 15:32 -0500, Daniel J Walsh wrote:
>   
>> Added restorecond policy
>> fixed samba_selinux man page
>> logwatch looks for mounted files system on /mnt
>> file context for yumex
>> groupadd and useradd need to read nsswitch
>> hplib_port_t needed for 9100
>> add 6000 as valid xserver port
>> pam console needs to getattr/setattr usb_dev
>> bluetooth tools want to read resolver
>> hplib_t fixes to work with additional devices (Usb  printers
>> dovecot wants to talk to postgresql and use inotify
>> hal needs to comunicate with ntp
>> pegasus needs to connect to random non reserved ports
>> privoxy wants to use nscd and communicate with tor
>> xfs needs to read fonts in usr_t
>> fstools need to be able to work with blk devices.  (fsck)
>> libmpg123 is moving
>> mount using some certificates stored in usr_t
>>     
>
> Merged.
>
>   
>> setfiles needs trans_lock
>>     
>
> I dropped this; I'm pretty sure its related to the leaked file
> descriptors in semodule t
>   
I have the leak code fixed, but am still seeing this.  I will try it 
again without this code.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
