Reply-To: <rwashington@crucialsecurity.com>
From: "Ryan Washington" <rwashington@crucialsecurity.com>
To: "SELinux" <SELinux@tycho.nsa.gov>
Subject: Kernel panic: VFS: Unable to mount root fs
Date: Fri, 6 Sep 2002 13:25:52 -0400
Message-ID: <DPEPJAJGOCGHICPODIHPIECBCBAA.rwashington@crucialsecurity.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200209061150.49622.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



hey,
i'm pretty new at this, but i can not get selinux 2.4 to load on a fresh
install of redhat 7.3. are there any special configs that need to be
done(since the README file is for 7.1 and 7.2)

i keep getting this error:

VFS: Cannot open root device "sda2" or 08:02
Please append a correct "root= " boot option
Kernel panic: VFS: Unable to mount root fs on 08:02

has anyone seen this before? i've tried adding "mem=96M" after the boot
option, but still hangs at this error.
any help would be greatly appreciated.

thanks,
ryan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
