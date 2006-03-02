Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k22AhSCb006693
	for <selinux@tycho.nsa.gov>; Thu, 2 Mar 2006 05:43:31 -0500
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k22Afwd7002443
	for <selinux@tycho.nsa.gov>; Thu, 2 Mar 2006 10:41:58 GMT
Subject: Re: FYI SELinux/AppArmor press
From: Erich Schubert <erich@debian.org>
To: Chad Sellers <csellers@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Kevin Carr <kcarr@tresys.com>,
        selinux-dev@tresys.com
In-Reply-To: <44065CB2.5080500@tresys.com>
References: <43FF7418.90205@redhat.com>
	 <1141138934.29803.2.camel@wintermute.xmldesign.de>
	 <1141183226.8475.22.camel@localhost.localdomain>
	 <1141222338.2834.33.camel@wintermute.xmldesign.de>
	 <d82d6db50603011259s3fe0e80duca501a9c7925c661@mail.gmail.com>
	 <1141250441.2834.62.camel@wintermute.xmldesign.de>
	 <44065CB2.5080500@tresys.com>
Content-Type: text/plain
Date: Thu, 02 Mar 2006 11:43:27 +0100
Message-Id: <1141296207.17082.12.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Chad,
In my opinion, the SELinux security policy should be done using a real
OOP paradigma, not this "imperative" like set of rules we have right now
(M4 is imperative...)
In an ideal case, people could write SELinux policies using UML
modelers.
I'm not a big fan of Java and UML, but I think it helps people a lot.

We had some OOP-like elements alaredy - "sysadmfile" and similar type
flags we had in the old nsa policy.

I'd imagine a good policy language to be like this:
---
type system_logfile : public system_file {
	public interface read { ... }
	public interface write { ... }
	public interface append { ... }
	public interface manage { ... }
}

type amavis_logfile : public system_logfile {
	match "/var/log/amavis.*"
	/* will inherit interfaces by system_logfile */
}

type amavisd_exec : public system_executable_file {
	match "/usr/sbin/amavisd.*"

	interface execTransition { ... }
}

type amavisd : public network_daemon {
	interface sendTo { ... }
}

rules amavisd {
	allow appendTo amavis_logfile
}

rules initrc {
	allow execTransition amavisd_exec
}
---

I'm no language designer, and no usability expert... but I think the
policy language should avoid unnecessary repetition as far as possible
and follow modelling paradigmas people already know such as inheritance.

best regards,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
 Why waste time learning, when ignorance is instantaneous? --- Calvin //\
              Es lohnt sich nicht, die Augen aufzumachen,             V_/_
                     wenn der Kopf im Sand steckt.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
