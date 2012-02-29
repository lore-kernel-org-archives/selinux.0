Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1TIqtia023335
	for <selinux@tycho.nsa.gov>; Wed, 29 Feb 2012 13:52:55 -0500
Received: by iaoo28 with SMTP id o28so6278061iao.12
        for <selinux@tycho.nsa.gov>; Wed, 29 Feb 2012 10:52:53 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 29 Feb 2012 19:52:53 +0100
Message-ID: <CAPzO=Nyg=3_zgJLkerke29QG4f2Vk=xG=HzsfhsqjoWsGL5yJg@mail.gmail.com>
Subject: setools' seinfo/sesearch and role_attribute support?
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi guys,

Is it possible to update setools (and, more specifically, seinfo and
sesearch to support role_attribute queries as well? I find those two
tools very useful to query the policy, often in search for why certain
things are failing (for instance, see which types match which type
attributes, which user roles can "be in" particular types, etc.

With the 20120215 refpolicy release, role attributes are used
extensively, but there are some quirks here and there that are easily
solved, but might be a bit more challenging to debug if all you have
to debug with are the sources. For instance, I found that
mozilla_plugin_t isn't part of mozilla_roles yet (yes, Chris, I'll
send up the patch later when most of the testing has been done ;-)

If I could do something like:
 ~$ seinfo -tmozilla_t -x
to see that this one is part of mozilla_roles, and
  ~$ seinfo -tmozilla_plugin_t -x
isn't, then I can quickly deduce that this is what I need to patch.

Similarly, using sesearch with --role_source supporting role
attributes would be very nice as well.

Wkr,
  Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
