Subject: Re: SELOPT  vs. DSI
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: amine.baina@ensi-bourges.fr
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <2307.172.20.2.19.1085470857.squirrel@ldap.ensi-bourges.fr>
References: <2307.172.20.2.19.1085470857.squirrel@ldap.ensi-bourges.fr>
Content-Type: text/plain
Message-Id: <1085497172.30578.107.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 25 May 2004 10:59:32 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-05-25 at 03:40, amine.baina@ensi-bourges.fr wrote:
> hello everybody,
> 
> once we had install selinux on the principal node of this cluster
> what is the most interesting way to distribute security (selinux security)
> on this cluster
> 
> selopt or DSI

The status of Selopt has been discussed previously, most recently in
http://marc.theaimsgroup.com/?l=selinux&m=108429008704548&w=2.  DSI is
orthogonal to SELinux AFAIK, but I think they also depended on
networking security fields and hooks in LSM that were not accepted into
the mainline kernel.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
