Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4TKPVx9021806
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2007 16:25:31 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l4TKPVIh013759
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2007 20:25:31 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: audit2allow module generation
Date: Tue, 29 May 2007 16:25:28 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588BF0075@exchange.columbia.tresys.com>
In-Reply-To: <1180137749.10334.18.camel@localhost.localdomain>
From: "Anand Patel" <apatel@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: "SE Linux" <selinux@tycho.nsa.gov>, "Daniel J Walsh" <dwalsh@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am trying to use audit2allow to generate module out of audit messages.

So, I installed refpolicy headers first. Then tried sepolgen-ifgen 

%sepolgen-ifgen
% ... some output ...
%parsing file /usr/share/selinux/devel/include/services/snmp.if
%error parsing file /usr/share/selinux/devel/include/services/snmap.if:
%could not parse text: "Syntax error on line 1 ( [type=OPAREN]"

Parser had problem parsing almost all if files and generated above
error.
It would been helpful if error included correct line number.
Is it parser bug? 
Am I doing anything wrong?
Is there any documentation available on how to use this policy
generation tools?
What are the dependencies these tools have?


Thanks,

Anand Patel
Tresys Technology
apatel@tresys.com
410-290-1411xt153 




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
