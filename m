Message-ID: <1343418268.17570.95.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 1/1] allocate perms to platformappdomain over
 system_data_file
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com,
        "Craig, Robert P."
	 <rpcraig@tycho.ncsc.mil>
Date: Fri, 27 Jul 2012 15:44:28 -0400
In-Reply-To: <CAO-4OdEUaZtXx7bc7n_XWWi7DE8FJDsXEM+EfXodXH_vzwvfqw@mail.gmail.com>
References: <1343414055-3831-1-git-send-email-hqjiang1988@gmail.com>
	 <1343414258.17570.72.camel@moss-pluto.epoch.ncsc.mil>
	 <CAO-4OdF=FRiKqUhVwPeucHRrKsYWBNJiRktJJhHnNYf_=V1cwA@mail.gmail.com>
	 <1343415126.17570.82.camel@moss-pluto.epoch.ncsc.mil>
	 <CAO-4OdEq6VXhytSV1MW=PK-HCrN=epixK5HRMPi0PR-Ay0d-=A@mail.gmail.com>
	 <1343417710.17570.91.camel@moss-pluto.epoch.ncsc.mil>
	 <CAO-4OdEUaZtXx7bc7n_XWWi7DE8FJDsXEM+EfXodXH_vzwvfqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-07-27 at 12:42 -0700, Haiqing Jiang wrote:
> I don't need to modify the patch. So, could you help to update the
> patch to branches? Thanks. 

Don't quite understand what you are asking here:
- this is for sepolicy, which has no version-specific branches
(everything just feeds off of master), unlike the device trees.
- i did apply your previous patch for the sdcard accesses.  So you
should be able to amend this one.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
