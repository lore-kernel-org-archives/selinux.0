Subject: Re: [Fwd: Unable to create files when using "context"option for
	NFS]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <42A70558.5030609@redhat.com>
References: <42A70558.5030609@redhat.com>
Content-Type: text/plain
Date: Wed, 08 Jun 2005 11:10:46 -0400
Message-Id: <1118243446.26902.137.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-06-08 at 10:48 -0400, Daniel J Walsh wrote:
> What is the best way to handle this? 
> 
> If I add a rule
> 
> allow file_type self:filesystem associate;
> 
> Will that cause and explosion in rules?  Will this open a security risk?
> 
> We tell people to use the mount -o context flags but policy can not 
> handle most of them without the above rule.

If possible, it would be preferable to enumerate the specific cases
where we want to allow such associations.  The above rule won't cause an
"explosion", as it is a self-rule and we already have various rules
involving file_type, but it isn't ideal to allow arbitrary associations
if possible.  We ultimately want to make it easy for people to be able
to separate what data types can exist on individual file systems using
this control.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
