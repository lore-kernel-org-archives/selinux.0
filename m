MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Enabling policy capabilities
Date: Fri, 18 Apr 2008 10:21:27 -0400
Message-ID: <1208528487.1548.59.camel@gorn>
In-Reply-To: <200804101001.23288.paul.moore@hp.com>
References: <1207834719.21223.730.camel@moss-spartans.epoch.ncsc.mil> <200804101001.23288.paul.moore@hp.com>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Paul Moore" <paul.moore@hp.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Eric Paris" <eparis@parisplace.org>,
        "Daniel J Walsh" <dwalsh@redhat.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-04-10 at 10:01 -0400, Paul Moore wrote:
> On Thursday 10 April 2008 9:38:39 am Stephen Smalley wrote:
> > Where do we stand on actually enabling policy capabilities in policy
> > so that people can start using newer features that depend on them?
> >
> > I've definitely seen patches adding permissions for the peer checks,
> > so is there anything preventing us from trying to enable
> > network_peer_controls in policy and seeing what breaks (after Fedora
> > 9 at this point, I suppose - unfortunate that we didn't enable it
> > sooner)?
> 
> I still owe Chris an updated set of patches for refpolicy to put all the 
> right unlabeled checks in place for the new peer controls.  There have 
> been lots of patches on the lists but none have been right, yet :)
> 
> Once I get the 2.6.26 patches straightened out I'm going to work on 
> those.

I added a policy_capabilities file with the two existing caps commented
out.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
