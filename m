Reply-To: <awilson@tresys.com>
From: "Art Wilson" <awilson@tresys.com>
To: "SELinux" <SELinux@tycho.nsa.gov>
Subject: RE: questions
Date: Mon, 25 Aug 2003 10:54:29 -0400
Message-ID: <AFECILBIKCHPGNOEDGNCGEOHDOAA.awilson@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-2"
In-Reply-To: <1061676714.1648.281.camel@kusturica>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Magosányi, Tresys has developed (and is continuing to develop) a number
of tools for analyzing SELinux policy. These tools are included in the
SELinux distribution, and are also available from www.tresys.com: apol is
the primary policy analysis tool; sepcut allows
you to look at the various policy files and directories; seuser assists in
managing users on an SELinux system.

Art

awilson@tresys.com

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
Behalf Of Magosányi Árpád
Sent: Saturday, August 23, 2003 5:12 PM
To: SELinux
Subject: questions


Hi!

I am experimenting with selinux. My previous experiments included
RSBAC with its RC model. It was (is) a system where there are
multiple chrooted environments, and there is an RC emulation
of Bell&LaPadula within them. Compared to that, the default
selinux configuration is _way_ complicated. Now I am thinking
about implementing either the above setup or a setup which is
a combination of the above and the default policy. I just have to
get in sync, and figure out how one can handle this complexity
in a secure manner. (I guess that constraints will help, but the
whole picture is far from clear.) This is why I have several
questions.

-What tools and techniques exist for analysing the policy?
 For example how can I list domains besides using grep and friends
 on the policy file?
 I am also interested in techniques of analysing and designing MAC
 policies in general, and using TE and RBAC in particular. I presume
 that there is something newer than the Red and Aqua books on the
 issue, but where?

- Is polyinstantiation is put back to selinux yet? Having moldy
 directories based on subject domain would be nice. If not, what
 workarounds exist?

- What about networking? I see that there is nodecon and portcom,
 and someone has written that some networking functionality is
 out because of rejection of the corresponding LSM hooks. Do
 they work? Do we have an iptables context match module?
 Will we?

Thanx.

--
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
