From: "Vanuxem" <gvanuxem@club-internet.fr>
To: "SELinux Mailing" <SELinux@tycho.nsa.gov>
Subject: TR: Trans_domain and MLS (small error)
Date: Mon, 17 Dec 2001 14:32:07 +0100
Message-ID: <ADEEIKPBIEHIINPOFGAOAEFCCAAA.gvanuxem@club-internet.fr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi

I have two questions :

-	How can I 'Trans' to system role if the original is user

I explain :
I have the pppd domain that work under the user or sysadm role for example :

'greg:user_r:user_pppd_t'

I want allow to trans to the system role and system user:
system_u:system_r:portsentry_t
If  use the macro domain_auto_trans : domain_auto_trans ($1_pppd,
portsentry_exec_t,portsentry_t)
The resulting context is greg:user_r:portsentry_t

Is it possible without using newrole??


-	I want to know if you continue your work about MLS

Since if I want that a user login with a high level, he must write on a tty
device that has a lower level.
I know that the MLS is just for experimentation but I have no see some
change in the code and may be you
stop this developement actually...




Sorry for my poor english...

	Greg


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
