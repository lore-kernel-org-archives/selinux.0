Subject: warning and question: e2fsck
From: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
To: SELinux <SELinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-2
Date: 25 Aug 2003 16:29:08 +0200
Message-Id: <1061821751.1665.700.camel@kusturica>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

Kernel: 2.6.0-test3
relevant configs: ext2 and ext3 support, support with selinux extended
attributes

I have made a make relabel.
After the next reboot, fsck have complained that the extended attribute
is not okay. 
I have made an e2fsck.
It seems that most of my files have been deleted due to it.
e2fsck is from debian sarge

And the question:
How can I avoid it next time besides not fscking?

-- 
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
