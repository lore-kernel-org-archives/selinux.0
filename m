Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9BCtTrT005776
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 08:55:29 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9BCsFfG025292
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 12:54:19 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id A55BFC4C088
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 14:55:19 +0200 (CEST)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 25598-06 for <selinux@tycho.nsa.gov>;
	Mon, 11 Oct 2004 14:55:19 +0200 (CEST)
Received: from wintermute.xmldesign.de (p50801E76.dip.t-dialin.net [80.128.30.118])
	by legolas.drinsama.de (Postfix) with ESMTP id C4DCDC4C084
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 14:55:18 +0200 (CEST)
Received: from wintermute.xmldesign.de (wintermute.xmldesign.de [127.0.0.1])
	by wintermute.xmldesign.de (Postfix) with ESMTP id BE488234069
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 14:55:17 +0200 (CEST)
Subject: Asterisk on SELinux
From: Erich Schubert <erich@debian.org>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 11 Oct 2004 14:55:16 +0200
Message-Id: <1097499317.16758.40.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
apparently, the following statements are needed in net_contexts:

portcon udp 2727 system_u:object_r:asterisk_port_t

(sorry, i do not know what port udp/2727 is. google found "media gateway
control protocol call agent (MGCP)" and "broadband voice")


and in in domains/asterisk.te:

# needed to have asterisk start
allow asterisk_t self:process setsched;

# probably for talking to a running instance
allow asterisk_t self:fifo_file rw_file_perms;

# the debian standard installation hasn't got all dirs needed
allow asterisk_t asterisk_spool_t:dir create_dir_perms;

# not sure what is stored in tmp, but IAX related
tmp_domain(asterisk)

# asterisk will need to allocate additional non-priv ports
# for VoIP voice channels. Yes i know this line is ugly.
# suggestions
allow asterisk_t port_t:{ udp_socket tcp_socket } name_bind;

# for /proc/net/route it seems
allow asterisk_t proc_t:file r_file_perms;

# demo files installed in /usr/share/asterisk/sounds/demo-instruct.gsm
# are labeled usr_t
allow asterisk_t usr_t:file r_file_perms;

# some helper apps are probably there
allow asterisk_t { bin_t sbin_t }:dir search;



Unfortunately, while asterisk does now start (as root only, not as
non-root-user... not sure why, but i think the user/group setup isn't
right yet... how do i change a unix users primary group in selinux?)
my test SIP call didn't get properly accepted.

Greetings,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C   (o_
   There was never a good war or a bad peace. - Benjamin Franklin   //\
            Es ist besser, geliebt und verloren zu haben,           V_/_
                    als niemals geliebt zu haben.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
