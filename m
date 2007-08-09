Subject: Re: Strict policy in FC6 -  firefox does not start.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kroum Antov <kroum@voicecho.com>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <D90C04F065C24B04AEF05BDF8F8E8263@HomePC>
References: <D90C04F065C24B04AEF05BDF8F8E8263@HomePC>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 08:29:01 -0400
Message-Id: <1186662541.6916.380.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-09 at 01:23 -0700, Kroum Antov wrote:
> With Strict policy in FC6:  firefox does not start.
> There are no messages at all. So I decided to check
> if firefox works under strict policy on F7. 
> I have installed F7 and enabled strict policy. But from now on I can't
> longer login if enforcing is on . When I enter username and password
> and 
> I get "Authentication Failed" in GDM. In console I just get new
> "username" prompt.
> 
> I do not understand why firefox does not start in fc6.
> why I can not longin on F7 under strict policy?
>  
> What might be wrong?

Since Fedora ships with targeted policy by default, that is the policy
that gets tested widely and is the only policy that gets tested by Red
Hat as far as I know (except perhaps -mls, and that only for servers at
present; no X support there).  Strict policy almost always requires some
customization to make it work cleanly, which you can do by booting
permissive and examining the avc denials, although you may need to
install enableaudit.pp to see them all.  Please report the specific avc
denials though (ausearch -m AVC -sv no if running auditd or grep
avc /var/log/messages otherwise)

The good news is that targeted policy and strict policy are being merged
together such that one can migrate gradually on the continuum from
targeted policy to strict policy without completely replacing the
policy.  That is work in progress, with experimental versions in F8
IIUC.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
