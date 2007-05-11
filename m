Subject: Re: [PATCH -trunk] newrole: enable use of alternate pam
	configurations for running applications in a different context (Was: Re:
	launching apps at level (MLS) and polyinstantiation)
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Ted X Toth <txtoth@gmail.com>, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
In-Reply-To: <1178651473.6056.101.camel@moss-spartans.epoch.ncsc.mil>
References: <463243E3.2060602@gmail.com>
	 <1177700491.3357.113.camel@moss-spartans.epoch.ncsc.mil>
	 <1177700749.3357.116.camel@moss-spartans.epoch.ncsc.mil>
	 <463360B0.7020106@gmail.com>
	 <1177934887.16232.7.camel@moss-spartans.epoch.ncsc.mil>
	 <4636002F.5000100@gmail.com>
	 <1177944754.16232.28.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40705020849o3f1b90c4l6f7bb5d9dcbc3c23@mail.gmail.com>
	 <1178125027.3443.67.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40705030611l532d490dr2016dbff69a51628@mail.gmail.com>
	 <1178200148.3443.166.camel@moss-spartans.epoch.ncsc.mil>
	 <1178219938.3443.209.camel@moss-spartans.epoch.ncsc.mil>
	 <463B81F3.7030802@gmail.com>
	 <1178306629.677.17.camel@moss-spartans.epoch.ncsc.mil>
	 <463B9448.40007@gmail.com>
	 <1178651473.6056.101.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 11 May 2007 14:42:26 -0400
Message-Id: <1178908946.11064.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-05-08 at 15:11 -0400, Stephen Smalley wrote:
> From: 	Ted X Toth <txtoth@gmail.com>
> 
> With some modifications by Stephen Smalley <sds@tycho.nsa.gov>.
> 
> Extend newrole to enable use of alternate pam configurations when
> running an application in a different context.  Introduces
> /etc/selinux/newrole_pam.conf as a config file mapping application
> pathnames to pam service names when the application is invoked via
> newrole.  In the absence of the config file or the absence of a
> matching entry, falls back to the standard newrole pam configuration.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> 

Merged into trunk and policyrep.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
