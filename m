Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l77EL4fr027908
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 10:21:05 -0400
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l77EL3mT021040
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 14:21:03 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070807141415.525577324@hp.com>
Date: Tue, 07 Aug 2007 10:14:15 -0400
To: selinux@tycho.nsa.gov
Cc: kaigai@ak.jp.nec.com, joe@nall.com
Subject: [RFC 0/5] Static/fallback external labels for NetLabel
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset adds the static/fallback labeling feature to NetLabel that has
been requested on the SELinux mailing list more and more recently.  This new
bit of functionality also matches what can be found on similar trusted/labeled
OSs such as Trusted Solaris, HP-UX CMW, etc.  This patchset it not yet ready
for "upstreaming" so please do not pull this into any tree bound for the
mainline kernel; I still need to do more review and testing of the code.
However, I know there are several of you on this list that have been anxiously
awaiting this patchset so I thought I would make an early release so you could
get a peek and test it out.  I won't be able to work on this patchset much, if
at all, between August 10th and the 20th so don't expect an update from me
until the end of August.

The basic idea is that currently there is no method for providing an external
label to fallback on if a labeled networking mechanism such as NetLabel/CIPSO
or labeled IPsec is not in use.  This patch adds a mechanism for providing a
static fallback label, specified per interface/network, which is used when
a NetLabel recognized labeling protocol (at this point CIPSO) is not in use.

For those of you wishing to try this patchset, it is backed against Linus'
linux-2.6 git tree from the afternoon of August 6th, but I don't imagine you'll
have many problems applying the patchset to later trees at this point in the
2.6.23 release cycle.  In addition to the kernel patches you will also need a
modified version of netlabelctl from the netlabel_tools package.  A very crude
version of the modified tools can be found in the netlabel_tools SVN repository
in the static_label branch.  Please check the NetLabel website on SourceForge,
http://netlabel.sf.net, for information on the SVN repository.  The three new
netlabelctl commands are as follows:

 # netlabelctl unlbl add interface:<DEV> address:<ADDR>[/<MASK>] label:<LABEL>
 # netlabelctl unlbl del interface:<DEV> address:<ADDR>[/<MASK>]
 # netlabelctl -p unlbl list

   DEV = interface, examples: eth0, lo
   ADDR = IP address, examples: 192.168.0.3, ::1
   MASK = IP address mask length, examples 8, 24, 64
   LABEL = LSM/SELinux label, example: system_u:object_r:unlabeled_t:s2

For example, if you wanted to label all inbound traffic on eth1 from
192.168.0.0/16 with the label "system_u:object_r:staticlabel_t:s7" you would
type:

 # netlabelctl unlbl add interface:eth1 address:192.168.0.0/16 \
                         label:system_u:object_r:staticlabel_t:s7

Both IPv4 and IPv6 addresses can be used and if the address mask is ommitted
from the command the address is assumed to be a host address, not a network,
and the maximum mask size for that address family is used.  If you do not wish
to specify an address, simply use a address mask of zero, "/0", which will
cause all addresses within that address family to match.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
