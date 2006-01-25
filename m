Subject: Re: password policy question
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JANAK DESAI <janak@us.ibm.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <43D7939B.3010701@us.ibm.com>
References: <43D7939B.3010701@us.ibm.com>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 11:40:13 -0500
Message-Id: <1138207213.13075.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-01-25 at 10:04 -0500, JANAK DESAI wrote:
> Hello,
> 
> I am looking at the serefpolicy-2.2.2 (downloaded this morning from 
> fedora core
> development SRPMS) and am trying to figure out how, in an mls 
> environment, a
> user logged in at anything other s0 would be able to change his/her 
> password. I
> expected to see a "typeattribute passwd_t mlsfilewrite" in the 
> monolithic policy.conf
> file that I generated. What am I missing?

Is that really what you want?  It would allow a high process to
downgrade information via the passwd file.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
