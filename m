Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA17464
	for <selinux@tycho.nsa.gov>; Tue, 19 Mar 2002 12:49:17 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA02158
	for <selinux@tycho.nsa.gov>; Tue, 19 Mar 2002 17:48:12 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id RAA02139 for <selinux@tycho.nsa.gov>; Tue, 19 Mar 2002 17:48:08 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: file_contexts
Date: Tue, 19 Mar 2002 18:48:53 +0100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0203190852330.2799-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0203190852330.2799-100000@raven>
MIME-Version: 1.0
Message-Id: <20020319174854.18E9E2387@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 19 Mar 2002 15:08, Stephen Smalley wrote:
> > I think that the reasonable use of the sample domains/programs/*.te files
> > is to remove the ones that don't apply to your system.
> >
> > After removing unwanted *.te files and loading the policy I then can't
> > run setfiles.
>
> Even ignoring the setfiles problem, you are still likely to encounter
> problems with removing unwanted domain .te files due to interactions among
> domains.

True.  However the reduction of auditing work given by removing unwanted 
policy files should more than make up for the amount of work involved in 
editing a few of the policy files to remove references to those removed files.

> To some degree, we can reduce this problem by relocating some of
> the rules and by using type attributes in some cases to better encapsulate
> each domain.  But we can't completely eliminate such inter-domain
> dependencies.

Yes, that's not a big deal IMHO.  Someone who doesn't want to edit any policy 
files can install the complete example policy.  But I think that someone who 
doesn't want to edit policy files would be best advised to either pay someone 
else to do it for them or to not use SE Linux.  If someone wants a small 
increase in security with little work then GR Security or one of the other 
patches to add security features to the kernel will probably better suit 
their needs.

> > To solve this problem I am thinking of modifying the setfiles program to
> > make it silently (unless in verbose mode) ignore any lines that refer to
> > a type that's not in policy.  So for example if I remove the policy file
> > for ppp then after running setfiles /usr/sbin/pppd will have sbin_t
> > instead of pppd_exec_t.
> >
> > What do you think?
>
> I'm uneasy about the lack of any error checking in that case (e.g. someone
> makes a typo in file_contexts).

That's something I was concerned about too, but an option to check the 
file_contexts file should make it easy enough to catch them.

> David Wheeler suggested a while back that
> we partition file_contexts into a collection of files, like the policy,
> that are merged together during the build, with each file corresponding to
> one of the domain .te files.  He suggested the convention of a foo.fc file
> (fc == file context) for each foo.te file.  The challenge in that case is
> ensuring that the ordering dependencies of file_contexts are preserved.

I think that the solution is to remove the need for ordering dependencies!

If you change the definition of the format to not have the regex's 
automatically be right-anchored (which requires inserting '$' at appropriate 
places in the current fc file) then you can check for the regular expression 
which gives the largest rm_eo value!

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
