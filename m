Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4Q06LGW009867
	for <selinux@tycho.nsa.gov>; Thu, 25 May 2006 20:06:21 -0400
Received: from mail4.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4Q06JKp024865
	for <selinux@tycho.nsa.gov>; Fri, 26 May 2006 00:06:20 GMT
Date: Thu, 25 May 2006 20:06:15 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC 0/4] NetLabel
In-Reply-To: <44760E29.4070407@hp.com>
Message-ID: <Pine.LNX.4.64.0605251938360.27473@d.namei>
References: <44760E29.4070407@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 25 May 2006, Paul Moore wrote:

> This patch introduces a new kernel feature designed to support labeled
> networking protocols such as RIPSO and CIPSO.  These protocols are required to
> interoperate with existing "trusted" operating systems such as Trusted
> Solaris.

A few initial comments.

- Did you decide that you definitely need to verify labels on fragments?  

I can see the code's been added to do that, but wonder about a comment 
made during earlier discussion that mislabeled fragments could only come 
from a misbehaving trusted system.  What is the threat model here?


- Can you explain how module loading and module refcounting for these 
modules work?  (e.g. what causes netlabel_cipso_v4 to be loaded, is it 
always safe to unload if the refcount is zero?)


- What about user APIs for setting and retrieving labels?


- What about labeling of kernel-generated packets?


- Don't put #ifdef'd code into mainline code.

e.g. in net/ipv4/ip_fragment.c

+#ifdef CONFIG_NETLABEL_CIPSOV4
+       if (sopt->cipso) {

This needs to be a function which is compiled away as a static inline when 
not selected.  This stuff should have zero impact on the networking code 
if not enabled.


- Try and add entries for security/selinux/nlmsgtab.c for the new Netlink 
protocol.


- This does not follow normal kernel coding practices:

+       if (netlbl_netlink_init() != 0) {
+               netlbl_domhsh_exit();
+               return -ENOMEM;

This should be:

{
	err = netlbl_netlink_init();
	if (err)
		goto err_domhsh;

	...

err_domhsh:
	netlbl_domhsh_exit();
	return err;
}

i.e. a single error path when you have cleanups to perform, and 
propagation of error codes.


- This kind of stuff should be removed before merging:

+static void __exit netlbl_exit(void)
+{
+       printk(KERN_INFO "NetLabel: Exiting\n");


+int netlbl_netlink_init(void)
+{
+       BUG_ON(netlbl_nl);


+int netlbl_netlink_exit(void)
+{
+       BUG_ON(!netlbl_nl);


Should the above two be marked __init and __exit?  And why does the last 
one return an int when the only possible return value is zero?  (it needs 
to return void).


- Why does this module have a version number?

+       printk(KERN_INFO "NetLabel: Initializing (v%s %s)\n",
+              NETLBL_VER_STR, NETLBL_VER_DATE);





-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
