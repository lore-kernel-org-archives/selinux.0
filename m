Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m750F2g0008840
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 20:15:03 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m750Exuw000078
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 00:15:01 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id E747B183C3
	for <selinux@tycho.nsa.gov>; Tue,  5 Aug 2008 10:14:52 +1000 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uzwWyFrFJ9q1 for <selinux@tycho.nsa.gov>;
	Tue,  5 Aug 2008 10:14:52 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 8A2B318359
	for <selinux@tycho.nsa.gov>; Tue,  5 Aug 2008 10:14:52 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 6832C2170F
	for <selinux@tycho.nsa.gov>; Tue,  5 Aug 2008 10:14:50 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: xdm_tmp_t
Date: Tue, 5 Aug 2008 10:14:48 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200808051014.49863.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently xdm_tmp_t is applied to /tmp/.ICE-unix/ which is writable by user_t 
(EG for dcopserver in KDE which creates sockets there).

xdm_tmp_t is defined in the xserver module which currently on Debian is only 
loaded if you have packages like xdm installed.  But if for example you have 
a blade server or Xen DomU that has no ability to have a local X server (and 
therefore no need for xdm) then you can still run "ssh -X" and launch KDE 
programs.

With the current way the Debian policy works if you don't have the xserver 
policy module loaded then the <<none>> labelling policy is used and you end 
up with /tmp/.ICE-unix/ labelled as initrc_tmp_t which denies access to 
user_t and prevents running KDE programs.

It seems to me that there are three viable possibilities to deal with this:
1)  Load xserver.pp unconditionally (or build it into the policy).
2)  Move the xdm_tmp_t definition to something that's in base.
3)  Just label the directory in question as tmp_t - it seems that there is 
little protection if user_t can put whatever they want there.

As an aside allowing user_t to create files of type xdm_tmp_t seems like it 
might be a mistake.  Is this ever necessary?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
