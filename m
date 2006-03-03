Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k23K6jZc015555
	for <selinux@tycho.nsa.gov>; Fri, 3 Mar 2006 15:06:49 -0500
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k23K6hUU013798
	for <selinux@tycho.nsa.gov>; Fri, 3 Mar 2006 20:06:43 GMT
Message-Id: <200603032006.k23K6LNq015906@gotham.columbia.tresys.com>
From: "Kevin Carr" <kcarr@tresys.com>
To: "'Serge E. Hallyn'" <serue@us.ibm.com>
Cc: <selinux@tycho.nsa.gov>, <selinux-dev@tresys.com>,
        <fedora-selinux-list@redhat.com>
Subject: RE: ANN: CDS Framework IDE
Date: Fri, 3 Mar 2006 15:06:21 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20060301155858.GB28021@sergelap.austin.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I was very happy to see these announcements :)
> 
> However, when I try to create a new project with either of these
> plugins, I get the following errors:
> 
> com.tresys.slide.plugin.wizards.NewProjectWizard
> com.tresys.framework.plugin.wizards.NewProjectWizard
> 
> Never used eclipse before...  dunno if this is user error.

It looks like these errors are because of an older version of eclipse.  Both
tools require Eclipse 3.1.  

On another note, I updated the Tresys Technology website to include some
installation instructions for the CDS Framework IDE.  Also I posted a newer
tarball for the CDS tool that fixes some issues we found yesterday.  Please
get the newer release and try that one.

http://tresys.com/selinux

Kevin Carr
Tresys Technology
410.290.1411 x137



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
