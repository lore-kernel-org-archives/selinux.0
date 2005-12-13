MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: SELinux: Unregistering netfilter hooks
Date: Tue, 13 Dec 2005 22:13:28 +0530
Message-ID: <48A6EBBDA6EC5F4A9A65B843D5C821AB016F8897@bgeexc05.asiapacific.cpqcorp.net>
From: "Saivasan, Prakash (STSD)" <prakash.saivasan@hp.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "SELinux List" <SELinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 Hi all,
   I was trying to build a test kernel (2.6.14-3) from kernel
(2.6.11-1), on fedora core 4. However on trying to boot the new kernel,
I find that the kernel would not boot beyond a certain point. I seems to
hang on SELinux: Unregistering netfilter hooks. This happens when I
disable SELinux. When I try to enable SELinux it hangs at a different
point trying to do something on usbfs. Is this a know problem or am I
doing something wrong ? Can anyone help ??
   There is no problem when I try to boot with the original kernel.


Thanking you
Prakash S


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
