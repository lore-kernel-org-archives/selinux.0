Subject: Re: [ SEPOL/SEMANAGE ] Boolean record
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   jbrindle@tresys.com
In-Reply-To: <43308255.6080007@cornell.edu>
References: <200509202048.j8KKm4Ys001478@gotham.columbia.tresys.com>
	 <43308255.6080007@cornell.edu>
Content-Type: text/plain
Date: Wed, 21 Sep 2005 10:35:32 -0400
Message-Id: <1127313332.2550.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-20 at 17:42 -0400, Ivan Gyurdiev wrote:
> Other issues: will you be merging the handle stuff soon? I need the 
> handle to implement any kind of error reporting in my code (because 
> otherwise I'd just be changing interfaces later). I think I'll likely 
> submit a patch with the record engine stuff, and comment out all the 
> DEBUG calls to be fixed later.

Changing interfaces later isn't a problem (yet).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
