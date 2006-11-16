Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAGEC2PJ025319
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 09:12:02 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id kAGEAOBv005057
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 14:10:24 GMT
Subject: Re: Strange file context issues
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Bradley Chapman <kakadu@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <e294b46e0611160537p10c3224cmfecac57ac4c1f4bc@mail.gmail.com>
References: <e294b46e0611160537p10c3224cmfecac57ac4c1f4bc@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 09:12:28 -0500
Message-Id: <1163686348.7374.37.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-11-16 at 13:37 +0000, Bradley Chapman wrote:
> After tearing my hair out for the past two weeks trying to understand
> the error messages I've been seeing in my Debian system, I've finally
> twigged onto why I've been getting so many - there appears to be a
> mislabeling of file contexts within my filesystems.
> 
> Take for example this error message in the dmesg:
> 
> audit(1163682174.716:3): avc:  denied  { read write } for  pid=1
> comm="init" name="console" dev=sda6 ino=77743
> scontext=system_u:system_r:init_t tcontext=system_u:object_r:file_t
> tclass=chr_file
> 
> Clearly, the problem would seem to be that the file /dev/console has
> the wrong context, preventing init from reading it.
> 
> Yet this is what I get when I do ls -l --context /dev/console:
> 
> crw-------  root root system_u:object_r:console_device_t /dev/console
> 
> The majority of early errors in dmesg appear to be similar, with
> system_u:object_r:file_t popping up all over the place in /dev instead
> of the correct contexts. I have a feeling that many of the remaining
> errors I'm seeing are linked to this problem as well.
> 
> Can anyone offer any advice as to how this may have happened? I've
> already tried a filesystem relabel but it doesn't seem to have had any
> effect.

Are you using udev?  If you have udev and static device nodes under them
on the regular fs, those are probably mislabeled.  Anything trying to
use them early in the boot process before udev is started would hit
denials like this.  Relabeling wouldn't get them since they're covered
up by udev's tmpfs.  You'd have to unmount the tmpfs to relabel them.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
