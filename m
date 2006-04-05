Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k35Bxaeg020834
	for <selinux@tycho.nsa.gov>; Wed, 5 Apr 2006 07:59:36 -0400
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k35BxYwH027453
	for <selinux@tycho.nsa.gov>; Wed, 5 Apr 2006 11:59:34 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 157EDC4C084
	for <selinux@tycho.nsa.gov>; Wed,  5 Apr 2006 13:59:35 +0200 (CEST)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 16328-02 for <selinux@tycho.nsa.gov>;
	Wed, 5 Apr 2006 13:59:34 +0200 (CEST)
Received: from wintermute.xmldesign.de (p549A20EB.dip0.t-ipconnect.de [84.154.32.235])
	by legolas.drinsama.de (Postfix) with ESMTP id 4F5F1C4C083
	for <selinux@tycho.nsa.gov>; Wed,  5 Apr 2006 13:59:34 +0200 (CEST)
Received: from wintermute.xmldesign.de (wintermute.xmldesign.de [127.0.0.1])
	by wintermute.xmldesign.de (Postfix) with ESMTP id 5B8DD2340F9
	for <selinux@tycho.nsa.gov>; Wed,  5 Apr 2006 13:59:35 +0200 (CEST)
Subject: VPN module
From: Erich Schubert <erich@debian.org>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 05 Apr 2006 13:59:34 +0200
Message-Id: <1144238374.19128.11.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
I'll probably write a OpenVPN module sometime soon.
We already have a "vpn" module, but that is only for the vpnc client so
far.
Should I
- try to make a single module for both (I consider that a bad idea,
since vpnc is a client only for cisco VPNs, whereas OpenVPN can be used
as a full-blown VPN server and is much more flexible)
- rename the vpn policy to vpnc and make a new "openvpn" module?

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C   (o_
     Go away or i'll replace you with a very small shell script.    //\
   Es ist beschämender seinen Freunden zu mißtrauen als von ihnen   V_/_
        getäuscht zu werden. --- François de la Rochefoucauld



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
