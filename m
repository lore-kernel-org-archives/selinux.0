Subject: Logging the target?
From: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-2
Date: 16 Feb 2004 17:36:27 +0100
Message-Id: <1076949388.10004.14.camel@kusturica>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

Is there a way to figure out the target object of a deny?
An example: when I done an exec("/bin/bash") it was denied
by my policy, because some library files was not the right
type. It would spare me 2 reboots if the actual target would be stated
in the logs.

-- 
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
