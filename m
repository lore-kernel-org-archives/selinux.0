Message-ID: <2700.165.247.144.4.1070315301.squirrel@webmail.servalens.com>
Date: Mon, 1 Dec 2003 13:48:21 -0800 (PST)
Subject: Future of selinux/lsm
From: selinux@servalens.com
To: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

I read that LSM was being pulled from the 2.6 kernel. Is this true?
If so, does that mean SELinux will move back to the kernel patch model?
I am looking for some strategic guidance for a deployment planning.
The choice would be maintaining a patched 2.4x kernel or going bleeding
edge with a 2.6 kernel.

So choice would be:
2.4x (LSM Patch + SELinux)
2.4x (SELinux patch) [I realize this may have been discontinued with the
rewrite for LSM, but again I wonder what the future will bring if LSM were
not part of the standard 2.6 kernel]
2.6x (SELinux builtin)

My preference would be to deploy whatever will the mainstream and receive
the most development effort and deployment experience.

Thank you.

Robert



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
