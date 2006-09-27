Subject: Re: MLS and Biba
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Salvo Giuffrida <giuffsalvo@hotmail.it>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <BAY114-F93133EE31869D548BEF16AF250@phx.gbl>
References: <BAY114-F93133EE31869D548BEF16AF250@phx.gbl>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 07:34:26 -0400
Message-Id: <1159356866.32075.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-09-27 at 00:39 +0200, Salvo Giuffrida wrote:
> Good morning, is it possible to configure the MLS policy, using 
> mlsconstraint, to enforce a Biba integrity model of security (no read down, 
> no write up), instead of the Bell-LaPadula (no read up, no write down)? I'm 
> reading the book "SELinux by example", and there there's written that the 
> MLS facility in the Security Server is not very flexible, and allows only to 
> enforce the rules "no read up, no write down". But, if I'm the one 
> configuring the policy in the file "mls", shouldn't I be able to change the 
> rules to the opposite?
> Thanks a lot...

Are you referring to the statement:
"Unlike type enforcement, which is flexible and adaptable, MLS is
intended to strictly and inflexibly enforce a single security invariant
("no write down, no read up")"

That is describing the MLS/BLP model, not a limitation of the SELinux
security server.  As you note, the SELinux security server allows for
very flexible configuration of the MLS constraints, including the
ability to switch the logic as you say (but at that point it is no
longer enforcing a "MLS policy").

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
