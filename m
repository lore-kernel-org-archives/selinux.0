Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0SKhoXX022956
	for <selinux@tycho.nsa.gov>; Mon, 28 Jan 2008 15:43:50 -0500
Received: from web36608.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m0SKhmbA009131
	for <selinux@tycho.nsa.gov>; Mon, 28 Jan 2008 20:43:49 GMT
Date: Mon, 28 Jan 2008 12:43:07 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: OLS 2008 SELinux Proposals for review and comments
To: Dave Quigley <dpquigl@tycho.nsa.gov>, fedora-selinux-list@redhat.com,
        selinux@tycho.nsa.gov, SELinux Team <selinux-team@tycho.nsa.gov>
In-Reply-To: <1201540014.24702.331.camel@moss-terrapins.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <95379.74891.qm@web36608.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Dave Quigley <dpquigl@tycho.nsa.gov> wrote:

> Hello Everyone,
>     I have put together a series of proposals for OLS this year which
> include a talk on Labeled-NFS, an SELinux BOF, and an SELinux tutorial.
> You will find them attached to this email. If you have any
> questions/comments/and or complaints please feel free to make them.
> 
> Dave Quigley
> > BOF: NSA Security-Enhanced Linux (SELinux)
> The NSA Security-Enhanced Linux (SELinux) BOF is intended to provide a
> forum for people who are already working on SELinux or are interested in
> learning about the project. The BOF will begin with a short presentation
> that briefly describes the background and status of SELinux, reviews
> recent developments, and discusses current directions for the project.  Then
> the BOF will be opened for discussion, including questions and feedback from
> developers and users.
> 
> Likely topics will include: policy development environment and
> policy generation tools, SELinux administration, Distro integration, network
> storage support and usability issues.
> > SELinux is the most widly deployed system for Mandatory Access Controls
(MAC)
> in Linux. Since its debut much has changed as distributions continue to add
> functionality based on user feedback. Despite its growing availability some
> people dismiss SELinux because it is "too hard." This tutorial addresses
> these concerns by providing a basic understanding of SELinux and how to
> accomplish common SELinux tasks.
> 
> Topics:
> How SELinux Works
> Enabling SELinux
> Checking for Unconfined Demons
> Debugging SELinux Policy Errors
> Using Booleans
> SELinux Daemons and What They Do
> Policy Development
> Considering SELinux in your Development Process
> 
> Time: 4 hours
> > As the use of SELinux expands in Enterprise environments customers are
> requesting the ability to use SELinux with their NFS based network storage.
> The labeled-nfs project seeks to extend the NFSv4 protocol to provide a
> generic mechanism for conveying process and file MAC security attribute
> information for use by security mechanisms employed on the client and 
> server.
> 
> In this paper we explore the design and implementation for the labeled-nfs
> effort. We discuss why certain design decisions were made and what impact
> they have on the implementation of NFS in the Linux kernel and NFS userland
> infrastructure.  Finally we discuss how parts of the labeled-nfs
> infrastructure can be used in other remote file systems.  

Looks like a fun set of presentations. Is the any interest in an
LSM user's summit, or a tutorial comparing LSMs?



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
