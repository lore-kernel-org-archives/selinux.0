Subject: Re: New ideas on implementation on libsetrans.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Nalin Dahyabhai <nalin@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Karl MacMillan <kmacmillan@tresys.com>,
   Darrel Goeddel <dgoeddel@TrustedCS.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20050914192343.GA30138@redhat.com>
References: <43271BDA.3060403@redhat.com> <43272C09.3050105@trustedcs.com>
	 <43272E92.4060400@redhat.com>
	 <1126641222.29303.235.camel@moss-spartans.epoch.ncsc.mil>
	 <432730B2.8090005@redhat.com>
	 <1126641983.29303.249.camel@moss-spartans.epoch.ncsc.mil>
	 <43273782.7070600@redhat.com>
	 <1126643563.2940.6.camel@moss-spartans.epoch.ncsc.mil>
	 <4327425F.8050805@redhat.com>
	 <1126705174.12299.64.camel@moss-spartans.epoch.ncsc.mil>
	 <20050914192343.GA30138@redhat.com>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 15:51:03 -0400
Message-Id: <1126727463.12299.209.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-09-14 at 15:23 -0400, Nalin Dahyabhai wrote:
> I would disagree with that.  In giving the setrans library a soname,
> you've provided some means of making sure that you don't load an
> incompatible version of the library if the interface which that library
> provides ever differs from what libselinux expects.
> 
> If libselinux is changed to dlopen() it using a symlink which points to
> whichever version is current, then that benefit is gone.

Ok, fair point.  We'll leave it alone then (have to go and revert that
patch now...).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
