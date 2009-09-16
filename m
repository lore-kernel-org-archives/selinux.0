Date: Wed, 16 Sep 2009 12:50:26 +0200
From: Dominick Grift <domg472@gmail.com>
To: SELinux@tycho.nsa.gov
Subject: Re: SELinux BOFs at LinuxCon and Linux Plumbers Conference
Message-ID: <20090916105023.GA5110@notebook3.grift.internal>
References: <20090915201759.judby7kakg8k8ock@imap.linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
In-Reply-To: <20090915201759.judby7kakg8k8ock@imap.linux.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2009 at 08:17:59PM -0400, debora@linux.vnet.ibm.com wrote:
> Hello,
>
> Bryan Jacobson and myself (both from IBM) have been approved to lead two=
=20
> SELinux BOFs at the upcoming LinuxCon and Linux Plumbers Conference in=20
> Portland, Oregon.  The LinuxCon BOF entitled "How to Keep SELinux Turned=
=20
> On" is scheduled for Tuesday, September 22nd at 11:15 AM.  The Linux=20
> Plumbers Conference BOF entitled "Making SELinux Easier to Use" is set=20
> for Thursday, September 24th at 3:00 PM.
>
> Below are the abstracts for both of the BOFs.  If you are unable to =20
> attend, but have input you would like to share, we would be very =20
> interested in hearing it.
>
> Thanks!
> Debora Velarde
> IBM, Linux Technology Center
>
>
> LinuxCon BOF: How to Keep SELinux Turned On
>
> According to our Linux support team, the number one question they get
> about SELinux is.  How do I turn off SELinux?  This BoF will discuss
> usability problems with SELinux that cause users to turn it off, and
> focus on a small set of near term improvements.
>
> Although many tools for SELinux have been created, there is still a
> perception that SELinux is too complicated to use. How can we change
> that?  We would also like to hear from experienced SELinux users that
> have in depth knowledge of the tools available. Please come share your
> knowledge, concerns, and ideas of what changes you would like to see.
>
In my view SELinux is not nearly as complicated to use as a Linux system th=
at it tries to protect itself. I'd like to consider my myself "experienced =
user", and SELinux helped me better understand how a computer system as com=
plex as Linux is works. I often compare SELinux to netfilter, although both=
 a very much different. The point i am trying to make is that in both there=
 are (atleast) two parts that you have to be aware about to operate it succ=
essfully. As a comparison: With a network firewall like for example Netfilt=
er (framework) and iptables (user space tools) you have to learn how to ope=
rate the tools (iptables). This may seem difficult but what makes it diffic=
ult is that you must also know about networking itself. iptables -A is the =
easy part, what comes after that is harder because it is specific not netwo=
rking. Same for SELinux (framework) and semanage etcetera (user space tools=
). In order to successfully manage a SELinux system you must not only be co=
nfident with the tools (which in my view is the easy part) but you must als=
o be familiar with some of the basics about how a Linux environment works. =
classes, permissions (syscalls), processes and objects etc, you must know t=
he subjects that you are trying to protect. The latter is in my view the ha=
rder part to understand, with or without SELinux. Granted, with SELinux the=
re is also the difficulty that you must connect the link between how a syst=
em works and how SELinux tries to anticipate to that (for example mapping l=
inux logins to SELinux users)

I will admit that there is still (much) room for improvement to make SELinu=
x more user friendly but i think the core issue is education/investment in =
security/responsible computer management. To successfully maintain a comput=
er system you must know how it works and you must take the time to do it ri=
ght. These are in my view the fundamental issues. There is a lot to learn a=
bout a system (which scares people in my view) and there are a lot of objec=
ts and subjects to manage which can take a lot of time)=20

>
>
> Linux Plumbers BOF:  Making SELinux Easier to Use (focus on documentation)
>
> SELinux is often disabled immediately or at the first sign of trouble.
> How can we make SELinux something users actually want to leave on?
>
> Inadequate documentation was recently listed as one of problems
> related to using SELinux on the SELinux mailing list. Although many
> tools for SELinux have been created, there is still a perception that
> SELinux is too complicated to use. This talk will present a list of
> possible documentation improvements that can help change this
> perception.

When i first joined the #selinux irc channel one of my first complaint was =
the lack of documentation. It is easy to blame that. Nowadays i think there=
s plenty docs available (even for free) to learn all about SELinux/Linux. W=
hat in my view is a issue is that parts of it are scathered all over the in=
ternet (maillists, blogs, media articles, manuals, etc) It takes a lot of G=
oogling to put the pieces of the puzzle together, but the pieces are there.=
 I think a central place with urls to all those scathered resources may mak=
e things easier so that people do not have to spend much time to actually f=
ind stuff. selinuxproject.org/user_resources is an attempt to bring that to=
gether. When it comes to policy authoring things get a bit harder to find b=
ut books like SELinux by example should get people started and reference po=
licy is the ultimate reference.

We can spend a lot of time trying to write duplicate manuals but in my view=
 that time can be spend on better things.

Also alot of documentation is fixed on reference policy specifics. Referenc=
e policy is in my view just one configuration. Just like the old "NSA examp=
le policy" it may evolve (and it is constantly evolving) to some much diffe=
rent. In my view spending much words on a single policy(model) is not a goo=
d approach. It is better to understand the basics of SELinux properly, so t=
hat one can figure out *any* policy model on its own. To me it all boils do=
wn to subjects,objects,classes and permissions,constraints,types,roles,secu=
ritylevels,attributes etc. What a specific type allows that can be figured =
out once you know the basics and the problem is in my view is that users ar=
e confronted with issues like: a process cannot use permission execmod on l=
ib_t. Thats just a policy decisions, a property of the policy model. A poli=
cy model has a lot of properties and instead of learning those policy speci=
fic properties, why not go straight to be core so that you can figure out t=
hose yourself.=20

I am not saying that documentation cannot be improved. I am saying that i r=
equires strong will to find all the bits and pieces scathered and put them =
together, and than study it.

What kept me going and kept me interested is the power of control that SELi=
nux provides. Results can be seen directly of a rule you add./not add. I do=
 not see security only as a requirement but i also see it as a way to facil=
itate. I am not solely placing walls to deny access , i am placing them to =
guide subjects in the right direction (and a nice side effect is that there=
 is (usually) no way around the fences)=20

I am at a point where AVC denials do not scare me anymore. What does someti=
mes scare me is the amount of policy//time it takes to fix the issue proper=
ly. One AVC denial can potentially be a trigger to hours of work and hundre=
ds of lines of policy, but i also realize that this is not just because of =
SELinux. It is because a system is complex and SELinux gives me the flexibi=
lity to manage as much as possible. I like that.

Besides, When it comes to security you cannot just ignore parts in my view.=
 You must be able to control as much as possible.

So in short:
1. owners should mandate that operators keep selinux enabled.
2. owners should invest time and resources to educate operators and users.
3. operators should understand the complexity of computer systems and the n=
eed for (optimal) access control.
4. SELinux (documentation) should focus on the framework. Knowledge of the =
framework will help people find there own way to policy model specific prop=
erties.

>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov =
with
> the words "unsubscribe selinux" without quotes as the message.

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkqwwu8ACgkQMlxVo39jgT+rmgCgyWDgr/lWQdS2fiMT6+lnsLVu
k/oAoLw0sT0y+KefzJHq191CuTzRR4Sm
=yf9h
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
