Subject: Re: [ SEMANAGE ] Redesign dbase
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, kmacmillan@tresys.com, dwalsh@redhat.com
In-Reply-To: <43323EF2.20201@cornell.edu>
References: <43320A2E.5000906@cornell.edu> <4332121F.2010904@cornell.edu>
	 <43323EF2.20201@cornell.edu>
Content-Type: text/plain
Date: Fri, 23 Sep 2005 10:35:06 -0400
Message-Id: <1127486107.27851.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-09-22 at 01:19 -0400, Ivan Gyurdiev wrote:
> Allright, here's the same patch again, with the query issue fixed.
> Also, I've implemented the function which creates the cache (main 
> processing loop),
> and renamed some things. I've clarified the specification for
> record.parse(), and added some things to parse_info structure.

Thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
