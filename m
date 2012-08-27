MIME-Version: 1.0
Date: Mon, 27 Aug 2012 13:15:58 +0300
Message-ID: <CALrft9_xxAFyNCgfovcpjc0EjTSfDPE6UxECOB1UDQYREMP5WQ@mail.gmail.com>
Subject: Unified set of RPM security hooks for different LSMs
From: Elena Reshetova <elena.reshetova@gmail.com>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

My name is Elena Reshetova, currently I am working for Intel on the
Tizen OS, where we are using Smack LSM for platform access control and
RPM is our package manager.
We have the same need as SELinux to bootstrap the smack policies  for
applications coming in rpm packages.
We have an rpm plugin that performs rule creation, file labelling,
device policy check and other related tasks.
If you are interested, you can read more about it here:
https://wiki.tizen.org/wiki/Security/Application_installation_and_Manifest

Unfortunately currently we have to use our own set of hooks inside rpm
for the plugin, because we are using/planning to use more hooks than
currently available in SELinux implementation.
You can see the hook description here:
https://github.com/ereshetova/rpm/wiki/Security-Hooks-for-rpm

I think it would be very beneficial for everyone if we can define a
single security plug-in interface for RPM and then adopt our
implementations to use it. I have written to rpm maintainer about this
before and he also agreed that having one interface for all LSMs in
rpm is a good idea.
Finally the code for our plugin and hooks is located here:
https://github.com/ereshetova/rpm/tree/security-changes
I am trying to keep it rebased to latest rpm and also include the
changes I am constantly making for Tizen (we are still on 4.9.1
unfortunately L).

I am also having a talk at Linux Security Summit this week to show
what we have done for Smack in rpm and promote a creation of
unification interface for it.
Would you be interested to work together in defining the unified set of hooks?

I have tried to contact Steve Lawrence (at slawrence@tresys.com) who
introduced the current SELinux-related functionality to rpm, but
without any success so far.


Best Regards,
Elena.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
