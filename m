Subject: Re: Permissive types
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: selinux List <selinux@tycho.nsa.gov>
In-Reply-To: <74D8EBBB-C370-48A5-B793-4C998D448FA6@nall.com>
References: <74D8EBBB-C370-48A5-B793-4C998D448FA6@nall.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 01 Jun 2010 09:21:56 -0400
Message-ID: <1275398516.2924.27.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2010-05-30 at 16:34 -0500, Joe Nall wrote:
> Is there a way to disable permissive types completely?
> 
> Is there a way to disable the making of specific types permissive?
> 
> Is there any notification when a type is made permissive via avc_add_callback?

Not presently.  You could of course create a policy validator ala:
http://selinuxproject.org/page/PolicyValidate
but using seinfo --permissive to determine what types are permissive, or
rolling your own program that uses libsepol or libqpol (from setools) to
check for permissive types.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
