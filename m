Subject: Re: [ SEMANAGE 2 ] Booleans, parser fixes/improvements
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <435D9456.9070502@cornell.edu>
References: <435D9456.9070502@cornell.edu>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 09:05:00 -0400
Message-Id: <1130245500.17609.285.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-24 at 22:11 -0400, Ivan Gyurdiev wrote:
> This patch gets booleans working - well... sort of. They still aren't 
> loaded right - I think it's because genbools goes and overrides them 
> after my changes, which is not very nice. I suspect the semanage loading 
> code is working just fine - I can see the file commit code working, at 
> least.

All four patches (sepol query/exists, sepol count, semanage resync,
semanage booleans/parser) merged as of libsepol 1.9.28 and libsemanage
1.3.34.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
