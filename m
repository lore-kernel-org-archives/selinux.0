Subject: genfscon problem
From: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-2
Date: 18 Feb 2004 22:09:52 +0100
Message-Id: <1077138592.6667.35.camel@kusturica>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

I have this:
genfscon selinuxfs /user                    object_u:object_r:tcb_mod_t

But my /selinux/user file continues to be tcb_t.

Did I made some mistake or genfscon isn't updated on policy reload?

-- 
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
