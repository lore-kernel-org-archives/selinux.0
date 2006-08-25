Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7PLPD4W002344
	for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2006 17:25:14 -0400
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7PLOdP8009978
	for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2006 21:24:39 GMT
Date: Fri, 25 Aug 2006 23:24:01 +0200
From: Erich Schubert <erich@debian.org>
To: Salvo Giuffrida <giuffsalvo@hotmail.it>
Cc: selinux@tycho.nsa.gov
Subject: Re: Users
Message-ID: <20060825212401.GA6260@wintermute.xmldesign.de>
References: <BAY114-F8DE042F4A120882ADBA3EAF450@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BAY114-F8DE042F4A120882ADBA3EAF450@phx.gbl>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Salvo,
> the domain/type of the subject/object, to take his decision...So, what's 
> the use of the user part?

Which roles are acceptable.
A user logged in as user_u for example can never become sysadm_r. unless
there is a way for him to switch his identity too, that is.
The only identity switch I'm aware of is sysadm_u -> system_u when
running init scripts IIRC.

The roles work the same way, they define which types are acceptable. The
question I don't know the answer to is why we have these three levels,
and not four or two or whatever. ;-)
Probably because they suit our mind model best.
user identity, role, application domain

Regards,
Erich Schubert
-- 
     erich@(mucl.de|debian.org)      --      GPG Key ID: 4B3A135C      (o_
      This one's tricky. You have to use imaginary numbers, like       //\
                       eleventeen... --- Hobbes                        V_/_
 Nur der ist weise, der weiss, dass er es nicht ist. --- Sokrates

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
