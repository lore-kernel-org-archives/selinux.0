Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m63Dm8h0001843
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2008 09:48:08 -0400
Received: from ikarus.tarent.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m63Dm7M4005146
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2008 13:48:07 GMT
Received: from localhost (localhost [127.0.0.1])
	by ikarus.tarent.de (Postfix) with ESMTP id C05B57F54D3
	for <selinux@tycho.nsa.gov>; Thu,  3 Jul 2008 15:48:05 +0200 (CEST)
Received: from ikarus.tarent.de ([127.0.0.1])
	by localhost (ikarus.tarent.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00874-02 for <selinux@tycho.nsa.gov>;
	Thu, 3 Jul 2008 15:47:57 +0200 (CEST)
Received: from [172.16.4.30] (ckuest.entwickler.tarent.de [172.16.4.30])
	by ikarus.tarent.de (Postfix) with ESMTP id 1101E7F54DE
	for <selinux@tycho.nsa.gov>; Thu,  3 Jul 2008 15:47:57 +0200 (CEST)
Message-ID: <486CD88E.2000406@tarent.de>
Date: Thu, 03 Jul 2008 15:47:58 +0200
From: Christian Kuester <c.kuester@tarent.de>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Adding local nodecon's through semanage
Content-Type: text/plain; charset=ISO-8859-15
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi List,

I had a small conversation with Stephen Smalley on the
fedora-selinux-list about an easy way to add
(local) nodecon's on a SELinux enabled system. As this is not
implemented in semanage yet
he gave me the advice to revive a discussion[1] on this list from 2006.
It began because a patch against
semanage was posted which enabled nodecon support. It seems that the
patch never got commited
because it didn't work as expected.

I writing because I would like to know if there's any chance to get that
fully working. I played around
with the patch and I could set labels to nodes and my SELinux seems to
respect these settings.
f.i
# semanage node -t blacknetwork_node_t -a -p 0 -M 255.255.255.255
192.168.100.54
$ ./socat -u TCP4-LISTEN:5555,bind=192.168.100.54,reuseaddr,fork -
...
type=AVC msg=audit(1215085777.002:689775728): avc:  denied  { node_bind
} for  pid=26627 comm="socat" saddr=192.168.100.54 src=5555
scontext=user_u:user_r:exe_t:s0
tcontext=system_u:object_r:blacknetwork_node_t:s0 tclass=tcp_socket

So, this seems to work. But I run into problems when I told semanage
about the
*actual* netmask of this node, which is 255.255.255.0. The tcontext
string switched from
"blacknetwork_node_t" to the generic "node_t".

Kind regards,
Chris

[1] http://www.nsa.gov/selinux/list-archive/0609/16754.cfm




-- 
tarent Gesellschaft für Softwareentwicklung und IT-Beratung mbH

Heilsbachstr. 24, 53123 Bonn  | Poststr. 4-5, 10178 Berlin
fon: +49(228) / 52675-0       | fon: +49(30) / 27594853
fax: +49(228) / 52675-25      | fax: +49(30) / 78709617

Geschäftsführer
Boris Esser, Elmar Geese
HRB AG Bonn 5168
Ust-ID: DE122264941


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
