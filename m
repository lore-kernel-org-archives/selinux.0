Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBEHnFvs007860
	for <selinux@tycho.nsa.gov>; Mon, 14 Dec 2009 12:49:18 -0500
Received: from e9.ny.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nBEHpdJE018956
	for <selinux@tycho.nsa.gov>; Mon, 14 Dec 2009 17:51:39 GMT
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBEHgjfu017697
	for <selinux@tycho.nsa.gov>; Mon, 14 Dec 2009 12:42:45 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id nBEHnGxU077604
	for <selinux@tycho.nsa.gov>; Mon, 14 Dec 2009 12:49:16 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id nBEHnF8F017201
	for <selinux@tycho.nsa.gov>; Mon, 14 Dec 2009 12:49:16 -0500
Date: Mon, 14 Dec 2009 11:49:15 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: Dominick Grift <domg472@gmail.com>, fedora-selinux-list@redhat.com,
        SE Linux <selinux@tycho.nsa.gov>, Kathy Shonaiya <Shonaiya@tresys.com>
Subject: Re: The SELinux Documentation Project
Message-ID: <20091214174915.GA14651@us.ibm.com>
References: <4AC1130D.8000601@manicmethod.com>
 <4B103712.2050709@manicmethod.com>
 <4B1114E9.7060806@gmail.com>
 <4B1175BA.1060604@manicmethod.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4B1175BA.1060604@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Joshua Brindle (method@manicmethod.com):
> Dominick Grift wrote:
> >On 11/27/2009 09:31 PM, Joshua Brindle wrote:
> >>Joshua Brindle wrote:
> >>>As we discussed at Linux Plumbers Conference during the 'Making SELinux
> >>>Easier to Use" talk we have some document deficiencies in the SELinux
> >>>project.
> >>>
> >><snip>
> >>
> >>We have gotten some good contributions to the documentation project over
> >>the last couple months but there is always more to do. I've updated the
> >>Documentation TODO at:
> >>
> >><http://selinuxproject.org/page/Documentation_TODO>
> >>
> >>with some docs we'd like written and some guidance on what the format
> >>should be. Use cases would be particularly appreciated.
> >>
> >>If you haven't gone to the documentation wiki lately take a look at
> >>
> >><http://selinuxproject.org/page/Main_Page>
> >>
> >>and see what's been added.
> >>
> >>Thanks for the help of the contributors and hopefully this effort will
> >>go a long way toward gaining users and keeping SELinux enabled.
> >>
> >>--
> >>fedora-selinux-list mailing list
> >>fedora-selinux-list@redhat.com
> >>https://www.redhat.com/mailman/listinfo/fedora-selinux-list
> >
> >Attached is a concept i wrote today about Locking down webapps with CGI.
> >This was a topic in the todo list.
> >
> >Would be nice if someone could proof-read this and when
> >modified/accepted publish it.
> 
> It's a wiki :) Just put it up there and others can make

How are we to create an account to edit a page?  The 'Log in/Create
Account' page doesn't seem to let me create an account?

I'd like to add the recipe

        useradd xa
	semanage user -a -R user_r xa
	semanage login -a -s xa xa

to lock user xa into its own selinux context to the recipes page.
If someone else is willing to post it, all the better.

> modifications. There are actually a couple people who are decent at
> copy editing that have done some work on the wiki so if we get
> technical content up there they can do what they do to clean it up.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
