Subject: file context questions
From: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-2
Date: 18 Feb 2004 20:53:26 +0100
Message-Id: <1077134006.6667.10.camel@kusturica>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

Several questions here:

1. What is the difference between getfilecon and lgetfilecon?

2. I cannot [l]getfilecon /selinux/context even in permissive mode.
What's happening? Is there a way to get file contexts of a
genfscontexted file, or I have to guess?

3. If I use genfscontext and fs_use for the same file, which will be
 in effect? (or genfscontext is just fs_use_genfs?)

4. When I boot, several filesystems are not configured for labeling.
   Which is the recommended way to label each of them, and why?
   (And anyway, what the heck are they?)
	eventpollfs
	tmpfs
	futexfs
	bdev
	rootfs
	sysfs
	usbfs
	usbdevfs 

-- 
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
