Subject: Re: sepolgen fixes.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Karl MacMillan <kmacmill@redhat.com>
In-Reply-To: <45DB0BED.5050205@redhat.com>
References: <45DB0BED.5050205@redhat.com>
Content-Type: text/plain
Date: Wed, 21 Feb 2007 12:22:33 -0500
Message-Id: <1172078553.14363.286.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 09:55 -0500, Daniel J Walsh wrote:
>     Change to Makefile to get proper python library path even on 64 bit 
> platforms.
>     Empty or poorly formated interface files cause sepol-ifgen to crash. 

Thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
