Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7F4wceQ019769
	for <selinux@tycho.nsa.gov>; Sat, 15 Aug 2009 00:58:38 -0400
Received: from smtp109.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n7F4w7Fc028007
	for <selinux@tycho.nsa.gov>; Sat, 15 Aug 2009 04:58:07 GMT
Message-ID: <4A864008.50907@schaufler-ca.com>
Date: Fri, 14 Aug 2009 21:56:40 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "David P. Quigley" <dpquigl@tycho.nsa.gov>, jmorris@namei.org,
        Stephen Smalley <sds@tycho.nsa.gov>, gregkh@suse.de,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] Security/sysfs: Enable security xattrs to be set on sysfs
 files, directories, and symlinks.
References: <1247665721-2619-1-git-send-email-dpquigl@tycho.nsa.gov>	<4A84EF1D.8060408@schaufler-ca.com> <m1my62xde6.fsf@fess.ebiederm.org>	<4A861291.1030404@schaufler-ca.com> <m1tz09j00q.fsf@fess.ebiederm.org>
In-Reply-To: <m1tz09j00q.fsf@fess.ebiederm.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric W. Biederman wrote:
> Casey Schaufler <casey@schaufler-ca.com> writes:
>
>   
>> Actually, I see that as a justification for the special purpose
>> scheme rather than a real issue. The real attribute data is going
>> to take up the same amount of space regardless of how it gets
>> managed. And Stephen is correct in thinking that is most cases
>> where there are xattrs there will be only one. I don't see that
>> a mechanism more elaborate than a list is going to gain much in
>> real life. On the other hand, if you wanted to take the ball and
>> run with it, I have a window manager to deal with.
>>     
>
> If you look at things from the point of view of a single inode I would
> have to agree that the storage costs are roughly the same however they
> get managed.
>
> My understanding is that in most inodes all get a label from
> a very small set of possible labels.
>   

Actually, my point is that most files that get xattrs get one xattr.
The set of labels will be small for a Smack system or a real world
MLS system. This is not true for SELinux, where the number of labels
in flight at any given time can be .... large.

> If that is true.  It makes sense to store the set of used labels
> separately from the inodes.  Then on the inode just store a pointer
> to the label.
>   

You have been reading the Smack code, haven't you?

> Saying this in lisp parlance we should be able to use atoms instead of
> strings.
>   

Sorry, but you're not old enough to be slinging lisp at me. (smiley)
But yes, that is an apt comparison.

> At which point we have (I believe) an implementation that is as practically
> as efficient as what was originally proposed but as general and as maintainable
> as your version.
>
> What I don't know is if the set of labels applied to a filesystem is actually
> small, despite having a large number of labels applied.
>   

The question is whether you're more concerned with the xattr behavior
or the LSM behavior. This is where the difference shows itself. If you
look at the LSM, there is one value. If you look at xattrs, there may
be many.

I personally think that the Right Thing(tm) is the xattr view. My
experience is the LSM view. I hope that we don't shut off the Right
Thing in preference to the issue of the day. I have been on both sides
on this one.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
