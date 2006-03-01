Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k21Fx165017510
	for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2006 10:59:01 -0500
Received: from e31.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k21FwxRf014076
	for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2006 15:58:59 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k21Fx0On014284
	for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2006 10:59:00 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k21FuQ6I120466
	for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2006 08:56:26 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k21FwxJg016585
	for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2006 08:58:59 -0700
Date: Wed, 1 Mar 2006 09:58:58 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Kevin Carr <kcarr@tresys.com>
Cc: selinux@tycho.nsa.gov, selinux-dev@tresys.com,
        fedora-selinux-list@redhat.com
Subject: Re: ANN: CDS Framework IDE
Message-ID: <20060301155858.GB28021@sergelap.austin.ibm.com>
References: <200602282316.k1SNGWNq024943@gotham.columbia.tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200602282316.k1SNGWNq024943@gotham.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Kevin Carr (kcarr@tresys.com):
> Tresys has completed an initial version of the CDS Framework IDE tool to
> assist in developing cross domain solutions for SELinux.  The tool consists
> of an IDE with a new high-level language to specify CDS architectures
> focused on the information flow goals of the particular project.  The tool
> generates the necessary SELinux policy from the higher-level specification.
> It is available open source on the Tresys Technology website.  
> 
> http://tresys.com/selinux/index.shtml
> 
> It's is an Eclipse plug-in so just extract the tarball in your plugins
> directory.

Hi,

I was very happy to see these announcements :)

However, when I try to create a new project with either of these
plugins, I get the following errors:

com.tresys.slide.plugin.wizards.NewProjectWizard
com.tresys.framework.plugin.wizards.NewProjectWizard

Never used eclipse before...  dunno if this is user error.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
