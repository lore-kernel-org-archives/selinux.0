Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6MAI8sQ018459
	for <selinux@tycho.nsa.gov>; Wed, 22 Jul 2009 06:18:08 -0400
Received: from snt0-omc3-s34.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n6MAIvM0019666
	for <selinux@tycho.nsa.gov>; Wed, 22 Jul 2009 10:18:57 GMT
Message-ID: <SNT115-W60065DFB4C91354C52FD4FC11B0@phx.gbl>
From: Stefano Carucci <stecarucci@hotmail.com>
To: <selinux@tycho.nsa.gov>
Subject: Policy database
Date: Wed, 22 Jul 2009 10:13:15 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello all!
 
I would like to ask you experts some details about how the policy is managed (stored and retrieved) by the security server. 
If you can recommend some documentation where these topics are addressed in details I would be very grateful. 

These are the ideas I (haven't) got while looking through the code.
If the needed policy rule is not present in the AVC, then it has to be retrieved by... the Access Vector Table (ss/avtab.h/c), right?
The avtab is a "simple" hash-table, where all rules are stored and searched through the key {ssid,tsid,obj_class} for the access vector. Is it correct? 
What I expected was something faster to search... like a database...
On the other side, the policy should be stored in a binary policy file. So how is the set of rules retrieved from this binary file?
I also read about a policy database, that, as far as I understood is meant for configuration parameters only. It doesn't work as a rules repository, right?

I would be very thankful guys if you can help me understand this mechanism.
 
Thank you in advance.
 
Stefano
_________________________________________________________________
Con Windows Live, puoi organizzare, modificare e condividere le tue foto.
http://www.microsoft.com/italy/windows/windowslive/products/photo-gallery-edit.aspx

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
