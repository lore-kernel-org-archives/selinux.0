Subject: Re: [ SEMANAGE ] Enable things for testing, add missing set relay
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <4360F880.10605@cornell.edu>
References: <4360F880.10605@cornell.edu>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 15:42:55 -0400
Message-Id: <1130442175.18805.344.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-27 at 11:55 -0400, Ivan Gyurdiev wrote:
> Patch 1: (mistakenly sent off-list)  (enable_dbase1)
> - enable users, seusers, and booleans for testing
> 
> Patch 2: (set_relay)
> - add missing relay for set function

Thanks, merged as of libsemanage 1.3.37.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
