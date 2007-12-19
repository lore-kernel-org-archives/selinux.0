Subject: Re: Propper labeling of files under /var/www
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1198004134.11568.4.camel@moss-spartans.epoch.ncsc.mil>
References: <1198003507.3705.15.camel@localhost6.localdomain6>
	 <1198004134.11568.4.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 19 Dec 2007 10:13:05 +0000
Message-Id: <1198059185.3342.3.camel@localhost6.localdomain6>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-12-18 at 13:55 -0500, Stephen Smalley wrote:
[...]
> Try restorecon -FRv /var/www

Yeah that solved the problem. The -F option is a little bit tricky ;-)
Never expected something like that.

Thanks

Stefan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
