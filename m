Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2G7ec2D011498
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2012 03:40:38 -0400
Message-ID: <4F62EE4B.7090600@itechfrontiers.com>
Date: Fri, 16 Mar 2012 03:39:55 -0400
From: "Patrick K., ITF" <cto@itechfrontiers.com>
MIME-Version: 1.0
To: lkcl luke <luke.leighton@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: B2G
References: <CAPweEDzK22daM9ue26tMZ_6HbrFwEZxTfVUXhea31GFO4x0=Qw@mail.gmail.com>
In-Reply-To: <CAPweEDzK22daM9ue26tMZ_6HbrFwEZxTfVUXhea31GFO4x0=Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 3/16/2012 1:46 AM, lkcl luke wrote:
 > allo again: it's been a while since i've been actively been involved
 > with selinux.
 >
 > i just wanted to alert people to the proposal that i put forward to
 > the mozilla B2G team that they consider deploying the FLASK security
 > model (specifically SE/Linux).
 > https://wiki.mozilla.org/Apps/Security#FLASK_for_enforcing_permissions
 > (that's a publicly-editable wiki if anyone wants to comment/edit)
 >

Sounds great, but wouldn't it be more proper to call Flask a Security 
Architecture rather than a Security model?

Since Flask (Flux Advances Security Kernel) tends to be a security 
architecture,  Making it possible to implement various security models 
(Schemes and plans for deploying and enforcing security policies)  such 
as Mandatory Access Control (MAC), RBAC (Role Based Access Control), MLS 
(Multi Level Security), it is even possible to implement Biba (although 
SElinux permits exemptions), Bell-LaPadula Models and so on so forth

anyway SELinux is technically an implementation of Mandatory access 
control based on Flask Architecture.

 > the concept behind B2G is that the xulrunner (gecko) engine is bashed
 > about and hacked into submission to do double-duty of being *both* a
 > window manager *and* a web browser, and then applications are defined
 > as being "a bit of HTML and Javascript".  yeah it's WebOS in disguise,
 > but they're beginning from the android codebase, ripping out webkit
 > and all the java (hurraaay!) and dropping in gecko instead.
 >
 > so they've got quite a big - and cool - task ahead of them, and they
 > need a replacement for the android security model.  that's where i
 > went "eyy, i know something that would cope, that would be up to the
 > job and would mean no linux kernel coding required, it's called
 > SE/Linux" :)

Have you seen this page?  SEAndroid

http://selinuxproject.org/page/SEAndroid



 >
 > so i had a couple of questions which would help me to assess the
 > viability of my own recommendation.
 >
 > firstly: allo to steven, are you still around? :)
 >
 > second: did that idea of dynamically allowing bits of binary-compiled
 > se-linux permissions ever get implemented?  last time i was on this
 > list (eek, 2004?), the whole SE/Linux precompiled blob was just that:
 > one huge humungous gelatinous blob that you couldn't mess with, not
 > without doing a tooootal recompile using the m4 macros.
 >


Excuse me do you mean changing roles or policies on the fly in userland? 
Wouldn't that violate Security models and policies in example MAC, RBAC, 
MLS and anything mandatory?

anyway semanage permits changing some aspects of the policies without 
recompiling them,

# man semanage

"semanage  is used to configure certain elements of SELinux policy 
without requiring modification to or recompilation from policy sources."


 > third: are them happy m4 macros still about? :)  did anyone invent
 > anything more... oo.. user-friendly shall we say?  i quite liked them
 > once i got used to it but i'm a bit concerned about the m4 macro
 > language's obtuseness, if people in the B2G group were to be expected
 > to cope with them.  or, more to the point, if application developers
 > were expected to be able to cope.
 >

I'm afraid it is there, M4 I meant,

SELinux policies have been turned into click and click  GUI ?!,

NO,

at least not to what I think that you think :-) but there are policy 
editors out there, such as:

http://magazine.redhat.com/2007/08/21/a-step-by-step-guide-to-building-a-new-selinux-policy-module/

or

http://seedit.sourceforge.net/



 >
 > the reason i ask about 2) above is because the suggestion has come up
 > that an application may provide a wide and comprehensive set of
 > functionality (access to the GSM/3G modem as well as access to the
 > GPS), and users may not wish the application to have both.
 >
 > so what i figured was that if the selinux permissions were actually
 > broken down into *three* binary blobs (or as many as are required) it
 > would save CPU cycles on the device (which is going to be
 > resource-limited) as well as improving the response time.
 >
 > so, in the example given, blob 1 would cover most of the app; blob 2
 > would cover that app's access to the GSM/3G modem and blob 3 would
 > cover access to the GPS.
 >

I suppose you are proposing Role Based Access Control, assigning 
different roles to their appropriate modules.

May be you want to take a look here:

http://selinuxproject.org/page/SEAndroid

and here:

http://www.selinuxproject.org/page/Main_Page

 > what's the story?
 >
 > warm regards,
 >
 > l.
 >
 > --
 > This message was distributed to subscribers of the selinux mailing list.
 > If you no longer wish to subscribe, send mail to 
majordomo@tycho.nsa.gov with
 > the words "unsubscribe selinux" without quotes as the message.


Patrick K.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
