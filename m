Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7KERuHa021829
	for <selinux@tycho.nsa.gov>; Wed, 20 Aug 2003 10:27:56 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7KEN5eJ012656
	for <selinux@tycho.nsa.gov>; Wed, 20 Aug 2003 14:27:55 GMT
Received: from hotmail.com (bay8-f34.bay8.hotmail.com [64.4.27.34])
        by jazzband.ncsc.mil  with ESMTP id h7JHwvNN029187 for <selinux@tycho.nsa.gov>; Tue, 19 Aug 2003 17:59:07 GMT
From: "Ripin Natani" <ripinfs@hotmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: "Unable to mount root fs on unknown-block(0,0)"
Date: Tue, 19 Aug 2003 13:58:56 -0400
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_7b2c_156c_3aea"
Message-ID: <BAY8-F34AeUxUsU7DRz00022296@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_7b2c_156c_3aea
Content-Type: text/plain; format=flowed

(sorry if this is a duplicate)
Yes I am booting with an initrd. Basically I do a 'make install' after make  
'make modules_install'. The steps that I perform:
make mrproper
make menuconfig
make clean
make bzImage
make modules
make modules_install
make install
I also updated the mkinitrd (now i have the 3.4.42 version). Does that have 
the patch ? Btw I did not find any documentation in linux2.6/README about 
the patch for the mkinitrd script. ( I hope i looked at the right README !!! 
).
The system is still giving the same error !
Also I am resending the .config file.
Thanks,
-Ripin


>Are you boot it with an initrd?  Did you patch your mkinitrd script per
>the README so that the initial policy load will occur from the initrd?
>
>The root=LABEL=/ should work fine as long as you are using an initrd
>(which you should be using, to perform the initial policy load, unless
>using the old 2.4-based SELinux).  If you weren't using an initrd, you
>would need to specify the actual root device, e.g. root=/dev/hda2 or
>whatever is appropriate for your system.
>
>--
>Stephen Smalley <sds@epoch.ncsc.mil>
>National Security Agency
>

_________________________________________________________________
<b>Get MSN 8</b> and enjoy automatic e-mail virus protection.    
http://join.msn.com/?page=features/virus

------=_NextPart_000_7b2c_156c_3aea
Content-Type: application/octet-stream; name=".config"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=".config"


------=_NextPart_000_7b2c_156c_3aea--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
