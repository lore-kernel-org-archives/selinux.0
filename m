Date: Thu, 25 Jul 2002 06:47:31 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Carsten Grohmann <carstengrohmann@gmx.de>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: type_transition init_t xxx_exec_t:process xxx_t
In-Reply-To: <200207251007.KAA10150@jazzswing.ncsc.mil>
Message-ID: <Pine.GSO.4.33.0207250635500.10347-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 25 Jul 2002, Carsten Grohmann wrote:

> in many files is follow rule:
>
> type_transition init_t xxx_exec_t:process xxx_t
>
> but I don't understand why.
> A lot of this rule sets don't start from the init domain. I know that the
> init process start all processes in a linux system. Is that the reason?
> On the other side -- in the case of missing this rule by out comment, I
> don't get a error message. Need I this rule?

These rules are included to cover the case where the SELinux module is
dynamically loaded into a running kernel rather than being built-in.
Although we don't recommend such usage due to the difficulty in
determining the right security attributes for pre-existing processes and
objects, the SELinux module does provide some degree of support for it.
This is discussed in the module technical report.  The type_transition
init_t ... rules are needed because the process may have been reparented
to init by the time the SELinux module is inserted.

If you always intend to use SELinux as a built-in module (recommended),
then you can safely remove these type_transition init_t ... rules.
Notice that in any case where init truly starts the process, there must be
a full domain_auto_trans(init_t, ...) rule to authorize it.  Hence, when
you see a type_transition init_t ... rule by itself, it is only for the
purpose of labeling pre-existing processes when SELinux is dynamically
inserted.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
