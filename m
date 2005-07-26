Subject: Re: MLS dominance
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Frank Mayer <mayerf@tresys.com>
Cc: "'SELinux'" <SELinux@tycho.nsa.gov>
In-Reply-To: <200507201419.j6KEJSvx025003@gotham.columbia.tresys.com>
References: <200507201419.j6KEJSvx025003@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 26 Jul 2005 09:27:52 -0400
Message-Id: <1122384472.4470.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-07-20 at 10:19 -0400, Frank Mayer wrote:
> Is there any reason why the dominance statement (the MLS flavor) doesn't end
> with a semicolon like most others? Frank

No particular reason; it just didn't present any ambiguity in the parser
to not include an explicit terminator there.  There are other statements
that likewise lack such terminators.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
