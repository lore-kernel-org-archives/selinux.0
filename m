Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8B0SILa012934
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 20:28:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8B0SHmw013255
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 00:28:17 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h8B0SF9d013252 for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 00:28:16 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: jna@vasco.com, selinux@tycho.nsa.gov
Subject: Re: installing rh9 latest
Date: Thu, 11 Sep 2003 10:28:08 +1000
References: <200309111529.19386.jna@vasco.com>
In-Reply-To: <200309111529.19386.jna@vasco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309111028.08266.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 11 Sep 2003 15:29, jason anderssen wrote:
> +# Binary policy file and load_policy utility for loading it.
> +mkdir -p $MNTIMAGE/selinux
> +mkdir -p $MNTIMAGE/etc/security/selinux
> +inst /etc/security/selinux/policy.15
> "$MNTIMAGE/etc/security/selinux/policy.15"
> +inst /usr/sbin/load_policy "$MNTIMAGE/bin/load_policy"
> +
>  for MODULE in $MODULES; do
>      cp $verbose -a /lib/modules/$kernel/$MODULE $MNTIMAGE/lib
>  done
> @@ -570,6 +576,11 @@
>      fi
>  done
>
> +echo "echo Loading policy" >> $RCFILE
> +echo "mount -t selinuxfs none /selinux" >> $RCFILE
> +echo "/bin/load_policy /etc/security/selinux/policy.15" >> $RCFILE
> +echo "umount /selinux" >> $RCFILE
> +
>
> I find it a little confusing in the instructions, but all I think I need to
> understand is the following:
>
> In the mkinitrd script supplied, which is the same as above, why does
> load_policy have two different paths, ie:  /usr/sbin/load_policy >
> "$MNTIMAGE/bin/load_policy"?

$MNTIMAGE is the temporary directory used for creating the initrd.  On Red Hat 
an initrd is in ext2 format, so a loopback mount is made of an Ext2 file 
system and the files are copied under it.  So the files are copied to 
$MNTIMAGE (the ext2 file system) and then when the system is booted that file 
system is (temporarily) the root file system.  As for /usr/sbin vs /bin, on 
an initrd you don't want to have lots of directories etc.

The decision to put load_policy under /usr for the main file system should 
probably be revised however, if you don't use an initrd (not recommended) 
then you need to run load_policy before running init.

> what is a linuxrc?

It's the script that the kernel runs after mounting the initrd.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
