Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9NFptGZ009231
	for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2006 11:51:55 -0400
Received: from mailgate1.arcor-ip.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9NFpAUW022992
	for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2006 15:51:10 GMT
Received: from relay.brunellocal.de (ffmcospub2ffmbrunelfw2lo-cs-nat-mail-server.adm.arcor.net [145.254.28.157])
	by mailgate1.adm.arcor.net (Arcor-CN-MailRelay-l-A) with ESMTP id E84381D3201
	for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2006 17:51:53 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
	by relay.brunellocal.de (Postfix) with ESMTP id E359A5903
	for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2006 15:51:52 +0000 (UTC)
Received: from relay.brunellocal.de ([127.0.0.1])
 by localhost (relay.brunellocal.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 25642-09 for <selinux@tycho.nsa.gov>;
 Mon, 23 Oct 2006 17:51:52 +0200 (CEST)
Received: from mail-hv.brunel.de (mail-hv.brunellocal.de [192.168.1.234])
	by relay.brunellocal.de (Postfix) with ESMTP id 3F9A057D5
	for <selinux@tycho.nsa.gov>; Mon, 23 Oct 2006 17:51:52 +0200 (CEST)
From: Daniel Gil Mayol <Daniel.Gil-Mayol@brunel.de>
To: selinux@tycho.nsa.gov
Subject: vserver and vprocunhide
Date: Mon, 23 Oct 2006 17:51:50 +0200
MIME-Version: 1.0
Message-Id: <200610231751.50609.Daniel.Gil-Mayol@brunel.de>
Content-Type: text/plain;
  charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1.)

I have read that vserver and selinux have conflicts, is that true?

I am using a vserver and it tries to access ( to /proc/1 (init)  labelled as 
unconfined, that means, it tries to {getattr search} over the 
directory /proc/1 and audit show me a denied. Vprocunhide have a list of 
directories of /proc to "unhide" for vserver. The problem is that I can't 
add /proc/1 in vprocunhide (I receive an error when 
start /etc/init.d/vprocunhide restart). I can't relabel /proc/1 using chcon 
or setfiles. I can't write 
"allow vserver_test_t unconfined_t:dir { getattr search };" 
because there are in assert.te the following neverallow:

# Confined domains must never see unconfined domain's /proc/pid entries.
neverallow { domain -unrestricted -snmpd_t -pegasus_t }
 unconfined_t:dir { getattr search };
 
What I have done is substract also the vserver daemon:

neverallow { domain -unrestricted -snmpd_t -pegasus_t -vserver_test}
 unconfined_t:dir { getattr search };

and then I can write 

allow vserver_test_t unconfined_t:dir { getattr search };

Don't seems very elegant this solution, is the right one?
----------------------------------------------------------------------------------------------


2.) 
Each time I try to restart the vserver daemon:

/etc/init.d/vserver_test restart

Then I see the following denied message:

Oct 23 16:45:02 cnsu kernel: audit(1161621902.211:1167): avc:  denied  
{ mounton } for  pid=9476 comm="mount" name="/" dev=hda2 ino=2 
scontext=root:system_r:initrc_t tcontext=system_u:object_r:vprocunhide_t 
tclass=dir

and audit2allow writes the next

allow initrc_t vprocunhide_t:dir mounton;

but when this allow is adedd and I compile I see this message

assertion on line 45221 violated by allow initrc_t vprocunhide_t:dir 
{ mounton };
----------------------------------------------------------------------------------------------

3.)
When I restart the dbus (messagebus) appear the following message.

Oct 23 17:50:29 cnsu dbus: Can't send to audit system: USER_AVC pid=21488 
uid=81 loginuid=-1 message=avc:  0 AV entries and 0/512 buckets used, 
longestchain length 0

It is not a denied, should I try to correct it?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
