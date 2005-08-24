Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7OESJOb006803
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2005 10:28:19 -0400 (EDT)
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7OEGZ8A023210
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2005 14:16:53 GMT
Message-ID: <430C820B.3090905@trustedcs.com>
Date: Wed, 24 Aug 2005 09:19:55 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Daniel J Walsh <dwalsh@redhat.com>, James Morris <jmorris@redhat.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libselinux category patch
References: <430A33E5.1030100@redhat.com> <1124804758.7874.46.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1124804758.7874.46.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2005-08-22 at 16:21 -0400, Daniel J Walsh wrote:
>>I am attaching the translation library code I am going to throw in for 
>>MCS handling.  Basically translates
>>c1=PatientRecord
>>I have called the file /etc/secat.conf, tried to put it in 
>>/etc/selinux/secat.conf, but suddenly lots of domains wanted to read 
>>selinux_config_t files.
> 
> - Putting it directly under /etc makes it harder to protect differently
> than any other top-level /etc file.  On the other hand, it is very much
> like a passwd file lookup for mapping uids to usernames for e.g. ls, ps,
> and friends.
> - Placing it outside of /etc/selinux makes sense if it is not considered
> part of the SELinux policy, and is consistent with the ultimate goal of
> being able to manage it via LDAP or similar means.  But it does raise
> the question of what owns this file, and how it gets set up initially,
> e.g. one might want different default for MCS vs. MLS.
> 

We (TCS) are including the label translation files under /etc/selinux
(protected at system high as selinux_config_t) because we view this as part of
the SELinux configuration.  This works for us because we have a daemon which is
the single user of this file other than the security admin.  Our libsetrans is
simply a communication library to the daemon.  If the file is read directly by
users of libselinux, it needs to be protected in such a way that everyone who
can make a call into libselinux can read the file.  Note that we have a similar
issue regarding users of libselinux - they must be able to contact the daemon.
We have created a policy macro for things that use our daemon via libselinux.
Perhaps we should introduce an attribute that identifies users of libselinux.
This attribute can then be used to grant read access to the config file in
RedHat's case and access to the daemon in our case.
Any thoughts on that?  Maybe 'privsetrans'?

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
