Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TF9RrT019635
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 11:09:27 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6TF8ubB025318
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 15:08:56 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 5F998C4C094
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 17:09:21 +0200 (CEST)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 04155-04 for <selinux@tycho.nsa.gov>;
	Thu, 29 Jul 2004 17:09:21 +0200 (CEST)
Date: Thu, 29 Jul 2004 17:09:21 +0200
From: Erich Schubert <erich@debian.org>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: udev and .dev...
Message-ID: <20040729150921.GA17881@legolas.drinsama.de>
References: <20040729091423.GC6443@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040729091423.GC6443@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> soooo... to fix that [rather than a patch, a sed command]:
> 	:%s/u?dev/.?u?dev/g

Note that . has a special meaning in regular expressions.
You should quote it, but you're approaching quoting hell right now with
your sed expression... ;-)

Also at least for some time udev used /etc/udev/.dev
but i think this has been made deprecated by now.

> this will allow setfiles to set up the security contexts on
> the /.dev which is the _real_ filesystem /dev stuff which will
> allow things like, oh, init (!!) to access the hard drive.

Are you sure? i'd guess that using /dev is hardwired into init.
FYI: i see
/dev on /.dev type none (rw,bind)

but /proc/mounts shows

/dev/root /.dev ext3 rw,noatime 0 0
none /dev tmpfs rw 0 0

So i think that /dev is moved via a bind mount to /.dev (kind of
emergency device nodes) and /dev is then replaced by a ramdisk which is
maintained by udev.

This sounds like relabling hell :-) "make relabel" might even skip /.dev
because it doesn't know the file system.
You can't use "make relabel" to persistently fix labels on /dev.
I don't know enough about automatic labelling by selinux. Maybe you'll
need a udev which reads the file_contexts file. :-(
(or a similar specification file)

Greetings,
Erich
-- 
    erich@(mucl.de|debian.org)      --      GPG Key ID: 4B3A135C    (o_
     Go away or i'll replace you with a very small shell script.    //\
            Es ist besser, geliebt und verloren zu haben,           V_/_
                    als niemals geliebt zu haben.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
