From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: checkmodule error
Date: Sat, 12 Jul 2008 00:31:25 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200807112205.26358.russell@coker.com.au> <1215778833.31554.88.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1215778833.31554.88.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200807120031.27852.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 11 July 2008 22:20, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Latest refpolicy requires the user and role remapping support in order
> to move roles into modules.
> The support was added in libsepol 2.0.29 and checkpolicy 2.0.16,
> committed upstream 2008-05-27 (after Fedora 9 GA).
>
> Don't know if Dan would be willing to pull newer toolchain into F9
> (cc'd).

Thanks for the information.

I'm working on building the latest policy for Debian.  I've NMU'd those other 
packages so that I can now build the policy and will hopefully have an upload 
of the new policy soon.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
