Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8OKVVsJ020456
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 16:31:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8OKVVCG014083
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 20:31:31 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
        by jazzband.ncsc.mil  with ESMTP id h8OKVUqJ014080 for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 20:31:30 GMT
Date: Wed, 24 Sep 2003 21:31:29 +0100
From: Dale Amon <amon@vnl.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: ssh policy hassles
Message-ID: <20030924203129.GQ21997@vnl.com>
References: <20030923150926.GG21997@vnl.com> <200309242334.55203.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309242334.55203.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

avc:  denied  { search } for  pid=654 exe=/usr/sbin/sshd dev=sda2 ino=903169 scontext=system_u:system_r:sshd_t tcontext=system_u:object_r:var_lib_t tclass=dir

Can anyone think of a reason why an sshd would try to search
/var/lib upon an incoming ssh connection? /var/lib is
not in the source code, it's not in the config files...
The only thing I see that looks even vaguely like a possible 
target there is /var/lib/urandom.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
