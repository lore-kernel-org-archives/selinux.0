Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2R4hSd6002730
	for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2008 00:43:29 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2R4hPVs022240
	for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2008 04:43:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [RFC][PATCH] user_transition support for libsepol/checkpolicy
Date: Thu, 27 Mar 2008 15:43:14 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <47E7E7A5.6090603@manicmethod.com> <1206446939.3302.139.camel@moss-spartans.epoch.ncsc.mil> <47EA0D4F.4040102@redhat.com>
In-Reply-To: <47EA0D4F.4040102@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803271543.16340.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 26 March 2008 19:46, Daniel J Walsh <dwalsh@redhat.com> wrote:
> I am not sure where this is going, but I believe that separation based
> on role in the home directory is a mistake.  It assumes that the home
> directory will always be used by the same user with the same role.   And
> will not work when you have a network file system that supports labels.
>
> In Red Hat I can login to people.redhat.com people.fedoraproject.com
> which I should use the guest_r.  While logging into my laptop I would be
> unconfined_t and on test machines I might get staff_r or user_r.  All of
> them would use the same homedirectory.  So how would this work in this
> environment?

If you have the same home directory contents (including .login, .bashrc, and 
equivalent files) and you can execute programs from the home directory, then 
how can you usefully have roles which are really different on different 
machines?

You could for example have guest_r on machine A mapping to sysadm_r on machine 
B (which I believe bears some similarity to the reclassification of documents 
when going between certain military organisations).

The idea of a network filesystem having the same labels on all machines where 
it is mounted even when there are differences in policy and/or user rights on 
those machines makes no sense to me.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
