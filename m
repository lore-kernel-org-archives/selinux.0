Message-ID: <526A9525.3060106@tycho.nsa.gov>
Date: Fri, 25 Oct 2013 11:58:29 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: hoefer@ieee.org
CC: Don Hoefer <don.hoefer@verizon.net>, selinux@tycho.nsa.gov
Subject: Re: Need information on building embedded systems.
References: <22095736.309560.1382638891432.JavaMail.root@vms170025>
In-Reply-To: <22095736.309560.1382638891432.JavaMail.root@vms170025>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/24/2013 02:21 PM, Don Hoefer wrote:
>  We are using kernel 3.8.13, busybox 1.20.2.  init says that it is version 2.88, along with that we have the typical Sys-V init with /etc/rc?.d startup scripts.

So did you enable the SELinux support in your init and busybox when you
built it?

We didn't develop the busybox SELinux support ourselves; that was done
by others in the SELinux community, but it has been in upstream busybox
for a while.  I'm not sure what state it is in currently.

sysvinit was extended by Red Hat with SELinux support long ago and that
was upstreamed as well.  init typically performs the initial policy load.

What CONFIG_SECURITY_* options did you enable in your kernel
configuration?  A sample set enabled in one of our Android kernel trees is:
+CONFIG_AUDIT=y
+CONFIG_SECURITY=y
+CONFIG_LSM_MMAP_MIN_ADDR=4096
+CONFIG_SECURITY_NETWORK=y
+CONFIG_SECURITY_SELINUX=y
+CONFIG_DEFAULT_SECURITY_SELINUX=y
+CONFIG_NETWORK_SECMARK=y
+CONFIG_NF_CONNTRACK_SECMARK=y
+CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=y
+CONFIG_NETFILTER_XT_TARGET_SECMARK=y
+CONFIG_NETFILTER_ADVANCED=y
+CONFIG_IP_NF_SECURITY=y

You also need the CONFIG_*_FS_XATTR and CONFIG_*_FS_SECURITY options
enabled for each filesystem that you use that supports per-file security
attributes, e.g.

Kernel 3.8.13 supports up through policy.28, so as long as your
checkpolicy generates a policy file in version 28 or older you are fine.
 The -c option to checkpolicy can be used to force it to an older
version; we use that for Android to ensure compatibility with the
Android 3.4 kernels.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
