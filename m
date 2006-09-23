Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8NEY9GN019948
	for <selinux@tycho.nsa.gov>; Sat, 23 Sep 2006 10:34:09 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8NEXZiH007747
	for <selinux@tycho.nsa.gov>; Sat, 23 Sep 2006 14:33:38 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>
Subject: FC5 policy
Date: Sun, 24 Sep 2006 00:34:06 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200609240034.08217.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://www.coker.com.au/selinux/fc5/

At the above URL I have my latest packages of FC5 policy with patch and 
source.  They compile the policy with amavis and clamav policy in base (which 
can't be included in an FC5 update as the tools are broken and don't support 
policy moving from a module to base), they have Postgrey policy compiled in, 
and they have a few other policy changes (such as allowing unconfined_t to 
kill unlabeled_t processes).

Also my patch removes some unnecessary and inappropriate access from some 
domains.  I know that most people don't like removing access from processes, 
but I think we need to use the principle of least-privilege more seriously.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
