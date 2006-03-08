Subject: Re: libsepol/src/link.c:copy_avrule_list( )
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, SELinux <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <440EE4A8.2070700@cornell.edu>
References: <20060306214139.GA7960@sergelap.austin.ibm.com>
	 <440CE892.2060601@cornell.edu>
	 <1141826701.6157.51.camel@moss-spartans.epoch.ncsc.mil>
	 <440EE4A8.2070700@cornell.edu>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 09:40:14 -0500
Message-Id: <1141828815.6157.68.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-03-08 at 09:05 -0500, Ivan Gyurdiev wrote:
> > What is your test case (i.e. what policy)?
> >   
> Fedora strict. I don't remember this happening under targeted.

Ok, reproduced it, and it seems to be resolved by the patch I posted.
Joshua, do you concur with the patch?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
