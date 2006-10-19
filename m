Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9JF0S2w007410
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 11:00:28 -0400
Received: from mailgate1.arcor-ip.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9JExjwO008449
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 14:59:46 GMT
Received: from relay.brunellocal.de (ffmcospub2ffmbrunelfw2lo-cs-nat-mail-server.adm.arcor.net [145.254.28.157])
	by mailgate1.adm.arcor.net (Arcor-CN-MailRelay-l-A) with ESMTP id D64AF1AC19D
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 17:00:26 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
	by relay.brunellocal.de (Postfix) with ESMTP id 298D355C4
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 15:00:25 +0000 (UTC)
Received: from relay.brunellocal.de ([127.0.0.1])
 by localhost (relay.brunellocal.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 05450-04 for <selinux@tycho.nsa.gov>;
 Thu, 19 Oct 2006 17:00:24 +0200 (CEST)
Received: from mail-hv.brunel.de (mail-hv.brunellocal.de [192.168.1.234])
	by relay.brunellocal.de (Postfix) with ESMTP id 8BAAE55B4
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 17:00:24 +0200 (CEST)
From: Daniel Gil Mayol <Daniel.Gil-Mayol@brunel.de>
To: selinux@tycho.nsa.gov
Subject: Policy tests failed
Date: Thu, 19 Oct 2006 17:00:19 +0200
MIME-Version: 1.0
Message-Id: <200610191700.20138.Daniel.Gil-Mayol@brunel.de>
Content-Type: text/plain;
  charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am writting a policy over a RHEL4 customized kernel. I want to extend the 
current targeted policy (there are some new services to define a policy).

I want to test the policy, that is, the services should not have access 
(read/write/execute) to data that are not allowed. 
So I have written a script "exectest.py" labelled with a security context 
"system_u:object_r:XXX_t" where "type XXX_t, file_type;".

Lets say that we are testing the service "crond", so I execute "exectest.py 
crond". The first that do this script is execute an "id" and become the next:

uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6
(disk),10(wheel) context=root:system_r:unconfined_t

Then the script try to read, write and execute files out of "crond_t" domain, 
that is, files labelled with types that I haven't allowed (for example bin_t, 
httpd_t). And the result is that it can.

I have tried also to write in the policy for example "neverallow crond_t 
bin_t : file { read write execute };" but still can access to these data.

When I execute this script, which domain it has? 
Can it be that it works in the unconfined domain and it has access to 
everything?

Thanks

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
