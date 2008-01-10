MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: UNCLASSIFIED - Developing Policies for SELinux on EmbeddedSystems
Date: Thu, 10 Jan 2008 19:16:43 -0000
Message-ID: <7F6B06837A5DBD49AC6E1650EFF5490601C64BEF@auk52177.ukr.astrium.corp>
From: "HAWKER, Dan 2 \(external\)" <Dan.HAWKER@uk4.astrium.eads.net>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "Chad Sellers" <csellers@tresys.com>,
        "Dave Sugar" <dsugar@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > I planned to start with the base reference policy, strip 
> out the bits 
> > we don't need (it only runs our own apps plus the minimum 
> to boot) and 
> > then add policies for our apps. All presuming the relatively old 
> > kernel we are using can handle the ref policy and subsequent 
> > libselinux, etc updates of course.
> 
> You can configure what policy version is generated to match 
> what your kernel supports (as reported by 
> /selinux/policyvers) by setting OUTPUT_POLICY= in build.conf 
> for a monolithic policy build or by setting policy-version= 
> in /etc/selinux/semanage.conf for a modular policy. Looks 
> like 2.6.12 supported policy.19, so it shouldn't be a problem 
> to build such a policy from a modern refpolicy.
> 
> I'm not sure that you need updated libselinux and friends on 
> the target/embedded system as long as you just build a 
> monolithic policy on the build host.
> 
> Not sure what SLIDEremote requires on the target/test box - 
> Chad or Dave can probably speak to that.
> 

Hi Stephen,

Thanks for the guidance, much appreciated :)

Have received an email from Dave explaining some more regarding SLIDE
and SLIDEremote, all useful stuff.

Looks like I've got some long days of policy making ahead of me...  Ah
well, keeps me out of mischief I guess.

Thanks again for the help, will no doubt be back again.

Thanks

Dan


This email (including any attachments) may contain confidential and/or
privileged information or information otherwise protected from disclosure.
If you are not the intended recipient, please notify the sender
immediately, do not copy this message or any attachments and do not use it
for any purpose or disclose its content to any person, but delete this
message and any attachments from your system. Astrium disclaims any and all
liability if this email transmission was virus corrupted, altered or
falsified.
---------------------------------------------------------------------
Astrium Limited, Registered in England and Wales No. 2449259
REGISTERED OFFICE:-
Gunnels Wood Road, Stevenage, Hertfordshire, SG1 2AS, England


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
