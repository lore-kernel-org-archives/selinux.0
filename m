Message-Id: <200208142211.WAA00113@jazzswing.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: security_t:security compute_av
Date: Thu, 15 Aug 2002 00:12:22 +0200
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

I found follow rule in the crond and fcrond rules. 

allow crond_t security_t:security compute_av;

But I don't found enough about it. Only the type declaration in 
policy/types/security and other little things. I missing something a 
documentation the object classes and the permissions.

Can anybody give me a hint in which documentation I can found more.

Thanks

  Carsten

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
