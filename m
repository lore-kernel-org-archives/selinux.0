Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBKK9gIi017032
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 15:09:42 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBKK7vkB006037
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 20:07:57 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id iBKK9j2g023277
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 15:09:45 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id iBKK9er04700
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 15:09:40 -0500
Message-ID: <41C73183.5040209@redhat.com>
Date: Mon, 20 Dec 2004 15:09:39 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Fedora Targeted List grows on Rawhide.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have added several targets to Targeted Policy as of 
selinux-policy-targeted-1.19.14-2. 
I am attempting to add most of the network daemons to targeted.  In 
order to experiment with this new
policy file, you will need to relabel.  Or you can just relabel the 
target you are interested in.

The best way to do this is install the policy and then execute

rpm -q -l TARGETRPM | restorecon -R -f -

Current targets

amanda.te apache.te cups.te dhcpd.te dictd.te dovecot.te fingerd.te 
ftpd.te howl.te i18n_input.te inetd.te innd.te kerberos.te ktalkd.te 
ldconfig.te lpd.te mailman.te modutil.te mta.te mysqld.te named.te 
nscd.te ntpd.te portmap.te postgresql.te privoxy.te radius.te radvd.te 
rpcd.te rshd.te rsync.te samba.te slapd.te snmpd.te spamd.te squid.te 
stunnel.te syslogd.te tftpd.te winbind.te ypbind.te ypserv.te zebra.te

This is not a commitment for this list in FC4, some could be pulled if 
they don't work well :*).

The goal of targeted policy is to protect all network daemons and to 
allow userspace to run with normal privs.    You still need strict 
policy to confine userspace.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
