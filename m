Subject: Re: New ideas on implementation on libsetrans.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <43272E92.4060400@redhat.com>
References: <43271BDA.3060403@redhat.com> <43272C09.3050105@trustedcs.com>
	 <43272E92.4060400@redhat.com>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 15:53:42 -0400
Message-Id: <1126641222.29303.235.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-13 at 15:54 -0400, Daniel J Walsh wrote:
> Yes we are having problems with linking against the library and having 
> different plugins to the library just doesnot feel right.

I'm still not sure what the problem is with dlopen'ing libsetrans, and
letting it take care of the communication (and caching) _if_ any
translation is desired at all.  Why bloat libselinux with that
infrastructure for people who don't want any label translation?

I understand that the attempt to dlopen a per-policytype libsetrans was
getting complicated, although I'm not sure why you couldn't just
dlopen /usr/lib/libsetrans.so symlink and use alternatives to manage
what that references outside of libselinux.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
