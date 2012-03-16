Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2GELYcj014015
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2012 10:21:34 -0400
Message-ID: <4F634C6B.2090804@tresys.com>
Date: Fri, 16 Mar 2012 10:21:31 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: lkcl luke <luke.leighton@gmail.com>
CC: <selinux@tycho.nsa.gov>
Subject: Re: B2G
References: <CAPweEDzK22daM9ue26tMZ_6HbrFwEZxTfVUXhea31GFO4x0=Qw@mail.gmail.com>
In-Reply-To: <CAPweEDzK22daM9ue26tMZ_6HbrFwEZxTfVUXhea31GFO4x0=Qw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/16/12 01:46, lkcl luke wrote:
> second: did that idea of dynamically allowing bits of binary-compiled
> se-linux permissions ever get implemented?  last time i was on this
> list (eek, 2004?), the whole SE/Linux precompiled blob was just that:
> one huge humungous gelatinous blob that you couldn't mess with, not
> without doing a tooootal recompile using the m4 macros.

Yes, we do have modular policy now.  Right now they are compiled, but hopefully we'll eventually be able to set to text modules.  You compile .pp files that have some compiled policy and optional a .fc, and link them together into the policy.2x
 
> third: are them happy m4 macros still about? :)  did anyone invent
> anything more... oo.. user-friendly shall we say?  i quite liked them
> once i got used to it but i'm a bit concerned about the m4 macro
> language's obtuseness, if people in the B2G group were to be expected
> to cope with them.  or, more to the point, if application developers
> were expected to be able to cope.

Yes.  In a very different form than the NSA example policy: http://oss.tresys.com/projects/refpolicy

Hopefully CIL will be completed, as that will make it possible to make Reference Policy a proper language and most if not all of the M4 will be dropped. http://userspace.selinuxproject.org/trac/wiki/CilDesign

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
