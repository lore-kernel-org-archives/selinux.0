Subject: Re: Updated policy
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1106690203.20960.4.camel@cobra.ivg2.net>
References: <41F6A47E.9010407@redhat.com>
	 <1106690203.20960.4.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Wed, 26 Jan 2005 03:57:28 -0700
Message-Id: <1106737048.18907.2.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-01-25 at 14:56 -0700, Ivan Gyurdiev wrote:
> > Elimination of gpg execmod change.  The gpg rpm was fixed in rawhide.
> 
> Please add execmod to mozilla and X (Bug #145067).
> Mozilla needs it for flash, and X for the Nvidia driver.

Also, look at this:

audit(1106729781.687:0): avc:  denied  { execmod } for  pid=18304
comm=java path=/lib/ld-2.3.4.so dev=dm-0 ino=113630
scontext=user_u:user_r:user_t tcontext=system_u:object_r:ld_so_t
tclass=file

/usr/lib/jvm/jre-1.5.0_01-sun/bin/java

That's the Sun 1.5 JRE.


-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
