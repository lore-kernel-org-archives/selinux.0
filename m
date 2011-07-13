Subject: Re: Sec context of unix domain sockets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Martin Christian <martin.christian@secunet.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4E1D99D7.1030504@secunet.com>
References: <4E11E53A.6080003@secunet.com>
	 <1310394094.3930.46.camel@moss-pluto>  <4E1C7D08.8000007@secunet.com>
	 <1310491408.309.24.camel@moss-pluto>  <4E1D99D7.1030504@secunet.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 Jul 2011 10:02:56 -0400
Message-ID: <1310565776.12491.29.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-07-13 at 15:12 +0200, Martin Christian wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi Stephen,
> 
> you pointed me into the right direction: We have a startup log daemon
> which gets replaced by syslog at the end of the boot process. The AVC
> message occurs when /dev/log still belongs to the startup log daemon.
> Thanks for your hint!
> 
> What I was missing all the time during my investigation was a tool,
> which displays the security labels of unix domain sockets. Is there
> nothing like this around? netstat doesn't seem to support selinux labels
> (an option -Z), does it? Maybe I could reserve some time in our schedule
> to add such an option to netstat.

The Fedora netstat program has a -Z option, but the implementation
appears to read the context of the owning process
(via /proc/<pid>/attr/current), not necessarily the context of the
individual socket.  Not sure you can get to that information from any
process other than the owning one without reading kernel memory.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
