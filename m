Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA19377
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 18:57:52 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA21905
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 22:56:55 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA21901
	for <selinux@tycho.nsa.gov>; Fri, 9 Aug 2002 22:56:54 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Ryan Bergauer" <privateryan@mindspring.com>, <selinux@tycho.nsa.gov>
Subject: Re: problems with fd
Date: Sat, 10 Aug 2002 00:57:38 +0200
References: <001b01c23ff4$8081b730$0300a8c0@donkey>
In-Reply-To: <001b01c23ff4$8081b730$0300a8c0@donkey>
MIME-Version: 1.0
Message-Id: <20020809225739.47F6C84DD@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 10 Aug 2002 00:31, Ryan Bergauer wrote:
> The gpg command in question is 'gpg --gen-key', being run from the
> console as (in the case of system_u:system_r:local_login_t) a normal
> user in user_r and (in the case of user_name:sysadm_r:newrole_t) a
> sysadm that newroled into the user_r role.

allow $1_gpg_t privrole:fd use;

I was not able to reproduce the problem with local_login_t.  I was able to 
reproduce the problem with newrole_t and added the above rule in the 
gpg_domain() macro in the  policy/macros/program/gpg_macros.te file to solve 
it.


Russell Coker

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
