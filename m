Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9BC2hPv017699
	for <selinux@tycho.nsa.gov>; Wed, 11 Oct 2006 08:02:43 -0400
Received: from bay0-omc2-s28.bay0.hotmail.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9BC1Q7K011040
	for <selinux@tycho.nsa.gov>; Wed, 11 Oct 2006 12:01:27 GMT
Message-ID: <BAY114-F2943B992BBD6E030CCB84DAF140@phx.gbl>
From: "Salvo Giuffrida" <giuffsalvo@hotmail.it>
To: selinux@tycho.nsa.gov
Subject: security_compute_av
Date: Wed, 11 Oct 2006 14:02:41 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If the security_compute_av function is called by the AVC when a cache miss 
occurs, then how is first contacted the AVC by the object manager? Which 
function is used?
And the security_compute_create, by who is called? The object manager on 
creation of new objects?
Thanks

_________________________________________________________________
Bolletta del telefono pesante? Risparmia con il nuovo Messenger  
http://imagine-msn.com/messenger/launch80/?locale=it-it


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
