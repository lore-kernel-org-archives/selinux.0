Subject: Re: Running programs from a PHP script under SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Simon Gornall <simon@gornall.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <F2C51318-DBA7-49F0-BE5F-7A591238ADD8@gornall.net>
References: <840CEAA7-85D1-4C5B-8B8D-B8E55AB217A7@gornall.net>
	 <1131981045.5415.103.camel@moss-spartans.epoch.ncsc.mil>
	 <F2C51318-DBA7-49F0-BE5F-7A591238ADD8@gornall.net>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 07:16:54 -0500
Message-Id: <1132057014.5415.309.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-11-14 at 21:44 -0800, Simon Gornall wrote:
> Hmm - in this case it reports '-', which would seem to suggest the  
> stack isn't executable...
> 
> # execstack -q `which fortune`
> - /usr/bin/fortune

Hmm...how about ldd /usr/bin/fortune?  And then apply execstack -q on
each of the listed .so files.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
