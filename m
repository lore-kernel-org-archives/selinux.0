Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBN3eRRb025259
	for <selinux@tycho.nsa.gov>; Mon, 22 Dec 2003 22:40:27 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBN3eQpn004903
	for <selinux@tycho.nsa.gov>; Tue, 23 Dec 2003 03:40:26 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hBN3ePab004851 for <selinux@tycho.nsa.gov>; Tue, 23 Dec 2003 03:40:25 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Yuichi Nakamura <himainu_ynakam@yahoo.co.jp>, selinux@tycho.nsa.gov
Subject: Re: Apache on FedoraCore1(Was Re: log_domain macro)
Date: Tue, 23 Dec 2003 14:38:59 +1100
References: <3FE6EA56.7010708@redhat.com> <200312230005.hBN05Mab000127@jazzband.ncsc.mil>
In-Reply-To: <200312230005.hBN05Mab000127@jazzband.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312231438.59305.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 23 Dec 2003 11:01, Yuichi Nakamura <himainu_ynakam@yahoo.co.jp> wrote:

I have added most of your patches to my tree, however I moved the type 
definition for the /etc/krb5.conf file to file.fc and types.fc (most people 
who use Kerberos won't use Apache on all servers).  We probably should make a 
separate kerberos_client.te file or something.  But for the moment I've stuck 
the allow and dontaudit rules in apache.te (it's easy to change them later).

allow httpd_t httpd_t:netlink_socket { bind create getattr read write };
What is the reason for the above?


I've put a new policy archive on http://www.coker.com.au/selinux/policy.tgz 
which contains this and some other changes (including some resulting from 
apparent differences between 2.6.0-test11 and 2.6.0 kernels).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
