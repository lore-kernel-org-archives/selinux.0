Subject: Re: [ SEMANAGE 4 ] Order-preserving file dbase
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <43694616.3000002@cornell.edu>
References: <43694616.3000002@cornell.edu>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 14:58:15 -0500
Message-Id: <1131047895.23420.131.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-02 at 18:04 -0500, Ivan Gyurdiev wrote:
> This patch restores the doubly-linked list that I got rid of earlier, 
> and uses it to implement order-preserving flush() operation. The records 
> are printed out in the order in which they're read in. Additions go at 
> the end of the file, and queries are executed starting at the end of the 
> file, and progressing up. This gets us closer to solving The Port Problem.

All 4 patches merged as of libsepol 1.9.36 and libsemanage 1.3.41.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
