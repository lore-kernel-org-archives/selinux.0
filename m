Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA01720
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 07:28:52 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA18449
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 11:27:56 GMT
Received: from webmail26.rediffmail.com ([202.54.124.130])
	by jazzswing.ncsc.mil  with SMTP id LAA18445
	for <selinux@tycho.nsa.gov>; Thu, 8 Aug 2002 11:27:54 GMT
Date: 8 Aug 2002 11:28:49 -0000
Message-ID: <20020808112849.16449.qmail@webmail26.rediffmail.com>
MIME-Version: 1.0
From: "Samarth  Sharma" <samarth7880@rediffmail.com>
Reply-To: "Samarth  Sharma" <samarth7880@rediffmail.com>
To: selinux@tycho.nsa.gov
Content-type: text/plain;
	format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,
  A security aware application like the sshd daemon acts as an 
object manager for all its related processes..is this correct?? or 
are object managers are a part of the kernel.
  if sshd does act as an object manager who enforces the access 
decisions for the sshd daemon..
  Also if the daemon does act as an object manager does it not 
involve incorporating policy logic in the manager therby violating 
the primary principle of Flask architecture..
  Please clarify
thanks
samarth
__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
