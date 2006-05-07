Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k47FVlEf032019
	for <selinux@tycho.nsa.gov>; Sun, 7 May 2006 11:31:47 -0400
Received: from mail7.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k47FVkiA004222
	for <selinux@tycho.nsa.gov>; Sun, 7 May 2006 15:31:46 GMT
Received: from megaweapon.nightmoose.net (HELO d.namei) ([66.92.66.197])
          (envelope-sender <jmorris@namei.org>)
          by mail7.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <selinux@tycho.nsa.gov>; 7 May 2006 15:31:41 -0000
Date: Sun, 7 May 2006 11:31:38 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
cc: netdev@vger.kernel.org, netfilter-devel@lists.samba.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: [RFC] SECMARK 1.0
Message-ID: <Pine.LNX.4.64.0605071104590.8588@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patchsets implement a new scheme for adding security 
markings to packets via iptables, as well as changes to SELinux to use 
these markings for security policy enforcement.

Along with these patches, assorted files including policy examples and 
patches for SELinux userland may be found at:
http://people.redhat.com/jmorris/selinux/secmark/

The requirements for secmark arise from the current per-packet network 
controls in SELinux, which are rudimentary, and not as expressive or 
powerful as the controls provided by Netfilter/iptables.

Thus, the idea is to leverage Netfilter/iptables for packet selection and 
labeling, so that SELinux can have more powerful and expressive network 
controls.  This also allows for increased security, as the policy is more 
effective, allowing access to the full range of iptables selectors and 
support mechanisms.

For example, SELinux will now be able to utilize connection tracking, so 
that only packets which are known to be valid for a specific connection 
will be allowed to reach the subject.

Sample iptables rules for labeling packets are at:
http://people.redhat.com/jmorris/selinux/secmark/rules/

And examples of new policy controls may be found here:
http://people.redhat.com/jmorris/selinux/secmark/policy/


The sample policy for ftpd demonstrates how the vsftpd server can be 
confined so that it only receives SYN packets on the ftp control port for 
new connections, as well as any packets related to the ftp control or data 
connections and related ICMP packets.  It is also allowed to send DNS 
requests.

Note that only the per-packet network controls are being replaced -- the 
existing socket-based controls such as name_bind, node_bind and 
name_connect are being retained as they are useful for applications in 
that they return error messages in response to socket calls, and prevent, 
for example, an application from binding to specific local IP addresses.

Also, this local packet marking is orthogonal to the xfrm network labeling 
(which is for mediating access based on the security context of the 
endpoints across a network connection).


Please review these patches and let me know if there are any queries.

I would like to get the kernel components upstream in the 2.6.18 merge 
window.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
