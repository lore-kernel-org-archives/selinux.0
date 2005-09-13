Subject: Re: New ideas on implementation on libsetrans.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <43271BDA.3060403@redhat.com>
References: <43271BDA.3060403@redhat.com>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 14:59:58 -0400
Message-Id: <1126637998.29303.214.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-13 at 14:35 -0400, Daniel J Walsh wrote:
> After some discussion, we want to change the translation library into a 
> long running daemon with a unix domain socket that libselinux can talk 
> to for translation.  This eliminates the need to use dlopen, and link 
> with -dl. 

I'm not sure that the dlopen is a real issue.  You could implement the
client-side communication with the daemon within libsetrans, i.e.
libsetrans becomes a generic library that connects to the daemon and
caches the mappings to reduce performance overhead on context
translation.  libselinux could still dlopen libsetrans and fall back to
no translation in the absence of it.  Then you don't need per-policy
versions of libsetrans, just of the daemon (or its configuration at
least).  Isn't that what TCS was doing anyway?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
