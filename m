From: "Remmolt Zwartsenberg" <Remmolt.Zwartsenberg@silkroadtech.com>
To: <selinux@tycho.nsa.gov>
Cc: "Ivan Gyurdiev" <ivg2@cornell.edu>, <owner-selinux@tycho.nsa.gov>
Subject: lyris test
Date: Sat, 22 Oct 2005 22:03:37 +0200
Message-ID: <EDEKJHKODGOKOIODHIAHOEAOLLAA.Remmolt.Zwartsenberg@silkroadtech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <435A8AE9.3020709@cornell.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

?

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]On
> Behalf Of Ivan Gyurdiev
> Sent: zaterdag 22 oktober 2005 20:55
> To: selinux@tycho.nsa.gov
> Cc: Stephen Smalley
> Subject: [ SEMANAGE ] Resync to sepol changes
> 
> 
> - update POLICYDB record extension to contain the functions: add, 
> modify, set, exists, iterate, and query
> - configure all tables with the appropriate functions
> - implement those functions in database_policydb.c (6 stubs removed).
> - implement database_file.c:iterate() (1 more stub)
> 
> - add more error messages, so I can tell what's going on - they can be 
> fixed later to something better.
> - change Stub status code of all print functions from STATUS_ERR to 
> STATUS_NODATA, so that the flat file parser will exit and not get stuck 
> in infinite loop recalling the stubs.
> 
> - fix bug: initialize modified to 0 in FILE database
> 
> =============
> I got commit() to start working somehow (no idea how), so now I can test 
> this.
> It _should_ commit the users file successfully... but it doesn't yet - 
> need to do some more investigation.
> I'm pretty sure it's read successfully, updated successfully, and merged 
> into policy... not sure why it doesn't commit.
> 
> I'll probably get it working pretty soon. For now, it stays #if0-ed
> 
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
