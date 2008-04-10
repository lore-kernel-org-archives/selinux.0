From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Enabling policy capabilities
Date: Thu, 10 Apr 2008 10:01:23 -0400
Cc: Eric Paris <eparis@parisplace.org>, Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux@tycho.nsa.gov
References: <1207834719.21223.730.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1207834719.21223.730.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804101001.23288.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 10 April 2008 9:38:39 am Stephen Smalley wrote:
> Where do we stand on actually enabling policy capabilities in policy
> so that people can start using newer features that depend on them?
>
> I've definitely seen patches adding permissions for the peer checks,
> so is there anything preventing us from trying to enable
> network_peer_controls in policy and seeing what breaks (after Fedora
> 9 at this point, I suppose - unfortunate that we didn't enable it
> sooner)?

I still owe Chris an updated set of patches for refpolicy to put all the 
right unlabeled checks in place for the new peer controls.  There have 
been lots of patches on the lists but none have been right, yet :)

Once I get the 2.6.26 patches straightened out I'm going to work on 
those.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
