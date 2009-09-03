Message-ID: <4A9F199B.7090507@tycho.nsa.gov>
Date: Wed, 02 Sep 2009 21:19:23 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: disable refcounting in the userspace AVC
References: <4A9DE7FE.9000008@tycho.nsa.gov> <1251892824.2785.83.camel@moss-pluto.epoch.ncsc.mil> <06A6610D4F464D4EBEAFBF2C5F86911E014599D7@exchange2.columbia.tresys.com> <1251899679.2785.101.camel@moss-pluto.epoch.ncsc.mil> <06A6610D4F464D4EBEAFBF2C5F86911E01459A64@exchange2.columbia.tresys.com>
In-Reply-To: <06A6610D4F464D4EBEAFBF2C5F86911E01459A64@exchange2.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09/02/2009 12:35 PM, Joshua Brindle wrote:
>
> Ok, seems fair.
>    

Pushed to libselinux 2.0.86, with manpage updates.  As Steve noted, this 
doesn't affect multithread or locking.   It just reduces complexity 
(especially on the caller's side) at the cost of memory usage from SID's 
potentially building up in the sidtab.

-- 
Eamon Walsh<ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
