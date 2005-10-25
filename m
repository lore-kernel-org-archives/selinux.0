Subject: Re: [ SEPOL 6 ] Fix all the bugs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <435E5771.8000606@cornell.edu>
References: <435A7614.8000706@cornell.edu>
	 <1130243871.17609.269.camel@moss-spartans.epoch.ncsc.mil>
	 <435E5771.8000606@cornell.edu>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 13:04:50 -0400
Message-Id: <1130259890.17609.349.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-25 at 12:04 -0400, Ivan Gyurdiev wrote:
> The same ordering approach may not be maintained in other backends. Even 
> currently the file linked list is reversed every time the file is read, 
> making this scheme not work for local files. I suppose I could change 
> it, but I think there's better ways to solve the problem than rely on 
> ordering - ordering is fragile.

Manual ordering is fragile, but checkpolicy and libsemanage/libsepol
could explicitly order the list by specificity, as checkpolicy already
does for node contexts (that also originally relied on the specified
order, but was later enhanced by TCS to explicitly order the entries by
specificity).  In any event, putting a more specific range earlier in
the list and letting it take precedence seems far cleaner to me than
splitting the existing range.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
