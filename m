Subject: Re: [patch] add new files to policycoreutils.spec
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "'SELinux List'" <SELinux@tycho.nsa.gov>
In-Reply-To: <41F6D5BA.2030901@trustedcs.com>
References: <41F6D5BA.2030901@trustedcs.com>
Content-Type: text/plain
Message-Id: <1106759607.23386.277.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 26 Jan 2005 12:13:32 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-01-25 at 18:26, Darrel Goeddel wrote:
> Hi,
>      I noticed that building the latest policycoreutils rpm complains about 
> unpackaged files.  Here is a patch to make it happy:

Thanks, merged.  BTW, please note that the spec files in our tree are
just examples and are not really considered part of the "package".  We
typically only check them before pushing an updated release to nsa.gov,
and they may diverge from the real spec files used by Red Hat or other
distributors.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
