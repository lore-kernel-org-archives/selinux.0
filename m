Message-ID: <4FFCC3C7.8080602@tresys.com>
Date: Tue, 10 Jul 2012 20:07:35 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: <selinux@tycho.nsa.gov>
Subject: seandroid and policy version
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was looking at this:
<https://android-review.googlesource.com/#/c/36321/4/init/init.c>

and remembered that years ago we had a discussion about the .policyver 
filename syntax. I kind of get it for SELinux machines where there is 
managed policy and could be multiple policies on the system but since 
SEAndroid is targeting non-device managed policies, it adds extra code 
to search for the right extension and you can tell what version the 
policy is as soon as you open it, why not ditch the suffix?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
