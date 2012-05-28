Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4SFsYhu022031
	for <selinux@tycho.nsa.gov>; Mon, 28 May 2012 11:54:34 -0400
Received: from webmail.harte-lyne.ca (inet04.hamilton.harte-lyne.ca [216.185.71.24])
	by inet07.hamilton.harte-lyne.ca (8.13.1/8.13.1) with ESMTP id q4SFsQjx017066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Mon, 28 May 2012 11:54:26 -0400
Message-ID: <3cc2271ab50f5f35b273260eda59d356.squirrel@webmail.harte-lyne.ca>
Date: Mon, 28 May 2012 11:54:26 -0400
Subject: Where to go for advice on local policy secuirity implications
From: "James B. Byrne" <byrnejb@harte-lyne.ca>
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We employ a third-party Apache module (passenger aka mod-rails) to
handle our Ruby-on-Rails web applications.  Because of the lack of
SELinux awareness built into the module we currently run these on an
isolated virtual host in SE permissive mode.

We are in the process of examining whether it is possible to create a
local policy for Passenger which will allow it to run in enforcing
mode but not open the system to other exploits. We would like to know
if there is any on-line venue where the security aspects of specific
policy elements might be discussed.

Is there such a resource?  If so, can anyone here provide the reference?


-- 
***          E-Mail is NOT a SECURE channel          ***
James B. Byrne                mailto:ByrneJB@Harte-Lyne.ca
Harte & Lyne Limited          http://www.harte-lyne.ca
9 Brockley Drive              vox: +1 905 561 1241
Hamilton, Ontario             fax: +1 905 561 0757
Canada  L8E 3C3


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
