Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carsten.grohmann@raumbildsysteme.de>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Remove types from policy and filesystem
Date: Wed, 4 Dec 2002 09:27:55 +0100
MIME-Version: 1.0
Message-Id: <200212040927.55601.carsten.grohmann@raumbildsysteme.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

after I remove a type from the policy and reload the policy I get an error 
about the unkown (removed) type. I'm sure that I don't have labeled files 
with this type at this time. 
It is possible to remove types from the security context database of the 
filesystem, without erase the "...security" directory and complette rebuild 
of the database? I am not sure but I think a "make reset" don't helps.

Carsten

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
