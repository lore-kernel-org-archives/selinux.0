Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4KHHLI4011058
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 13:17:22 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4KHGwQj021036
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 17:16:59 GMT
Received: from unicorn.lemuria.org (c145125.adsl.hansenet.de [213.39.145.125])
	by jazzswing.ncsc.mil  with ESMTP id h4KHGvxS021032
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 17:16:58 GMT
Date: Tue, 20 May 2003 19:15:07 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: xdm (not kdm) policy ?
Message-ID: <20030520191501.A10859@lemuria.org>
References: <20030520145143.C400@lemuria.org> <200305210015.37136.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200305210015.37136.russell@coker.com.au>; from russell@coker.com.au on Wed, May 21, 2003 at 12:15:37AM +1000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've made huge steps forward, and have a wdm patched with SELinux
support (optional, via ./configure --enable-flask). It builds and
installs well using the debian package tools.
I've also updated the file_contexts/program/xdm.fc file to include wdm.

Unfortunately, it doesn't log me on. It bails out with this message in
/var/log/auth.log: "Unable to get SID for tom"
Needless to say, tom is in the users file and logging in on the console
or via ssh works fine. wdm issues the same error for root, btw.

Russell, I've mostly copied your patch from KDM, including this
message. It follows a call to get_default_sid(name, 0, &user_sid).
Since I know too little still about the internals, this is essentially
where I'm lost. If anyone can help me clear this obstacle, I would be
very happy.

If that is of any help, I have uploaded the modified source to
http://selinux.lemuria.org/wdm-1.23-1se1.tar.gz

It should build cleanly on Debian sid or sarge using debian/rules, if
you enable SELinux support in the rules file, just add a line saying 
"--enable-flask \" after the one that says "--enable-pam \". Non-Debian
users can use "./configure --enable-flask" (plus any other options you
might want).



(Why wdm? It's based on xdm with not too many modifications, it's
standalone and fairly small with but few dependencies, and finally 
I'm using windowmaker anyways.)

-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
