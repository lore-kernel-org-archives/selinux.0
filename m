Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA03637
	for <selinux@tycho.nsa.gov>; Thu, 23 Aug 2001 14:44:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA13615
	for <selinux@tycho.nsa.gov>; Thu, 23 Aug 2001 18:43:19 GMT
Received: from robin.mail.pas.earthlink.net (robin.mail.pas.earthlink.net [207.217.120.65])
	by jazzswing.ncsc.mil  with ESMTP id SAA13611
	for <selinux@tycho.nsa.gov>; Thu, 23 Aug 2001 18:43:19 GMT
Received: from zion (CBL-dataefx.hs.earthlink.net [207.217.173.155])
	by robin.mail.pas.earthlink.net (8.11.5/8.9.3) with SMTP id f7NIiWG01710
	for <selinux@tycho.nsa.gov>; Thu, 23 Aug 2001 11:44:32 -0700 (PDT)
From: "JohnScroggins" <dataefx@earthlink.net>
To: <selinux@tycho.nsa.gov>
Subject: FW: New Development Site
Date: Thu, 23 Aug 2001 11:37:40 -0700
Message-ID: <AGEMJJFIEKIAAOJCCEIGCEGICEAA.dataefx@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



-----Original Message-----
From: JohnScroggins [mailto:dataefx@earthlink.net]
Sent: Wednesday, August 22, 2001 12:50 PM
To: Forrest Whitcher
Subject: RE: New Development Site



John,

I have to echo Jonathan's comments, a few thoughts.

I know Sourceforge is 'the common thing' today, however my personal
experience has been that it's not a great tool, and I've not been
impressed with the mailing lists etc.

This will be the first time for me, so I can't speak with any authority.. :)

Have you discussed this with the NAI/NSA developers?

I have been in contact with (today, in fact) Stephen Smalley, over at NAI.
He supports the idea, but noted that when the S/F site went up initially, he
had provided some input. He is also in favor of public participation in
furthering the project, but noted that there may be issues taken, but his
post was encouraging, which lets me know that we may be on the right track.

creating devel;discuss;announce lists is duplicative of the nsa sponsored
list (which seems to not have enough traffic to warrant 3 tracks in any
case).

This is true, but I noticed one time there was an OT post, and shortly
thereafter there was a warning issued. That caught my attention real quick,
since I subscribe to a lot of mailing list. I would like to promote some
community participation with out letting topics go over the edge (non-dev
prattle).

Last, would LSM not be the better place to have people focussing?

I have been lurking on the LSM list almost from its inception, the traffic
is like the fast lane of the Autobahn  :) I have not figure out a place
where I can help, let alone suggest it to others. If there is something I
missing here (and I'm sure there is), or a way to help out, I am open to
suggestions.

a. folks who need ready to run solutions today are better off with
something like Immunix anyway

I've run Immunix 6.2, and was impressed, but I believe that SELinux has its
place also..

b. As I understand it LSM will be the actual delivery environment for
future work on SElinux. I don't think it's wise for people to be putting
a lot of effort into the monolithic version, as it's likely to be
dead-branch.

Talking with S. Smalley, I inquired about the next release with LSM
incorporated. It should be out soon. I am waiting to see the new feature
set.

c. Per the recent development history of SEL, the number of user-contrib
patch opportunities looks tiny. The only significant thing I've seen was
Rajan Ravindran's scalability analysis and modifications. (a very nice
piece of work, that).

That is what I want to change, more tools, docs and support accessories.

d. As it stands, for those who have the time to develop a security
policy and implement it in the SEL rules format etc, I think SEL is
ready for prime-time in its current form. Again, this suggests to me
the 'better' place to focus effort is on the LSM?

The dev I'm focused on are the items above.. again, if there are areas that
are unattended in the LSM project which my information development skills
can be used in let me know.

And to that last, I was very glad to hear that you are working on
a book on SEL operation ... (can you send me the TOC? I saw commentary
emails, but never the original work).

I can send it to tarred up.. or forward the html page(s) ?

For my use (and I *think* that of most SEL implementors) work on
developing configuration models and tools seems very high value added.

That is my focus in getting people working on this, not kernel related
stuff, but the things that will make your life a little easier..

Thanks -- let me know how you want the TOC.

thanks, best regards

forrest



JohnScroggins wrote:
>
> In an effort to promote additional participation in developing SELinux and
> the associated tools,  we have set up a development site
> http://sourceforge.net. This site is a mirror of the NSA's web site, with
> the added extra of providing a collaborative developer environment. In
> addition, we have set up 3 mailing list that will be available in a few
> hours.
>
> selinux-devel: for development related issues, coding requirements,
on-going
> development tasks, testing, etc.
>
> selinux-discussion: for general questions related to SELinux, such as
> possible deployment scenarios, documentation suggestions, tool suggestions
> (installer, policy configuration tools)
>
> selinux-announce: This list will be a moderated list which provides timely
> announcement regarding  cvs-tree updating, new tool releases, and any
> updated information from the NSA's web site that affects the status of the
> project.
>
> >From this site you will be able to carry on discussions in a forum,
submit
> suggestions for the project (which will be logged for your review), assist
> in task as related to your skill set. You will also have the access to the
> source code via CVS.
>
> I have talked with Mark Westerman (he set up the project site a few months
> ago), and we believe this move is timely, with your continued support,
this
> transition will expedite development and generate more interest in a
secure
> Linux platform.
>
> Remember, if you know of someone that is deploying Linux in a hostile
> environment, tell them about this project, and/or have them join one of
the
> mailing lists.
>
> If you would like to work as a developer on this project, set up a user
> account at Sourceforge and email your user name to Chris Mahmood, or
myself,
> and we will add you to the developers. (please note the task(s) that you
can
> assist in, programming, scripting, testing, etc.)
>
> Christopher Mahmood
> ckm@suse.com
>
> John Scroggins
> dataefx@earthlink.net
>
> <<Disclaimer mode ON//>>
> This is in no way an attempt to minimize the participation in the NSA's
> project, nor an effort to reroute mail traffic. This is an attempt to
> generate additional public participation in the development of SELinux.
> <<Disclaimer mode OFF//>>
>
> Thanks, and we look forward to seeing you at Sourceforge
>
> John
>
> p.s. If the move to Sourceforge will inhibit your participation in the
> discussions, and/or development process please let us know, or if you have
a
> better suggestion for a collaborative site forward the information for
> consideration.  This is a community effort, without the community, well,
you
> know :)
>
> --
> You have received this message because you are subscribed to the selinux
list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
> the words "unsubscribe selinux" without quotes as the message.

--
Forrest Whitcher    Principal      FW Systems
617.254.3506                       fw@fwsystems.com
fw@world.std.com                   6174803245@mobile.att.net
Information systems consulting     http://www.fwsystems.com


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
