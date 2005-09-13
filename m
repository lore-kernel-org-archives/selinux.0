Subject: Re: New ideas on implementation on libsetrans.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   Darrel Goeddel <dgoeddel@TrustedCS.com>, SELinux <SELinux@tycho.nsa.gov>,
   Nalin Dahyabhai <nalin@redhat.com>
In-Reply-To: <43273782.7070600@redhat.com>
References: <43271BDA.3060403@redhat.com> <43272C09.3050105@trustedcs.com>
	 <43272E92.4060400@redhat.com>
	 <1126641222.29303.235.camel@moss-spartans.epoch.ncsc.mil>
	 <432730B2.8090005@redhat.com>
	 <1126641983.29303.249.camel@moss-spartans.epoch.ncsc.mil>
	 <43273782.7070600@redhat.com>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 16:32:43 -0400
Message-Id: <1126643563.2940.6.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-13 at 16:33 -0400, Daniel J Walsh wrote:
> If no one is listening on  the socket or the socket does not exist you 
> get the same behavior.

You get the same behavior (i.e. no translation), but the client-side
code for the communication and caching is still in libselinux.  Whereas
with it in libsetrans, you don't have that problem.  You just don't ship
a libsetrans, and libselinux gracefully proceeds when the dlopen fails.

Further, in the case where you do have translation, when you want to
modify that translation protocol, you don't have to touch libselinux at
all.

> I see packaging problems and requiring objects to link with -dl.  We are 
> basically looking at a packaging problem
> now, which is why we are bringing this up. 

I understand the issue with prelink due to being statically linked, but
how many programs that link with libselinux are statically linked?
Even /sbin/init is dynamically linked (surprisingly to me when I first
noticed it long ago in Red Hat Linux).

> I have added Nalin to the message to get his comments.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
