Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA4I6PiB027959
	for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2008 13:06:25 -0500
Subject: Re: SELinux on NFS.
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        "Matthew N. Dodd" <Matthew.Dodd@sparta.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <490F780E.4020806@redhat.com>
References: <490F780E.4020806@redhat.com>
Content-Type: text/plain
Date: Tue, 04 Nov 2008 12:46:17 -0500
Message-Id: <1225820777.31157.302.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-11-03 at 17:15 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> We really want to get SELinux labeled files on NFS into Fedora 11.  But
> it seems to be getting bogged down in the standards process.  I think we
> need to simplify.
> 
> All Fedora  needs for SELinux on NFS is the ability to store and enforce
> file labels from the client side on the server.  This has to work with
> full Unix authentication model (Trusted Host) as well as the full
> kerberos authentication model.
> 
> I think we can treat the server side as a dumb server.  NFS servers
> tends to fully trust the client to do the "right thing" on disk
> partitions that the server shares.  Our first version of SELinux NFS
> should do the same.  Getting bogged down in the server worrying about
> which process on the client created a file/file_label is not something
> that is necessary for the first version.  And probably not something
> that is required for the vast majority of situations for the next few
> years.  The servers will/should not have a requirement to run SELinux.
> 
> But labelled NFS on the client side has potential great benefits for us.
>  Especially with work in svirt where we want to be able to share virtual
> image files via NFS and have them isolated by SELinux.
> 
> How close are we to getting this functionality working and do you think
> the upstream kernel would accept your changes to allow this?
> 

[CCing Trond and Bruce]

Dan: To answer your question we have everything that you want already in
the prototype. In terms of getting it upstreamed Trond and Bruce want to
see some consensus from the standards body before they consider
upstreaming the code. 

Trond & Bruce: I am going to be at IETF 73 in a couple of weeks are
either of you going to be there? I'd like to have a meeting with you
about what it is that you want to see happen before mainlining. This way
we can come up with the criteria we need to meet before we can mainline
the code. If neither of you are going to be at that meeting can we
organize some sort of telecon to discuss this?

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
