Subject: Re: Writing system policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: shubhamsaxena1@30gigs.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <ac4af8688d501900a59460625d2f99a4@imap.30gigs.com>
References: <ac4af8688d501900a59460625d2f99a4@imap.30gigs.com>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 07:45:59 -0500
Message-Id: <1142340359.3713.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-03-13 at 21:47 -0600, shubhamsaxena1@30gigs.com wrote:
> Hi,
> 
> I am new to SELinux. Can anybody please help me by telling me how to
> go about writing policies for a system?
> Thanx in advance.

You would typically start from an existing policy (either the one
included in your distribution if your distribution has SELinux support
integrated or the original example policy or the newer reference policy)
as your baseline, and extend/modify/prune it as desired or needed.
Various resources that you might find helpful are linked from
http://selinux.sourceforge.net/resources.php3

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
