Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA07825
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2001 15:28:49 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA17947
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2001 20:28:43 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id UAA17943
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2001 20:28:42 GMT
Received: from coalstack.epoch.ncsc.mil (coalstack [144.51.25.12])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA27784
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2001 15:28:48 -0500 (EST)
Date: Tue, 6 Feb 2001 15:28:44 -0500 (EST)
From: pal@epoch.ncsc.mil (Pete Loscocco)
Message-Id: <200102062028.PAA03888@coalstack.epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Subject: Re: Selinux kernel patches
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Joshua Brindle wrote:
> I was wondering if there was any effort on your team of developers to
> get your kernel patches submitted to linus for possible inclusion into
> the standard linux source? And also the utility patches, will you be
> trying to submit them to their authors?

We would like very much for our kernel patches to be considered for
inclusion in a future kernel release. We are working toward that goal.
The real goal is to get features such as we have put in Linux accepted
not only in Linux but in other systems as well. We chose Linux because
it not only would increase the security of a popular system but because
it's open development enables it to be a worked example that could be
applied to other systems as well.

We think that we have a good architecture and that it warrants
consideration. We have put it out not as a complete solution but as
something that should be built upon. Inclusion in the "standard"
sources would really enable a much wider audience to work with the
system, gain experience using the security features, and make the
system better.

As for the utility patches, they have never been the focus of the
work.  We have made changes where we found it necessary or useful, but
have yet to make any serious effort to to address all of the user space
issues. If the architecture were to be adopted by the community, we
would probably reexamine that decision and spend more effort on such
things. Until that happens, we probably won't be looking for our
changes to be included with the utility authors.

Pete Loscocco
Information Assurance Research Office
National Security Agency

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
