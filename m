Subject: Re: Multiple contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux@tycho.nsa.gov
In-Reply-To: <20050112230148.GC11846@lkcl.net>
References: <20050110232312.GI6967@lkcl.net>
	 <1105474191.20566.134.camel@moss-spartans.epoch.ncsc.mil>
	 <20050111214818.GE26175@lkcl.net>
	 <1105538449.22495.8.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112144411.GZ26175@lkcl.net>
	 <1105542047.22495.69.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112181814.GD26175@lkcl.net>
	 <1105552982.22495.169.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112182954.GF26175@lkcl.net>
	 <1105565236.23136.12.camel@moss-spartans.epoch.ncsc.mil>
	 <20050112230148.GC11846@lkcl.net>
Content-Type: text/plain
Message-Id: <1105634671.24406.59.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 13 Jan 2005 11:44:31 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 18:01, Luke Kenneth Casson Leighton wrote:
>  2 ) even if they did chcon -t "F1,F2" foobar, you would still expect
>      them to be doing that as an "interim" measure whilst they were
>      testing something _pending_ formal analysis by putting that
>      into the policy files.

BTW, idle question:  how do you decide whether to allow setting such
combinations on a file?  What happens if a file already has a
combination - how do you decide whether or not you can change those
settings?  Simply allowing it if you can relabel any one of the types is
obviously broken...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
