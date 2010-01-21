Date: Thu, 21 Jan 2010 15:44:09 +0300
From: AlannY <m@alanny.ru>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Policy is not managed or store cannot be accessed
Message-ID: <20100121123749.GA17342@alanny-pc.lcl.starlink.ru>
References: <20100120202135.GA6124@alanny-pc.lcl.starlink.ru>
 <1264020386.24133.182.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1264020386.24133.182.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Did you build your policy with MONOLITHIC=n in build.conf?
> If not, then you need to do that if you want modular/managed policy.

Yes, you are right. I've completely forgot about it.

Thanks. This problem is solved.

-- 
   )\._.,--....,'``.
  /,   _.. \   _\  (`._ ,.
 `._.-(,_..'--(,_..'`-.;.' 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
