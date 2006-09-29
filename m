Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8TG8Zsv025022
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 12:08:36 -0400
Received: from bay0-omc2-s40.bay0.hotmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8TG80u8010518
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 16:08:01 GMT
Message-ID: <BAY114-F1FFF391047B48196CAC48AF180@phx.gbl>
From: "Salvo Giuffrida" <giuffsalvo@hotmail.it>
To: selinux@tycho.nsa.gov
Subject: Where is the AVC?
Date: Fri, 29 Sep 2006 18:08:25 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>From reading the book "SELinux by example", it seems that the AVC is managed 
by the Security Server (figure 3-2). Instead, by reading the paper "The 
Flask Security Architecture: System support for Diverse Security Policies" 
in the NSA website, it looks like the AVC is managed by the Object Managers 
(why the plural? I though that there was just one object manager, but maybe 
it's because I was thinking only about files...So, there's an object manager 
for every macro-class of objects (files, processes, network objects?)?). Who 
is wrong and who is right?

Another thing: the security context of files, in ext2/ext3/jfs/xfs 
filesystems is memorized in the xattr space of inodes, in the attribute 
security.selinux. But, is it memorized in the string form (user:role:type), 
or in the PSID form (the 32-integer which is mapped by the Security Server 
into a "true" security context)? Doing "getfattr -n security.selinux file" 
on a file gives me the string rapresentation of the Security Context, but 
also on objects like /dev/men...
Thanks in advance

_________________________________________________________________
Blocca le pop-up pubblicitarie con MSN Toolbar! http://toolbar.msn.it/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
