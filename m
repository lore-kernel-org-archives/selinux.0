From: =?iso-8859-1?Q?Vanuxem_gr=E9gory?= <gvanuxem@club-internet.fr>
To: "SELinux Mailing" <SELinux@tycho.nsa.gov>
Subject: BUGS for mlstrusted*
Date: Fri, 7 Jun 2002 21:30:36 +0200
Message-ID: <ADEEIKPBIEHIINPOFGAOKEFDCDAA.gvanuxem@club-internet.fr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 In the configurations files, if
 we make typo errors like "mlstrustedreeeder",
 the checkpolicy compile and load the new policydb !!!
 
 Another thing, the extended socket call don't work
 with ipv6
 
 I think that that these socket call aren't build for ipv6
 but without this extended api : no pb !!
 
 => denied <null> for ....
 	with udp_socket, rawip_socket and more may be
 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
