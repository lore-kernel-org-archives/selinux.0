Message-ID: <1252.192.168.1.12.1011612840.squirrel@mail.outstep.com>
Date: Mon, 21 Jan 2002 06:34:00 -0500 (EST)
Subject: Re: restricted guest domain accounts
From: "Lonnie Cumberland" <lonnie@outstep.com>
To: <SELinux@tycho.nsa.gov>
In-Reply-To: <20020121091553.A28411@lemuria.org>
References: <20020121091553.A28411@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I recently had an email from someone asking if I was running X on my
Redhat 7.2 with SELinux and the answer is yes.

I am responding in this way because I have unfortunately lost that
particular email.

the way to get that to work is to edit the policy in the
program/xserver.te and uncomment the 3 lines needed to enable the
ease the xserver restrictions.

Cheers,
Lonnie


-- 
 Lonnie Cumberland
 OutStep Technologies Incorporated
 (313) 832-7366

 URL: http://www.outstep.com
 EMAIL: Lonnie@OutStep.com
      : Lonnie_Cumberland@yahoo.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
