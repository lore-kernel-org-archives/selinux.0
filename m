From: "Kevin Carr" <kcarr@tresys.com>
To: "=?iso-8859-1?B?J01hZ29z4W55aSDBcnDhZCc=?=" <mag@bunuel.tii.matav.hu>,
   "'SELinux'" <SELinux@tycho.nsa.gov>
Subject: RE: questions
Date: Mon, 25 Aug 2003 08:58:15 -0400
Message-ID: <001101c36b08$8c5ab0d0$8700a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1061676714.1648.281.camel@kusturica>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Regarding your question:

-What tools and techniques exist for analysing the policy?
-For example how can I list domains besides using grep and friends
-on the policy file?

Tresys Technology is in ongoing development of a set of tools for
analyzing policies.  You can download the source from to following URL:
http://www.tresys.com/selinux_policy_tools.html.  The current version
has domain transfer analysis among other stuff.  We will be releasing a
newer version soon which will have some other great features.

-Kevin

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On Behalf Of Magosányi Árpád
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
