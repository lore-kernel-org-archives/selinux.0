Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3FEklI4026609
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 10:46:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3FEkj7R017575
	for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 14:46:46 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h3FEkjKP017572 for <selinux@tycho.nsa.gov>; Tue, 15 Apr 2003 14:46:45 GMT
Subject: RE: strange errors
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
Cc: "'Russell Coker'" <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <CB4A800B69051C4986485EBBC070C69952B950@csoc-mail-hou.csoconline.com>
References: 
	 <CB4A800B69051C4986485EBBC070C69952B950@csoc-mail-hou.csoconline.com>
Content-Type: text/plain
Message-Id: <1050417919.1051.26.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Apr 2003 10:46:55 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-04-15 at 09:18, Westerman, Mark wrote:
> I have run into problems like this before. 
> What fixed it for me was 
> removing all ...security for all mounted partitions and
> performing a make reset (not relabel)

The security class information is not stored in the persistent label
mapping; it is computed at runtime from the inode mode information
provided by the filesystem.
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
