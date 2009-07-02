Message-Id: <7DB3E8B4-9FFF-4FE1-873D-1A99C6EEF0AA@gmail.com>
From: Sebastian Pfaff <sebastian.pfaff@gmail.com>
To: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <1246544997.13464.314.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: request for review of, and collaboration on SELinux models wiki entry
Date: Thu, 2 Jul 2009 17:25:14 +0200
References: <1246542053.26320.15.camel@notebook2.grift.internal> <1246544997.13464.314.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hello,

from http://selinuxproject.org/page/SELinux_models (Multi Category  
Security):

[...] Multi Category Security and Multi Level Security are mutually  
exclusive.

> - MCS and MLS are just particular configurations of constraints for  
> the
> MLS engine and thus share the same field and engine logic.  MCS was an
> attempt to make the MLS field and engine useful for general users, and
> is being leveraged by sandbox and by svirt for separating multiple
> instances of sandboxes or guest VMs.

In other words: MCS and MLS are not mutally exclusiv?! Not in SELinux  
and not in gernal? For me, MCS in SELinux is an "extra",  which  you  
can use with MLS (or MLS engine) at the same time. Please correct me,  
if i'm wrong.

Imho, MCS uses "compartments" or categories to realize the need to  
know principle and MLS uses vertical levels to achieve (at least in  
SELinux) confidentiality (BLP model). Imo compartments and levels are  
not mutally exclusive.

--
Sebastian Pfaff


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
