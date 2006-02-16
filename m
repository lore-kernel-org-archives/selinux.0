Subject: Re: [SEMANAGE/SEPOL] Nodes: fix bug, and add netmask ordering
	support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43F42612.2050907@cornell.edu>
References: <43F42612.2050907@cornell.edu>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 13:56:40 -0500
Message-Id: <1140116200.12655.160.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-16 at 02:13 -0500, Ivan Gyurdiev wrote:
> Changelog:
> - fix bug in ipv4 address expansion for nodes - the ipv4 address is 4 
> bytes long, not 1
> Otherwise the addresses that get printed make no sense at all.
> (bug probably left from when I had it using integer arrays).
> 
> - change the comparator for nodes to order on netmask first, and addr 
> second, which matches our goals
> 
> - implement a qsort run (MODE_SORT) in the function that merges local 
> records into policy. Enable that for nodes. The run sorts in ascending 
> order, according to the record's comparator function (but the order ends 
> up being descending once the records are merged one by one).
> 
> This also restructures most of the merge code - previously we did list() 
> when clearing obsolete records, and then had an iterator for merging 
> them into policy. This changes the code so we do exactly one list() 
> call. Then sorting, clearing obsoletes, and merging things into policy 
> all use the same resultant array. There's no more calls to iterate().

Merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
