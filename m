Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2G5kXHl007078
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2012 01:46:33 -0400
Received: by yhjj72 with SMTP id j72so4384239yhj.12
        for <selinux@tycho.nsa.gov>; Thu, 15 Mar 2012 22:46:32 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 16 Mar 2012 05:46:32 +0000
Message-ID: <CAPweEDzK22daM9ue26tMZ_6HbrFwEZxTfVUXhea31GFO4x0=Qw@mail.gmail.com>
Subject: B2G
From: lkcl luke <luke.leighton@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

allo again: it's been a while since i've been actively been involved
with selinux.

i just wanted to alert people to the proposal that i put forward to
the mozilla B2G team that they consider deploying the FLASK security
model (specifically SE/Linux).
https://wiki.mozilla.org/Apps/Security#FLASK_for_enforcing_permissions
(that's a publicly-editable wiki if anyone wants to comment/edit)

the concept behind B2G is that the xulrunner (gecko) engine is bashed
about and hacked into submission to do double-duty of being *both* a
window manager *and* a web browser, and then applications are defined
as being "a bit of HTML and Javascript".  yeah it's WebOS in disguise,
but they're beginning from the android codebase, ripping out webkit
and all the java (hurraaay!) and dropping in gecko instead.

so they've got quite a big - and cool - task ahead of them, and they
need a replacement for the android security model.  that's where i
went "eyy, i know something that would cope, that would be up to the
job and would mean no linux kernel coding required, it's called
SE/Linux" :)

so i had a couple of questions which would help me to assess the
viability of my own recommendation.

firstly: allo to steven, are you still around? :)

second: did that idea of dynamically allowing bits of binary-compiled
se-linux permissions ever get implemented?  last time i was on this
list (eek, 2004?), the whole SE/Linux precompiled blob was just that:
one huge humungous gelatinous blob that you couldn't mess with, not
without doing a tooootal recompile using the m4 macros.

third: are them happy m4 macros still about? :)  did anyone invent
anything more... oo.. user-friendly shall we say?  i quite liked them
once i got used to it but i'm a bit concerned about the m4 macro
language's obtuseness, if people in the B2G group were to be expected
to cope with them.  or, more to the point, if application developers
were expected to be able to cope.


the reason i ask about 2) above is because the suggestion has come up
that an application may provide a wide and comprehensive set of
functionality (access to the GSM/3G modem as well as access to the
GPS), and users may not wish the application to have both.

so what i figured was that if the selinux permissions were actually
broken down into *three* binary blobs (or as many as are required) it
would save CPU cycles on the device (which is going to be
resource-limited) as well as improving the response time.

so, in the example given, blob 1 would cover most of the app; blob 2
would cover that app's access to the GSM/3G modem and blob 3 would
cover access to the GPS.

what's the story?

warm regards,

l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
