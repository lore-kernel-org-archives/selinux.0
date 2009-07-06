Subject: Re: [Patch 2/2] libsemanage: maintain disable dontaudit state
 between handle commits
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christopher Pardy <cpardy@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <4A521E35.5000103@redhat.com>
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com>
	 <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4B9FA8.1040606@redhat.com> <4A4C168C.2040900@redhat.com>
	 <4A4C17D1.3060208@redhat.com>
	 <1246538797.13464.277.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4CBC6C.5090709@redhat.com>
	 <1246544004.13464.299.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4CC469.3050805@redhat.com>
	 <1246545328.13464.317.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4CD320.2090706@redhat.com>
	 <1246554554.13464.356.camel@moss-pluto.epoch.ncsc.mil>
	 <4A51ED89.8010001@redhat.com>  <4A51EEA5.4070802@redhat.com>
	 <1246888018.28321.23.camel@moss-pluto.epoch.ncsc.mil>
	 <1246888326.28321.26.camel@moss-pluto.epoch.ncsc.mil>
	 <4A520D47.4040708@redhat.com>  <4A52100C.3010302@redhat.com>
	 <1246892597.28321.41.camel@moss-pluto.epoch.ncsc.mil>
	 <4A52157C.8090905@redhat.com>  <4A521E35.5000103@redhat.com>
Content-Type: text/plain
Date: Mon, 06 Jul 2009 12:55:51 -0400
Message-Id: <1246899351.28321.81.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-07-06 at 11:54 -0400, Christopher Pardy wrote:
> The issue is that I need to know what the flag was set to on the last
> commit. for this I don't want to look at the sandbox where the
> inprogress files are stored I want to look at the file that gets
> written post commit. Also this functionality cannot be put into
> set_disable_dontaudit.

Ok, let me clarify how libsemanage works:
1.  Let DIR=/etc/selinux/$SELINUXTYPE/modules represent the policy
store.
2.  The files for the current, active policy live under $DIR/active/.
3.  When you start a transaction, libsemanage creates a complete copy of
$DIR/active to $DIR/tmp.
4.  For each operation you perform within the transaction, libsemanage
acts on that copy only.  If you call semanage_set_disable_dontaudit()
with a 0, then you'll remove the flag file within the copy; or if you
call it with a 1, you'll create the flag file within the copy.  If you
implement semanage_get_disable_dontaudit() by testing for the existence
of the flag file within the sandbox and it gets called by another
process in a different transaction, it will still see the current,
active setting.
5.  When you commit, libsemanage moves $DIR/active to $DIR/previous, and
moves $DIR/tmp to $DIR/active.  Now the flag file is active.

You don't need some external file for this, and you don't really want a
sepol_get_disable_dontaudit() - it only tells you the transient
in-memory setting from the last call to sepol_set_disable_dontaudit() on
the same handle.  You want to just test for the existence of the flag
file in the store.

Try it, and let me know if it doesn't actually work.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
