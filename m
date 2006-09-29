Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8TLYfNV004540
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 17:34:41 -0400
Received: from mail6.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8TLY7u8023307
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 21:34:07 GMT
Date: Fri, 29 Sep 2006 17:34:39 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@redhat.com>
Subject: git trees for SELinux kernel
Message-ID: <Pine.LNX.4.64.0609291729450.9262@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

FYI,

I'm experimenting with public git trees for managing patches heading 
upstream, and if all goes well, will try and push all SELinux kernel 
patches via them.

Currently, I'll probably be pushing stuff to Dave only (if I can figure 
out how to do it at all), for all of the labeled networking stuff we 
expect over the next few days.

The trees are here:

http://git.infradead.org/?p=users/jmorris/selinux-2.6.git;a=summary
http://git.infradead.org/?p=users/jmorris/selinux-net-2.6.git;a=summary


A special thanks to David Woodhouse for making his server available.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
