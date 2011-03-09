Subject: Re: libselinux version bump past 99
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>,
        Stephen Lawrence
 <slawrence@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <4D76AD1C.8080901@tycho.nsa.gov>
References: <4D76AD1C.8080901@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Mar 2011 08:06:02 -0500
Message-ID: <1299675962.4884.7.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-03-08 at 17:26 -0500, Eamon Walsh wrote:
> Libselinux has reached version 2.0.99 and I need to push a bug fix, just checking to make sure 2.0.100 is fine and won't cause any problems e.g. with upgrades.

Shouldn't be a problem.  However, it does raise the question of when
we'll move to 2.1.0.  If the version string consists of
major.minor.revision, then possibly we should be incrementing minor and
resetting revision whenever there is a new release on
userspace.selinuxproject.org?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
