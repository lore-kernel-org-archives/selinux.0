Message-Id: <200207251007.KAA10150@jazzswing.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: type_transition init_t xxx_exec_t:process xxx_t
Date: Thu, 25 Jul 2002 12:08:14 +0200
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

in many files is follow rule:

type_transition init_t xxx_exec_t:process xxx_t

but I don't understand why. 
A lot of this rule sets don't start from the init domain. I know that the 
init process start all processes in a linux system. Is that the reason?
On the other side -- in the case of missing this rule by out comment, I 
don't get a error message. Need I this rule?

Thanks 

  Carsten

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
