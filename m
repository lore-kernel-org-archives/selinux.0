Subject: Re: More  small fixes to policycoreutils
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4561E7B2.9030205@redhat.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885C79BC@exchange.columbia.tresys.com>
	 <455CE2F3.3070200@mentalrootkit.com> <455DA4E8.5050600@redhat.com>
	 <4561E1A3.8070306@mentalrootkit.com>  <4561E7B2.9030205@redhat.com>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 16:13:11 -0500
Message-Id: <1164143591.13758.128.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-11-20 at 12:36 -0500, Daniel J Walsh wrote:
> Lastly are you going to merge the translations? 
> 
> http://people.redhat.com/dwalsh/SELinux/pocicycoreutils-po.patch

I merged this set of po file updates, but I'm hoping that there is some
better way to deal with them.  For example, after applying this patch
and merging it, running make in policycoreutils immediately regenerates
the files yet again with another round of changes (POT-Creation-Date
headers and line numbers in the comment annotations).  So should I
commit that as well?  I don't know how the po files are typically
maintained in other projects.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
