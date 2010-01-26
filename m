Subject: Re: [refpolicy] Building MLS/MCS policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Guido Trentalancia <guido@trentalancia.com>, refpolicy@oss1.tresys.com,
        selinux@tycho.nsa.gov
In-Reply-To: <1264528350.19890.74.camel@moss-pluto.epoch.ncsc.mil>
References: <201001261546.o0QFkDMJ023435@vivaldi15.register.it>
	 <1264528350.19890.74.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 26 Jan 2010 14:07:00 -0500
Message-ID: <1264532820.2932.63.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-01-26 at 12:52 -0500, Stephen Smalley wrote:
> On Tue, 2010-01-26 at 16:46 +0100, Guido Trentalancia wrote:
> > Stephen,
> > 
> > what I propose is to add a few lines of documentation explaining the process of switching between different policy types (see the two patches below, one for load_policy and the other for the reference policy).
> 
> You should technically separate these patches into separate messages,
> the first directed to selinux list and the second directed to the
> refpolicy list, with your diffs preferably against the respective git
> trees for the two different projects (selinux userland vs. refpolicy).
> But see below first.
[...]
> > diff -pru refpolicy-2.20091117/README refpolicy-2.20091117-new/README
> > --- refpolicy-2.20091117/README 2009-07-14 14:24:46.000000000 +0200
> > +++ refpolicy-2.20091117-new/README     2010-01-26 16:39:13.272185609 +0100
> > @@ -267,3 +267,14 @@ refresh                    Attempts to reinsert all modul
> >  xml                    Build a policy.xml from the XML included with the
> >                         base policy headers and any XML in the modules in
> >                         the current directory.
> > +
> > +5) Switching between different types of policies (e.g. from non-MLS to MLS)
> > +
> > +In order to switch from a non-MLS/non-MCS policy to a MLS or MCS policy
> > +(and viceversa), make sure to change in build.conf not only the TYPE
> > +parameter between the two policies but also the NAME parameter (just name
> > +the new policy differently from the previous one). Also, after building the
> > +new policy, in order to load it for the first time (and eventually install
> > +custom modules), it might be necessary to reboot the kernel in permissive
> > +mode (after having changed the SELinux configuration file to select the
> > +new policy).
> 
> This is up to Chris, but I'd tend to put this information with the
> description of TYPE under the build.conf description rather than as a
> separate item.  And it could be clearer.

I tend to feel that turning on/off MLS support is a general SELinux
thing, so documenting restrictions doesn't belong in the refpolicy docs.

>   Note that if you leave NAME=
> blank then it inherits from TYPE, and thus a mcs or mls policy
> automatically gets a distinct name.

Right.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
