Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA16957
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2001 15:45:34 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA18464
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2001 20:45:22 GMT
Received: from homegate.savages.net (savages.net [208.170.193.18] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id UAA18460
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2001 20:45:21 GMT
Message-ID: <3C1911B6.5000607@pcez.com>
Date: Thu, 13 Dec 2001 12:38:14 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, courier-users@lists.sourceforge.net
Subject: thanks, and new issue
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

HI

Thanks, when I did a "make load" that fixed the newrole problem.

New Issue:

I am trying to add/make a new security policy for the courier mail 
server.  Sendmail is easy compared with qmail or courier.  This will 
also be a good learning experiance for me (and others) to go through the 
thinking behind creating a security policy.    I am not a courier 
expert,   but I think selinux and courier would be good togther.

The problem is how fine grained a security policy I should make?
Should every processes have a seperate policy or should the whole 
package be one security?
Should the certs be protected more than other parts?
Courier writes to the users Maildir in their home dir, only 
courier_local writes to users dir.  ????



Background:
Courier is a all inclusive mails server.  It is like qmail with 
different processes doing different tasks. It also has imap,pop3 secure 
imap,pop3 also.  It has a web interface to help with configuration.  And 
webmail client.

File structure
/etc/courier                courier_conf_t        configuration files

/var/spool/courier      courier_spool_t      spool directories for courier
/var/spool/courier/msgq    courier_msgq_t
/var/spool/courier/msgs     courier_msgs_t
/var/spool/courier/authdaemon

/usr/lib/courier          courier_t                 courier
/usr/lib/courier/bin    courier_bin_t
/usr/lib/courier/sbin   courier_sbin_t
/usr/lib/courier/share  courier_share_t
/usr/lib/courier/share/rootcerts    courier_certs_t               esmtp, 
imap, pop3 certs for SSL
/usr/lib/courier/share/htmldoc

Running processes:

courierd            main daemon            courier_daemon_t
courierXXXX   transport daemons    courier_trans_t
courieresmtp    input daemon             courier_esmtp_t
authdaemon      authorize connections courier_auth_t
couriertcpd       courier tcpd                  courier_tcpd_t
pop3d, pop3d-ssl, imapd, imapd-ssl       courier_XXXX_t
courierfilter      spam killer   (not used now)  courier_filter_t







--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
