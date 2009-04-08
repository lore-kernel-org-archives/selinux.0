Subject: Re: Running snmpd in a different domain
From: Bandan Das <bandan.das@stratus.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1239194632.3427.2.camel@localhost.localdomain>
References: <1239141949.17983.120.camel@BSD.mno.stratus.com>
	 <1239194632.3427.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 08 Apr 2009 11:55:00 -0400
Message-Id: <1239206100.17983.129.camel@BSD.mno.stratus.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> 
> Change the pathname regex to:
> /etc/rc\.d/init\.d/ftp-snmp
> 
> (/etc/init.d is a symlink to /etc/rc.d/init.d, and "." is a regex
> metacharacter)
> 

Yup, that did it! Thanks!

-- 
BSD


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
