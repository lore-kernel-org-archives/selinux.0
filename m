Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4C4076o028690
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 00:00:07 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4C406k1010531
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 04:00:06 GMT
Received: by wr-out-0506.google.com with SMTP id 57so265440wri
        for <selinux@tycho.nsa.gov>; Thu, 11 May 2006 21:00:06 -0700 (PDT)
Message-ID: <a9951d2a0605112100m6fde2b40u70b68619fa578111@mail.gmail.com>
Date: Fri, 12 May 2006 12:00:06 +0800
From: "Rogelio Serrano" <rogelio.serrano@gmail.com>
To: russell@coker.com.au
Subject: Re: pam_namespace
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200605120909.11178.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200605051623.25533.russell@coker.com.au>
	 <a9951d2a0605110645v42cb9987ucb697d866cae8960@mail.gmail.com>
	 <200605120909.11178.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 5/12/06, Russell Coker <russell@coker.com.au> wrote:
> On Thursday 11 May 2006 23:45, "Rogelio Serrano" <rogelio.serrano@gmail.com>
> wrote:
> > separate namespaces is somewhat similar to selinux/dte and clashes
> > with it. i dont think we can mix selinux with separate namespaces as
> > it is right now.
>
> Separate namespaces have no similarity or overlap in functionality with SE
> Linux.
>
> All that separate namespaces offer is a different set of mounted file systems.
> No protection against IPC based attacks, no control over what is actually
> done to files in the filesystems in questions, etc.
>
> SE Linux does not support hiding of file names.  If the name of a file is
> considered to be secret data (IE the output of "ls" is considered to be
> secret) then copying that file to /tmp (which may be done without the
> knowledge of the user by an editor creating a temporary buffer file with a
> derived name) would break the confidentiality controls we want to have on the
> system.
>
> To solve this we have separate namespaces for processes that need to have
> isolated copies of /tmp.  The idea is that if user A creates the
> file /tmp/X.txt where X is secret then user B will see a different version
> of /tmp where there is no X.txt file.
>
> Another problem is the issue of DOS attacks.  If a program uses a fixed
> file/directory name then a hostile process that first creates an object with
> that name (either with restrictive permissions or creating a directory where
> a file is expected) can prevent the process from running.  SE Linux can
> prevent programs from following hostile sym-links, writing to files created
> by hostile users, and most race-condition attacks on non-administrative
> processes, but it can't prevent the same operations from becoming DOS
> attacks - in fact many attacks that would violate system integrity or data
> confidentiality on non-SE systems become DOS attacks on SE systems.
>
> Fedora Rawhide has just got PAM version 0.99.4.0-1 in which namespace works
> (the previous version didn't).  Please try configuring a SE Linux system with
> pam_namespace, you'll find that it works and provides some benefits that SE
> Linux alone can not provide.
>

Well i agree.

We can go beyond just customizing /tmp though. We can hide /sbin from
ordinary users and we can hide some of the files from /etc and we can
actually have each user have their own passwd file. we can hide almost
all files from /dev. We can actually hide any file or directory we
want. I played with a custom init a while ago that did all this. I did
not think linux people want to step outside unix though so i killed
the project.

-- 
www.smsglobal.net SMS Global Ltd Short Message Service For Seafarers


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
