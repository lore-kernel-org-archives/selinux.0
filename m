Subject: Re: Resent with correct patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: James Antill <james.antill@redhat.com>, Steve Grubb <sgrubb@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <446B6CF8.80405@redhat.com>
References: <446AFED3.9010800@redhat.com>
	 <1147879972.3469.139.camel@code.and.org>  <446B6CF8.80405@redhat.com>
Content-Type: text/plain
Date: Wed, 17 May 2006 14:44:45 -0400
Message-Id: <1147891485.30789.393.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-17 at 14:35 -0400, Daniel J Walsh wrote:
> Updated patch with
> 
> void fini_context_translations
> 
> memory checking on strdup
> 
> CACHETRANS flag in /etc/selinux/config to turn off cacheing
> 
> Lu -> llu change
> 
> I will leave a more complete caching solution for later...  This handled
> 99.9% of the cases.

Could be a problem for multi-threaded apps, and those could easily end
up calling functions like lgetfilecon.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
