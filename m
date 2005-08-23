Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7NDwJOb028114
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 09:58:19 -0400 (EDT)
Subject: Re: libselinux category patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: James Morris <jmorris@redhat.com>, Darrel Goeddel <dgoeddel@TrustedCS.com>,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <430A33E5.1030100@redhat.com>
References: <430A33E5.1030100@redhat.com>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 09:45:58 -0400
Message-Id: <1124804758.7874.46.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-08-22 at 16:21 -0400, Daniel J Walsh wrote:
> libselinux-rhat.patch is mainly tcs's patch with a couple of changes. 
> 
> One eliminate MLS from the checking.  No reason why this has to be MLS 
> specific.
> Change mlstrans.c to trans.c.  See above.
> Allow context functions to handle null range.
>     In MCS I want to translate X:Y:Z:s0 to X:Y:Z, That way we can 
> introduce MCS policy to targeted without the user
> seeing any change.
> A couple of minor changes.
> 
> setrans.c is the library code
> 
> I am attaching the translation library code I am going to throw in for 
> MCS handling.  Basically translates
> c1=PatientRecord
> I have called the file /etc/secat.conf, tried to put it in 
> /etc/selinux/secat.conf, but suddenly lots of domains wanted to read 
> selinux_config_t files.

- Putting it directly under /etc makes it harder to protect differently
than any other top-level /etc file.  On the other hand, it is very much
like a passwd file lookup for mapping uids to usernames for e.g. ls, ps,
and friends.
- Placing it outside of /etc/selinux makes sense if it is not considered
part of the SELinux policy, and is consistent with the ultimate goal of
being able to manage it via LDAP or similar means.  But it does raise
the question of what owns this file, and how it gets set up initially,
e.g. one might want different default for MCS vs. MLS.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
