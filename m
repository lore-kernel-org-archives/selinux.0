Subject: Re: [selinux] Re: SElinux vs. Grsecruity vs. RSBAC (vs. TrustedBSD?)
From: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
To: Bennett Todd <bet@rahul.net>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20030825170259.GB4409@rahul.net>
References: <FAB2059733EB46409AD28AC957F663F70BEE5C@pusmde04.mt.pweh.com>
	<20030825170259.GB4409@rahul.net>
Content-Type: text/plain; charset=ISO-8859-2
Date: 26 Aug 2003 11:15:39 +0200
Message-Id: <1061889339.1665.1548.camel@kusturica>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

Grsecurity is for those who not really informed in trusted systems,
but need some security. It have some mechanisms to prevent usual
programming errors to escalate (stack protection, chroot protection),
and some security functionality (execution log, acl). I would say
that it is the unix style; it is easily understandable for any unix
admin. You can do domain separation in that model with CAPless
chroots.

RSBAC implements nearly every MAC model which can be found in the
research papers. The models are implemented with the german precision.
It also means that they take little care fo things which are needed
in real life. As they have a big user base (I guess their user base is
the greatest of linux MAC implementations), these shortcomings are
compensated for, to some extent. One example is the polyinstantiation
support, implemented by "moldy symlinks". They now have it for RC (it is
a DTE+RBAC variant), and maybe for
DoD MAC. Actually the main focus is on the RC model twisted with AUTH;
the other model implementations count not much more than reference
implementations (however Amon recently told that he has a user who
insist on using DoD MAC, so that model also have rapidly evolved
recently. I didn't checked it yet, I stick now with an RC approximation
of MAC). Ah, and their JAIL model is also useable to some extent,
only too hardcoded in some aspects.
The main drawback with RSBAC is that german precisity: don't even
think about policy-aware userspace applications (X, rdbms, logging
security attributes from userspace programs, etc). The network
support is better than selinux, but still criminally primitive.
Amon is yet to realize how important the handling of security attributes
in packet filter.

Selinux inside is a flexible security architecture, very well tought
out and the ideas tested for a long time on a fairly modern OS research
kernel implementation. Outside it is a DTE+RBAC variant with user
identities unrelated to the OS uid. So it is fairly close to the most
used RSBAC setup, the biggest conceptual difference being that rsbac
AUTH do connected with unix uid (sometimes a bit inconveniently).
Selinux have a flexible configuration language, with all of its power
to describe and problems to understand. This is partly because the
default policy is very detailed, and cares about nearly all aspects
of the mechanisms of a modern Linux. And yes, selinux have tools to
analize and design the policy (I have yet to try them).
Selinux have a well thought-out userspace API, which makes creating
security-aware applications easy. Actually Selinux in most uses
depends on at least the login mechanism being security-aware.
The drawbacks: lack of polyinstantiation support (once it did have
it in the FLASK microkernel), and that network support is even more
primitive than that of RSBAC. I'm afraid even Stephen is yet to realize
how important the handling of security attributes in packet filter.
It is too much connected to Redhat. It makes an unnecessary
inconvenience for a lot of users; why the userspace changes are given
as srpms instead of patches to the upstream? (I guess this can be drawn
from the fact that the authors are americans; considering other
cultures (like Debian or moslim:) is a bit hard to them.) Fortunately
there are good debian maintainers for the selinux packages.
Not a directly technical but very important consideration: selinux
is the first and yet only MAC model in the upstream kernel, and is
supported by the NSA. It means that selinux have very great probability
to be the winner implementation, like Apache in web servers.

It might be interesting to include TrustedBSD in the comparison, but I
know very few of it. It seems that it is a DoD MAC implementation,
cares about every aspect (like network, polyinstantiation, etc), and
uses all the experience of engineers of "The Only Real Unix" :).
Its drawbacks might be its inflexibility (in SELinux you write a new
security server, and you have implemented a new model), and -for those
who do not like them- that it is DoD MAC, and BSD.
(I might err in the facts above about TrustedBSD).

-- 
GNU GPL: csak tiszta forrásból


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
